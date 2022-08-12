classdef PassSimulation
    %PassSimulation Simulation of a QKD satellite pass
    %   an object which contains all of the contents of a simulation of a
    %   satellite pass

    properties (SetAccess=protected, Hidden=false)
        Satellite Satellite;                                               %satellite simulation object
        Protocol Protocol = BB84_Protocol.empty;                           %protocol to be used for QKD
        Ground_Station Ground_Station;                                     %receiver simulation object
        Link_Model Link_Model = Satellite_Link_Model;                      %object which holds link properties over the pass

        Background_Sources Background_Source;                              %array of background light pollution sources to be simulated

        Any_Communication_Flag=false;                                      %flag describing whether or not communication took place
        Elevation_Viability_Flag=false;                                    %flag describing whether the satellite passes through the elevation window of the receiver

        Total_Sifted_Key=0;                                                %how much sifted data is downlinked over the whole pass
    end
    properties(SetAccess=protected, Hidden=true)
        Headings=[];                                                   %heading of satellite relative to OGS in deg
        Elevations=[];                                                 %elevation of satellite relative to OGS in deg
        Times=[];                                                      %time of each point of link simulation in s
        Link_Losses_dB=[];                                               %link loss of this pass in dB
        Background_Count_Rates=[];                                     %background count rate from detector and light pollution in cps
        Secret_Key_Rates=[];                                           %secret key rate in bits/s. SKR is nan outside of the elevation window and 0 when no link is achieved within this window
        QBERs=[];                                                      %quantum bit error rate during pass
        Communicating_Flags=false(0,0);                                 %flag describing whether communication is happening
        Elevation_Limit_Flags=false(0,0);                               %flag describing whether the satellite is in the elevation field of the OGS
    end


    methods
        function PassSimulation = PassSimulation(Satellite,Protocol,Ground_Station,varargin)
            %PASSSIMULATION Construct an instance of a PassSimulation


            %% create and use an input parser
            P=inputParser();
            %required inputs
            addRequired(P,'Satellite');
            addRequired(P,'Protocol');
            addRequired(P,'Ground_Station');
            %optional inputs
            addParameter(P,'Background_Sources',Background_Source.empty);
            %parse inputs
            parse(P,Satellite,Protocol,Ground_Station,varargin{:});

            PassSimulation.Satellite = P.Results.Satellite;
            PassSimulation.Ground_Station = P.Results.Ground_Station;
            PassSimulation.Protocol=P.Results.Protocol;

            if ~IsSourceCompatible(Protocol,Satellite.Source)
                error('satellite source is not compatible with %s protocol',Protocol.Name);
            end
            if ~IsDetectorCompatible(Protocol,Ground_Station.Detector)
                error('Ground station detector is not compatible with %s protocol',Protocol.Name);
            end
            if ~isequal(Satellite.Source.Wavelength,Ground_Station.Detector.Wavelength)
                error('satellite and ground station must use the same wavelength')
            end
            %if background sources are provided, add them
            PassSimulation.Background_Sources=P.Results.Background_Sources;


        end

        function PassSimulation = Simulate(PassSimulation)
            %SIMULATE Peform the simulation with the components of PassSimulation

            %% load in data
            %satellite data
            N_Steps=PassSimulation.Satellite.N_Steps;
            PassSimulation.Times=PassSimulation.Satellite.Times;

            %% set number of steps in simulation
            PassSimulation=Set_N_Steps(PassSimulation,N_Steps);
            PassSimulation.Link_Model=Satellite_Link_Model(N_Steps);


            %% Compute background count rate and link heading and elevation
            [Background_Count_Rates,Ground_Station,Headings,Elevations]=ComputeTotalBackgroundCountRate(PassSimulation.Ground_Station,PassSimulation.Background_Sources,PassSimulation.Satellite);
            PassSimulation.Ground_Station=Ground_Station;

            %% Check elevation limit
            Elevation_Limit_Flags=Elevations>PassSimulation.Ground_Station.Elevation_Limit;
            %Check that satellite rises above elevation limit at some point
            if ~any(Elevation_Limit_Flags)
                error('satellite does not enter elevation window of ground station');
            end


            %% Compute Link loss
            Computed_Link_Models=Compute_Link_Loss(PassSimulation.Link_Model,PassSimulation.Satellite,PassSimulation.Ground_Station);
            PassSimulation.Link_Model=Computed_Link_Models;

            %store loss data
            PassSimulation.Link_Losses_dB=GetLinkLossdB(PassSimulation.Link_Model);

            %% compute SKR and QBER for links inside the elevation window
            [Computed_Sifted_Key_Rates,Computed_QBERs]=EvaluateQKDLink(PassSimulation.Protocol,PassSimulation.Satellite.Source,PassSimulation.Ground_Station.Detector,[Computed_Link_Models(Elevation_Limit_Flags).Link_Loss_dB],[Background_Count_Rates(Elevation_Limit_Flags)]);

            %store this step's data
            PassSimulation.Secret_Key_Rates(Elevation_Limit_Flags)=Computed_Sifted_Key_Rates;
            PassSimulation.QBERs(Elevation_Limit_Flags)=Computed_QBERs;
            PassSimulation.Communicating_Flags=~(isnan(PassSimulation.Secret_Key_Rates)|PassSimulation.Secret_Key_Rates<=0);
            PassSimulation.Elevation_Limit_Flags=Elevation_Limit_Flags;


            %% post-processing
            PassSimulation.Headings=Headings;
            PassSimulation.Elevations=Elevations;
            PassSimulation.Background_Count_Rates=Background_Count_Rates; %#ok<*PROP>
            PassSimulation.Any_Communication_Flag=any(PassSimulation.Communicating_Flags);
            PassSimulation.Elevation_Viability_Flag=any(PassSimulation.Elevation_Limit_Flags);
            %compute total data downlink
            %first produce a vector of time bin widths
            Downlink_Time_Windows=PassSimulation.Times(PassSimulation.Communicating_Flags(1:end-1))-PassSimulation.Times([PassSimulation.Communicating_Flags(2:end),false]);
            %the dot with sifted data rate
            if ~isempty(Downlink_Time_Windows)
                if isduration(Downlink_Time_Windows)
                PassSimulation.Total_Sifted_Key=dot(seconds(Downlink_Time_Windows),PassSimulation.Secret_Key_Rates(PassSimulation.Communicating_Flags(1:end-1)));
                elseif isnumeric(Downlink_Time_Windows)
                PassSimulation.Total_Sifted_Key=dot(Downlink_Time_Windows,PassSimulation.Secret_Key_Rates(PassSimulation.Communicating_Flags(1:end-1)));
                else
                    error('Downlink time windows must be either duration or numeric array')
                end
           else
                PassSimulation.Total_Sifted_Key=0;
            end
        end

        function plot(PassSimulation,Range)
            %% PLOT plot data from this PassSimulation, according to the keyword Range:
            %EMPTY=plot while satellite is in elevation window
            %Elevation=plot while satellite is in elevation window
            %Communication=plot while satellite is communicating
            %All= plot whole pass

            if nargin==1 %default is elevation
                Range='Elevation';
            end
            switch Range
                case 'Elevation'
                    Plot_Select_Flags=PassSimulation.Elevation_Limit_Flags;
                    if ~any(PassSimulation.Elevation_Limit_Flags)
                        error('satellite does not pass through the elevation window of this site')
                    end

                case 'Communication'
                    Plot_Select_Flags=PassSimulation.Communicating_Flags;
                    if ~any(PassSimulation.Communicating_Flags)
                        warning('no communication happens on this pass')
                    end
                case 'All'
                    Plot_Select_Flags=true(size(PassSimulation.Communicating_Flags));
                otherwise
                    error('Range keyword can be "Elevation", "Communication" or "All"')
            end

            %% plot ground path of satellite
            figure('name',['Pass Simulation using ',PassSimulation.Protocol.Name,' protocol'],'WindowState','maximized')
            subplot(4,4,[9,14])
            title('Satellite Ground Path')
            %plot non-flagged path (no comms or out of elevation range)
            geoplot(PassSimulation.Satellite.Latitude(~Plot_Select_Flags),PassSimulation.Satellite.Longitude(~Plot_Select_Flags),'b-','LineWidth',0.5)
            hold('on');
            %then plot flagged path
            geoplot(PassSimulation.Satellite.Latitude(Plot_Select_Flags),PassSimulation.Satellite.Longitude(Plot_Select_Flags),'g-','LineWidth',1)
            legend('Satellite Path',[Range,' window'],'Location','southwest')
            %determine satellite altitude for plotting lines of sight
            Satellite_Altitude=mean(PassSimulation.Satellite.Altitude);

            %plot ground station
            PlotLOS(PassSimulation.Ground_Station,Satellite_Altitude);

            %then plot sources of interference
            if ~isempty(PassSimulation.Background_Sources)
                for i=1:numel(PassSimulation.Background_Sources)
                    PlotLOS(PassSimulation.Background_Sources(i),Satellite_Altitude)
                end
            end

            %% plot the status during comms above one another
            subplot(4,4,[1,3])
            % plot performance
            yyaxis left
            plot(PassSimulation.Times(Plot_Select_Flags),PassSimulation.Secret_Key_Rates(Plot_Select_Flags));
            xlabel('Time (s)')
            ylabel('Secret Key Rate (bits/s)')
            text(mean(PassSimulation.Times(Plot_Select_Flags)),mean(PassSimulation.Secret_Key_Rates(Plot_Select_Flags)),sprintf('total secret key\ntransfered=%3.2g',PassSimulation.Total_Sifted_Key),'VerticalAlignment','bottom','HorizontalAlignment','center')
            % plot QBER
            yyaxis right
            plot(PassSimulation.Times(Plot_Select_Flags),PassSimulation.QBERs(Plot_Select_Flags));
            ylabel('QBER')
            % plot background counts
            subplot(4,4,[4,8])
            title('background count rate')
            PlotBackgroundCountRates(PassSimulation.Ground_Station,Plot_Select_Flags,PassSimulation.Times(Plot_Select_Flags));
            xlabel('Time (s)')
            ax=gca; %put axis on right
            ax.YAxisLocation='right';
            clear ax;
            % plot link loss
            subplot(4,4,[5,7])
            title('Link loss')
            Plot(PassSimulation.Link_Model(Plot_Select_Flags),PassSimulation.Times(Plot_Select_Flags));

            %% plot key rate as a function of link loss
            subplot(4,4,[11,16])
            title('Link performance')
            semilogy(GetLinkLossdB(PassSimulation.Link_Model),PassSimulation.Secret_Key_Rates,'k-')
            xlabel('Link loss (dB)')
            ylabel('Secret Key Rate (bps)')
            grid on
            ax=gca; %put axis on right
            ax.YAxisLocation='right';
            clear ax;
        end

        function PassSimulation = Set_N_Steps(PassSimulation,N_Steps)
            %%SET_N_STEPS set the data storage in PassSimulation to the
            %%correct size
            PassSimulation.Headings=Set_to_a_Length(PassSimulation.Headings,N_Steps,'zero');
            PassSimulation.Elevations=Set_to_a_Length(PassSimulation.Elevations,N_Steps,'zero');
            PassSimulation.Link_Losses_dB=Set_to_a_Length(PassSimulation.Link_Losses_dB,N_Steps,'zero');
            PassSimulation.Background_Count_Rates=Set_to_a_Length(PassSimulation.Background_Count_Rates,N_Steps,'zero');
            PassSimulation.Secret_Key_Rates=Set_to_a_Length(PassSimulation.Secret_Key_Rates,N_Steps,'zero');
            PassSimulation.QBERs=Set_to_a_Length(PassSimulation.QBERs,N_Steps,'zero');
            PassSimulation.Communicating_Flags=Set_to_a_Length(PassSimulation.Communicating_Flags,N_Steps,'false');
            PassSimulation.Elevation_Limit_Flags=Set_to_a_Length(PassSimulation.Elevation_Limit_Flags,N_Steps,'false');
        end

        function SetWavelength(PassSimulation,Wavelength)
            %%SETWAVELENGTH change the wavelength (in nm) the simulated
            %%communication uses
            SetWavelength(PassSimulation.Satellite,Wavelength);
        end

        function Total_Sifted_Key=GetTotalSiftedKey(PassSimulation)
            %%GETTOTALSIFTEDKEY return simulated total downlink data
            Total_Sifted_Key=PassSimulation.Total_Sifted_Key;
        end

        function Up_Time=GetUpTime(PassSimulation)
            %%GETUPTIME return the total time in which communication occurs

            Time_Intervals=PassSimulation.Times(2:end)-PassSimulation.Times(1:end-1);
            Communicating_Time_Intervals=Time_Intervals(PassSimulation.Communicating_Flags(1:end));
            Up_Time=sum(Communicating_Time_Intervals);
        end

        function Loss_dB=GetLinkLossdB(PassSimulation)
            %%GETLINKLOSSDB return the loss (in dB) experienced over a pass
            Loss_dB=GetLinkLossdB(PassSimulation.Link_Model);
        end

        function BCR=GetBCR(PassSimulation)
            %%GETBCR return the background count rate (in cps) experienced
            %%during a pass
            BCR=PassSimulation.Background_Count_Rates;
        end

        function Times=GetTimes(PassSimulation)
            %%GETTIMES return the time indices (in s) over a pass
            Times=PassSimulation.Times;
        end
    end
end