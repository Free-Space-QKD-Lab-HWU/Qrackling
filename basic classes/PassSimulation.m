classdef PassSimulation
    %PassSimulation Simulation of a QKD satellite pass
    %   an object which contains all of the contents of a simulation of a
    %   satellite pass

    properties (SetAccess = protected, Hidden = false)
        %satellite simulation object
        QKD_Transmitter QKD_Transmitter = Satellite.empty;

        %protocol to be used for QKD
        Protocol;

        %receiver simulation object
        QKD_Receiver QKD_Receiver = Ground_Station.empty;

        %object which holds link properties over the pass
        Link_Model (1, 1);   %must be singular

        %array of background light pollution sources to be simulated
        Background_Sources;

        %tag identifying what atmospheric visibility to model
        Visibility {mustBeText} = 'clear';

        %flag describing whether or not communication took place
        Any_Communication_Flag = false;

        %flag describing whether the satellite passes through the elevation window of the receiver
        Elevation_Viability_Flag = false;

        %how much sifted data is communicated over the whole pass
        Total_Sifted_Key = 0;

        %heading of satellite relative to OGS in deg
        Headings = [];

        %elevation of satellite relative to OGS in deg
        Elevations = [];

        %time of each point of link simulation in s
        Times = [];

        %Link loss in dB
        Link_Losses_dB = [];

        %background count rate from detector and light pollution in cps
        Background_Count_Rates = [];

        %secret key rate in bits/s. SKR is nan outside of the elevation window and 0 when no link is achieved within this window
        Secret_Key_Rates = [];

        %quantum bit error rate during pass
        QBERs = [];

        %flag describing whether communication is happening
        Communicating_Flags = false(0, 0);

        %flag describing whether the satellite is in the elevation field of the OGS
        Elevation_Limit_Flags = false(0, 0);

        %flag describing whether a downlink beacon is being simulated
        Downlink_Beacon_Flag = false;

        %power of the downlink beacon which is received
        Downlink_Beacon_Power = [];

        %signal to noise ratio (in dB) of the downlink beacon
        Downlink_Beacon_SNR_dB = [];

        %link model describing loss from beacon on satellite to intensity at the ground
        Downlink_Beacon_Link_Model {mustBeScalarOrEmpty};


        %flag describing whether a downlink beacon is being simulated
        Uplink_Beacon_Flag = false;
        %power of the downlink beacon which is received
        Uplink_Beacon_Power = [];
        %signal to noise ratio (in dB) of the downlink beacon
        Uplink_Beacon_SNR_dB = [];
        %link model describing loss from beacon on satellite to intensity at the ground
        Uplink_Beacon_Link_Model {mustBeScalarOrEmpty};
        %flag describing whether the link from satellite to ground station is above the horizon
        Line_Of_Sight_Flags = false(0, 0);

        Rates_In ;
        Rates_Det;

        % SMARTS configuration
        smarts_configuration SMARTS_input;

        %Link direction flag
        % TODO Change this to make use of an enum and update other flags accordingly
        Link_Direction{mustBeMember(Link_Direction, {'Up', 'Down', ''})} = '';
    end

    properties
        extra_counts = [];
    end


    methods
        function PassSimulation = PassSimulation(QKD_Transmitter, Protocol, QKD_Receiver, varargin)
            %PASSSIMULATION Construct an instance of a PassSimulation

            %% create and use an input parser
            P = inputParser();
            %required inputs
            addRequired(P, 'QKD_Transmitter');
            addRequired(P, 'Protocol');
            addRequired(P, 'QKD_Receiver');
            %optional inputs
            addParameter(P, 'SMARTS', []);
            addParameter(P, 'Background_Sources', []);
            addParameter(P, 'Visibility', 'clear');

            %parse inputs
            parse(P, QKD_Transmitter, Protocol, QKD_Receiver, varargin{:});

            PassSimulation.QKD_Transmitter = P.Results.QKD_Transmitter;
            PassSimulation.QKD_Receiver = P.Results.QKD_Receiver;
            PassSimulation.Protocol = P.Results.Protocol;
            PassSimulation.Visibility = P.Results.Visibility;

            % assert(IsSourceCompatible(Protocol, QKD_Transmitter.Source), ...
            %     'satellite source is not compatible with %s protocol', Protocol.Name);
            % assert(IsDetectorCompatible(Protocol, QKD_Receiver.Detector), ...
            %     'Ground station detector is not compatible with %s protocol', Protocol.Name);

            check = Protocol.compatibleSource(QKD_Transmitter.Source);
            check = Protocol.compatibleDetector(QKD_Receiver.Detector);

            assert(isequal(QKD_Transmitter.Source.Wavelength, QKD_Receiver.Detector.Wavelength), ...
                'satellite and ground station must use the same wavelength');
                %decide on direction
                if isa(QKD_Transmitter, 'Satellite')&&isa(QKD_Receiver, 'Ground_Station')
                    PassSimulation.Link_Direction = 'Down';
                elseif isa(QKD_Transmitter, 'Ground_Station')&&isa(QKD_Receiver, 'Satellite')
                    PassSimulation.Link_Direction = 'Up';
                else
                    error('must have transmitter and receiver cover both of Satellite and Ground_Station')
                end
            %if background sources are provided, add them
            PassSimulation.Background_Sources = P.Results.Background_Sources;

            if ~isempty(P.Results.SMARTS)
                PassSimulation.smarts_configuration = P.Results.SMARTS;
            end
        end

        function PassSimulation = setExtraCounts(PassSimulation, extra_counts)
            PassSimulation.extra_counts = extra_counts;
        end

        function PassSimulation = Simulate(PassSimulation, Count_Map)
            %SIMULATE Peform the simulation with the components of PassSimulation


            %p = inputParser();
            %addParameter(p, 'Count_Map', []);
            %parse(p, PassSimulation, varargin{:});
            
            %perform correct one of up or down link. UPLINK is given
            %preference. Both cannot be performed (yet)
            switch PassSimulation.Link_Direction
                case 'Up'

                PassSimulation = SimulateUplink(PassSimulation);
                case 'Down'

                PassSimulation = SimulateDownlink(PassSimulation);
                otherwise
                error('must have satellite and ground station support either uplink or downlink')
            end
        end

        function plot(PassSimulation, Range)
            %% PLOT plot data from this PassSimulation, according to the keyword Range:
            %EMPTY = plot while satellite is in elevation window
            %Elevation = plot while satellite is in elevation window
            %Communication = plot while satellite is communicating
            %All = plot whole pass

            if nargin == 1 %default is elevation
                Range = 'Elevation';
            end
            switch Range
                case 'Elevation'
                    Plot_Select_Flags = PassSimulation.Elevation_Limit_Flags;
                    if ~any(PassSimulation.Elevation_Limit_Flags)
                        error('satellite does not pass through the elevation window of this site')
                    end

                case 'Communication'
                    Plot_Select_Flags = PassSimulation.Communicating_Flags;
                    if ~any(PassSimulation.Communicating_Flags)
                        warning('no communication happens on this pass')
                    end
                case 'All'
                    Plot_Select_Flags = true(size(PassSimulation.Communicating_Flags));
                otherwise
                    error('Range keyword can be "Elevation", "Communication" or "All"')
            end

            %% plot ground path of satellite
            switch PassSimulation.Link_Direction
                case 'Up'
                    Satellite = PassSimulation.QKD_Receiver;
                    Ground_Station = PassSimulation.QKD_Transmitter;
                case 'Down'
                    Satellite = PassSimulation.QKD_Transmitter;
                    Ground_Station = PassSimulation.QKD_Receiver;
            end

            Fig = figure('name', strjoin(['Pass Simulation using ', string(PassSimulation.Protocol.QKD_protocol), ' protocol at ', num2str(PassSimulation.QKD_Transmitter.Source.Wavelength), 'nm']), 'WindowState', 'maximized');
            subplot(3, 3, [3, 6])

            title('Satellite Ground Path')
            %plot non-flagged path (no comms or out of elevation range)
            geoplot(Satellite.Latitude, Satellite.Longitude, 'b-', 'LineWidth', 0.5)
            hold('on');
            %then plot flagged path
            geoplot(Satellite.Latitude(Plot_Select_Flags), Satellite.Longitude(Plot_Select_Flags), 'g-', 'LineWidth', 1)
            legend('Satellite Path', [Range, ' window'], 'Location', 'southwest')
            %determine satellite altitude for plotting lines of sight
            Satellite_Altitude = mean(Satellite.Altitude);

            %plot ground station
            PlotLOS(Ground_Station, Satellite_Altitude);

            %then plot sources of interference
            if ~isempty(PassSimulation.Background_Sources)
                for i = 1:numel(PassSimulation.Background_Sources)
                    PlotLOS(PassSimulation.Background_Sources(i), Satellite_Altitude)
                end
            end

            %% plot the status during comms above one another
            subplot(3, 3, [1, 2])
            % plot performance
            yyaxis left
            plot(PassSimulation.Times(Plot_Select_Flags), PassSimulation.Secret_Key_Rates(Plot_Select_Flags));
            NameTimeAxis(PassSimulation.Times);
            ylabel('SKR (bits/s)')
            text(0.5, 0.5, sprintf('total secret key\ntransfered = %3.2g', PassSimulation.Total_Sifted_Key), 'Units', 'Normalized', 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'center')
            xlim([ ...
                min(PassSimulation.Times(Plot_Select_Flags)), ...
                max(PassSimulation.Times(Plot_Select_Flags)) ...
                ]);
            % plot QBER
            yyaxis right
            plot(PassSimulation.Times(Plot_Select_Flags), PassSimulation.QBERs(Plot_Select_Flags).*100);
            NameTimeAxis(PassSimulation.Times);
            ylabel('QBER (%)')
            % plot background counts
            subplot(3, 3, [7, 8])
            title('BCR (counts/s)')
            PlotBackgroundCountRates(PassSimulation.QKD_Receiver, Plot_Select_Flags, PassSimulation.Times);
            NameTimeAxis(PassSimulation.Times);
            xlim([ ...
                min(PassSimulation.Times(Plot_Select_Flags)), ...
                max(PassSimulation.Times(Plot_Select_Flags)) ...
                ]);
            % plot link loss
            subplot(3, 3, [4, 5])
            title('Link Loss')
            Plot(PassSimulation.Link_Model, PassSimulation.Times, Plot_Select_Flags);
            NameTimeAxis(PassSimulation.Times);
            xlim([ ...
                min(PassSimulation.Times(Plot_Select_Flags)), ...
                max(PassSimulation.Times(Plot_Select_Flags)) ...
                ]);

            %% plot key rate as a function of link loss
            subplot(3, 3, [9, 9])
            title('Link performance')
            semilogy(PassSimulation.Link_Losses_dB(Plot_Select_Flags), PassSimulation.Secret_Key_Rates(Plot_Select_Flags), 'k-')
            xlabel('Link Loss (dB)')
            ylabel('Secret Key Rate (bps)')
            xlim([ ...
                min(PassSimulation.Link_Losses_dB(Plot_Select_Flags)), ...
                max(PassSimulation.Link_Losses_dB(Plot_Select_Flags)) ...
                ]);
            grid on
            ax = gca; %put axis on right
            ax.YAxisLocation = 'right';
            clear ax;

            %% if present, plot downlink beacon performance as a function of time.
            if PassSimulation.Downlink_Beacon_Flag
                % expand a new figure
                BeaconFig = figure('name', 'Downlink Beacon'); %#ok<NASGU>
                %first, plot intensity as a function of time
                subplot(3, 1, 1)
                plot(PassSimulation.Times(PassSimulation.Line_Of_Sight_Flags), PassSimulation.Downlink_Beacon_Power(PassSimulation.Line_Of_Sight_Flags));
                ylabel('Beacon Power (W)')
                NameTimeAxis(GetTimes(PassSimulation));

                %then, plot link loss
                subplot(3, 1, 2)
                Plot(PassSimulation.Downlink_Beacon_Link_Model, PassSimulation.Times, PassSimulation.Line_Of_Sight_Flags);
                NameTimeAxis(PassSimulation.Times);

                %finally, plot SNR
                subplot(3, 1, 3)
                plot(PassSimulation.Times(PassSimulation.Line_Of_Sight_Flags), PassSimulation.Downlink_Beacon_SNR_dB(PassSimulation.Line_Of_Sight_Flags));
                NameTimeAxis(PassSimulation.Times);
                ylabel('SNR (dB)');
            end

            %% if present, plot uplink beacon performance as a function of time.
            if PassSimulation.Uplink_Beacon_Flag
                % expand a new figure
                BeaconFig = figure('name', 'Uplink Beacon'); %#ok<NASGU>
                %first, plot intensity as a function of time
                subplot(3, 1, 1)
                plot(PassSimulation.Times(PassSimulation.Line_Of_Sight_Flags), PassSimulation.Uplink_Beacon_Power(PassSimulation.Line_Of_Sight_Flags));
                ylabel('Beacon Power (W)')
                NameTimeAxis(GetTimes(PassSimulation));

                %then, plot link loss
                subplot(3, 1, 2)
                Plot(PassSimulation.Uplink_Beacon_Link_Model, PassSimulation.Times, PassSimulation.Line_Of_Sight_Flags);
                NameTimeAxis(PassSimulation.Times);

                %finally, plot SNR
                subplot(3, 1, 3)
                plot(PassSimulation.Times(PassSimulation.Line_Of_Sight_Flags), PassSimulation.Uplink_Beacon_SNR_dB(PassSimulation.Line_Of_Sight_Flags));
                NameTimeAxis(PassSimulation.Times);
                ylabel('SNR (dB)');
            end

            function NameTimeAxis(Times)
                %%NAMETIMEAXIS consistently name the time axis with units of
                %%seconds if it is numeric or without if it is datetime
                if ~isdatetime(Times)
                    xlabel('Time (s)')
                else
                    xlabel('')
                end
            end
        end

        function PassSimulation = Set_N_Steps(PassSimulation, N_Steps)
            %%SET_N_STEPS set the data storage in PassSimulation to the
            %%correct size
            PassSimulation.Headings = Set_to_a_Length(PassSimulation.Headings, N_Steps, 'zero');
            PassSimulation.Elevations = Set_to_a_Length(PassSimulation.Elevations, N_Steps, 'zero');
            PassSimulation.Link_Losses_dB = Set_to_a_Length(PassSimulation.Link_Losses_dB, N_Steps, 'zero');
            PassSimulation.Background_Count_Rates = Set_to_a_Length(PassSimulation.Background_Count_Rates, N_Steps, 'zero');
            PassSimulation.Secret_Key_Rates = Set_to_a_Length(PassSimulation.Secret_Key_Rates, N_Steps, 'zero');
            PassSimulation.QBERs = Set_to_a_Length(PassSimulation.QBERs, N_Steps, 'zero');
            PassSimulation.Communicating_Flags = Set_to_a_Length(PassSimulation.Communicating_Flags, N_Steps, 'false');
            PassSimulation.Elevation_Limit_Flags = Set_to_a_Length(PassSimulation.Elevation_Limit_Flags, N_Steps, 'false');
        end

        function SetWavelength(PassSimulation, Wavelength)
            %%SETWAVELENGTH change the wavelength (in nm) the simulated
            %%communication uses
            SetWavelength(PassSimulation.Satellite, Wavelength);
        end

        function Total_Sifted_Key = GetTotalSiftedKey(PassSimulation)
            %%GETTOTALSIFTEDKEY return simulated total downlink data
            Total_Sifted_Key = PassSimulation.Total_Sifted_Key;
        end

        function Up_Time = GetUpTime(PassSimulation)
            %%GETUPTIME return the total time in which communication occurs

            Time_Intervals = PassSimulation.Times(2:end)-PassSimulation.Times(1:end-1);
            Communicating_Time_Intervals = Time_Intervals(PassSimulation.Communicating_Flags(1:end));
            Up_Time = sum(Communicating_Time_Intervals);
        end

        function Loss_dB = GetLinkLossdB(PassSimulation)
            %%GETLINKLOSSDB return the loss (in dB) experienced over a pass
            Loss_dB = GetLinkLossdB(PassSimulation.Link_Model);
        end

        function BCR = GetBCR(PassSimulation)
            %%GETBCR return the background count rate (in cps) experienced
            %%during a pass
            BCR = PassSimulation.Background_Count_Rates;
        end

        function Times = GetTimes(PassSimulation)
            %%GETTIMES return the time indices (in s) over a pass
            Times = PassSimulation.Times;
        end

        function SKR = GetSecretKeyRates(PassSimulation)
            %%GETSECRETKEYRATES return the secret key rate (in bits/s) over a
            %%pass
            SKR = PassSimulation.Secret_Key_Rates;
        end

        function PassSimulation = SimulateDownlink(PassSimulation)

            %p = inputParser();
            %addParameter(p, 'Count_Map', []);
            %parse(p, PassSimulation, varargin{:});

            %%SIMULATEDOWNLINK simulate a pass assuming a downlink configuration

            %% break out components
             [Satellite, Protocol, Ground_Station, ...
                Background_Sources, smarts_configuration, ...
                Visibility] = Unpack(PassSimulation); %#ok<*PROP> 

            %% check that correct hardware is in place
            assert(~isempty(Satellite.Source), 'For downlink, satellite must have a source');
            assert(~isempty(Ground_Station.Detector), 'For downlink, ground station must have a detector');

            %% load in data
            %satellite data
            N_Steps = Satellite.N_Steps;
            Times = Satellite.Times;
            %% set number of steps in simulation
            Downlink_Model = Satellite_Downlink_Model(N_Steps, Visibility);

            %% Compute background count rate and link heading and elevation
            [Headings, Elevations, Ranges] = RelativeHeadingAndElevation(Satellite, Ground_Station);
            [Background_Count_Rates, Ground_Station] = ComputeTotalBackgroundCountRate(Ground_Station, Background_Sources, Satellite, Headings, Elevations, smarts_configuration);
            PassSimulation.QKD_Receiver = Ground_Station; %need to store OGS details for beacon modelling
            %% Check elevation limit
            Line_Of_Sight_Flags = Elevations>0;
            %Check that satellite rises above horizon at some point
            assert(any(Line_Of_Sight_Flags), ...
                'satellite is never visible from ground station');

            Elevation_Limit_Flags = Elevations>Ground_Station.Elevation_Limit;
            %Check that satellite rises above elevation limit at some point
            assert(any(Elevation_Limit_Flags), ...
                'satellite does not enter elevation window of ground station');

            %% Beaconing
            PassSimulation = SimulateBeaconing(PassSimulation);


            %% Compute Link loss
            Downlink_Model = Compute_Link_Loss(Downlink_Model, Satellite, Ground_Station);

            %% compute SKR and QBER for links inside the elevation window
            %[Computed_Sifted_Key_Rates, Computed_QBERs] = EvaluateQKDLink(...
            [Computed_Sifted_Key_Rates, Computed_QBERs, Rates_In, Rates_Det] = EvaluateQKDLink(...
                Protocol, Satellite.Source, ...
                Ground_Station.Detector, ...
                [Downlink_Model.Link_Loss_dB(Elevation_Limit_Flags)], ...
                [Background_Count_Rates(Elevation_Limit_Flags)]);

            %store this step's data
            Secret_Key_Rates(Elevation_Limit_Flags) = Computed_Sifted_Key_Rates;
            QBERs(Elevation_Limit_Flags) = Computed_QBERs;
            Communicating_Flags = ~(isnan(Secret_Key_Rates)|Secret_Key_Rates <= 0);

            %% post-processing
            Link_Losses_dB = [Downlink_Model.Link_Loss_dB];
            Any_Communication_Flag = any(Communicating_Flags);
            Elevation_Viability_Flag = any(Elevation_Limit_Flags);
            %compute total data downlink
            %first produce a vector of time bin widths
            Downlink_Time_Windows = Times(Communicating_Flags)-Times([Communicating_Flags(2:end), false]);

            %the dot with sifted data rate
            if ~isempty(Downlink_Time_Windows)&&isnumeric(Downlink_Time_Windows)
                Total_Sifted_Key = dot(Downlink_Time_Windows, Secret_Key_Rates(Communicating_Flags));

            elseif ~isempty(Downlink_Time_Windows)&&isduration(Downlink_Time_Windows)
                Total_Sifted_Key = dot(seconds(Downlink_Time_Windows), Secret_Key_Rates(Communicating_Flags));
            else
                Total_Sifted_Key = 0;
            end


            %% return components
            PassSimulation = Pack(PassSimulation, Satellite, Protocol, Ground_Station, ...
                                    Background_Sources, smarts_configuration, Visibility);
            %store data
            PassSimulation.Times = Times;
            PassSimulation.Headings = Headings;
            PassSimulation.Elevations = Elevations;
            PassSimulation.Link_Losses_dB = Link_Losses_dB;
            PassSimulation.Link_Model = Downlink_Model;
            PassSimulation.Background_Count_Rates = Background_Count_Rates;
            PassSimulation.Any_Communication_Flag = Any_Communication_Flag;
            PassSimulation.Elevation_Viability_Flag = Elevation_Viability_Flag;
            PassSimulation.Secret_Key_Rates = Secret_Key_Rates;
            PassSimulation.QBERs = QBERs;
            PassSimulation.Communicating_Flags = Communicating_Flags;
            PassSimulation.Elevation_Limit_Flags = Elevation_Limit_Flags;
            PassSimulation.Line_Of_Sight_Flags = Line_Of_Sight_Flags;
            PassSimulation.Rates_In = Rates_In;
            PassSimulation.Rates_Det = Rates_Det;
            PassSimulation.Total_Sifted_Key = Total_Sifted_Key;
        end
        
        function PassSimulation = SimulateUplink(PassSimulation)
            %%SIMULATEUPLINK simulate a pass assuming an uplink configuration

            %% break out components
             [Ground_Station, Protocol, Satellite, ...
                Background_Sources, smarts_configuration, ...
                Visibility] = Unpack(PassSimulation); %#ok<*PROP> 

            %% check that correct hardware is in place
            assert(~isempty(Satellite.Detector), 'For uplink, satellite must have a detector');
            assert(~isempty(Ground_Station.Source), 'For uplink, ground station must have a source');

            %% load in data
            %satellite data
            N_Steps = Satellite.N_Steps;
            Times = Satellite.Times;
            %% set number of steps in simulation
            Uplink_Model = Satellite_Uplink_Model(N_Steps, Visibility);

            %% Compute background count rate and link heading and elevation
            [Headings, Elevations, Ranges] = RelativeHeadingAndElevation(Satellite, Ground_Station);
            [Background_Count_Rates, Satellite] = ComputeTotalBackgroundCountRate(Satellite, Background_Sources, Ground_Station, Headings, Elevations, smarts_configuration);
            PassSimulation.QKD_Receiver = Satellite; %need to store satellite details for beacon modelling
            %% Check elevation limit
            Line_Of_Sight_Flags = Elevations>0;
            %Check that satellite rises above horizon at some point
            assert(any(Line_Of_Sight_Flags), ...
                'satellite is never visible from ground station');

            Elevation_Limit_Flags = Elevations>Ground_Station.Elevation_Limit;
            %Check that satellite rises above elevation limit at some point
            assert(any(Elevation_Limit_Flags), ...
                'satellite does not enter elevation window of ground station');

            %% Beaconing
            PassSimulation = SimulateBeaconing(PassSimulation);

            %% Compute Link loss
            Uplink_Model = Compute_Link_Loss(Uplink_Model, Satellite, Ground_Station);

            %% compute SKR and QBER for links inside the elevation window
            %[Computed_Sifted_Key_Rates, Computed_QBERs] = EvaluateQKDLink(...
            [Computed_Sifted_Key_Rates, Computed_QBERs, Rates_In, Rates_Det] = EvaluateQKDLink(...
                Protocol, Ground_Station.Source, ...
                Satellite.Detector, ...
                [Uplink_Model.Link_Loss_dB(Elevation_Limit_Flags)], ...
                [Background_Count_Rates(Elevation_Limit_Flags)]);

            %store this step's data
            Secret_Key_Rates(Elevation_Limit_Flags) = Computed_Sifted_Key_Rates;
            QBERs(Elevation_Limit_Flags) = Computed_QBERs;
            Communicating_Flags = ~(isnan(Secret_Key_Rates)|Secret_Key_Rates <= 0);

            %% post-processing
            Link_Losses_dB = [Uplink_Model.Link_Loss_dB];
            Any_Communication_Flag = any(Communicating_Flags);
            Elevation_Viability_Flag = any(Elevation_Limit_Flags);
            %compute total data downlink
            %first produce a vector of time bin widths
            Downlink_Time_Windows = Times(Communicating_Flags)-Times([Communicating_Flags(2:end), false]);

            %the dot with sifted data rate
            if ~isempty(Downlink_Time_Windows)&&isnumeric(Downlink_Time_Windows)
                Total_Sifted_Key = dot(Downlink_Time_Windows, Secret_Key_Rates(Communicating_Flags));

            elseif ~isempty(Downlink_Time_Windows)&&isduration(Downlink_Time_Windows)
                Total_Sifted_Key = dot(seconds(Downlink_Time_Windows), Secret_Key_Rates(Communicating_Flags));
            else
                Total_Sifted_Key = 0;
            end

            %% Compute Link loss
            Uplink_Model = Compute_Link_Loss(Uplink_Model, Satellite, Ground_Station);
            %% return components
            PassSimulation = Pack(PassSimulation, Ground_Station, Protocol, Satellite, ...
                                    Background_Sources, smarts_configuration, Visibility);
            %store data
            PassSimulation.Times = Times;
            PassSimulation.Headings = Headings;
            PassSimulation.Elevations = Elevations;
            PassSimulation.Link_Losses_dB = Link_Losses_dB;
            PassSimulation.Link_Model = Uplink_Model;
            PassSimulation.Background_Count_Rates = Background_Count_Rates;
            PassSimulation.Any_Communication_Flag = Any_Communication_Flag;
            PassSimulation.Elevation_Viability_Flag = Elevation_Viability_Flag;
            PassSimulation.Secret_Key_Rates = Secret_Key_Rates;
            PassSimulation.QBERs = QBERs;
            PassSimulation.Communicating_Flags = Communicating_Flags;
            PassSimulation.Elevation_Limit_Flags = Elevation_Limit_Flags;
            PassSimulation.Line_Of_Sight_Flags = Line_Of_Sight_Flags;
            PassSimulation.Rates_In = Rates_In;
            PassSimulation.Rates_Det = Rates_Det;
            PassSimulation.Total_Sifted_Key = Total_Sifted_Key;
        end
        
        function [QKD_Transmitter, Protocol, QKD_Receiver, ...
                Background_Sources, smarts_configuration, ...
                Visibility] = Unpack(PassSimulation)
                %%UNPACK return the component objects of a pass simulation

                QKD_Transmitter = PassSimulation.QKD_Transmitter;
                Protocol = PassSimulation.Protocol;
                QKD_Receiver = PassSimulation.QKD_Receiver;
                Background_Sources = PassSimulation.Background_Sources;
                smarts_configuration = PassSimulation.smarts_configuration;
                Visibility = PassSimulation.Visibility;
        end

        function PassSimulation = Pack(PassSimulation, ...
                                        QKD_Transmitter, ...
                                        Protocol, ...
                                        QKD_Receiver, ...
                                        Background_Sources, ...
                                        smarts_configuration, ...
                                        Visibility)
            %%PACK return all of the component objects to a PassSimulation
            
            PassSimulation.QKD_Transmitter = QKD_Transmitter;
            PassSimulation.Protocol = Protocol;
            PassSimulation.QKD_Receiver = QKD_Receiver;
            PassSimulation.Background_Sources = Background_Sources;
            PassSimulation.smarts_configuration = smarts_configuration;
            PassSimulation.Visibility = Visibility;
        end

        function PassSimulation = SimulateBeaconing(PassSimulation)

            %% unpack components, dependent on link direction
            switch PassSimulation.Link_Direction
                case 'Down'
            [Satellite, ~, Ground_Station, ...
                Background_Sources, smarts_configuration, ...
                Visibility] = Unpack(PassSimulation);
                case 'Up'
            [Ground_Station, ~, Satellite, ...
                Background_Sources, smarts_configuration, ...
                Visibility] = Unpack(PassSimulation);
            end
            N_Steps = Satellite.N_Steps;

            %does the hardware support a downlink beacon?
            Downlink_Beacon_Flag = ~isempty(Satellite.Beacon)&&~isempty(Ground_Station.Camera);
            PassSimulation.Downlink_Beacon_Flag = Downlink_Beacon_Flag;

            %% Downlink beacon modelling
            if Downlink_Beacon_Flag
                % if a beacon is present, simulate the beacon channel
                [Beacon_Downlink_model, DownlinkBeaconLossdB] = ...
                    Compute_Link_Loss(Beacon_Downlink_Model(N_Steps, Visibility), ...
                    Satellite, ...
                    Ground_Station);
                %compute beacon received power
                Downlink_Beacon_Power = Satellite.Beacon.Power*10.^(-DownlinkBeaconLossdB/10);
                PassSimulation.Downlink_Beacon_Power = Downlink_Beacon_Power;

                if ~isempty(Ground_Station.Atmosphere_File_Location)||~isempty(smarts_configuration)
                %computed beacon channel noise
                Beacon_Sky_Radiance = interp1(Ground_Station.Wavelengths, ...
                    Ground_Station.Sky_Radiance', ...
                    Satellite.Beacon.Wavelength);
                Downlink_Beacon_External_Noise = Beacon_Sky_Radiance * Ground_Station.Camera.FOV;

                [Downlink_Beacon_SNR, Downlink_Beacon_SNR_dB] = SNR(Ground_Station.Camera, ...
                                                                Downlink_Beacon_Power, ...
                                                                Downlink_Beacon_External_Noise);
                else
                [Downlink_Beacon_SNR, Downlink_Beacon_SNR_dB] = SNR(Ground_Station.Camera, ...
                                                                Downlink_Beacon_Power);
                end

                PassSimulation.Downlink_Beacon_SNR_dB = Downlink_Beacon_SNR_dB;
                PassSimulation.Downlink_Beacon_Link_Model = Beacon_Downlink_model;

            else
                %if no downlink beacon, return empty data
                PassSimulation.Downlink_Beacon_SNR_dB = [];
                PassSimulation.Downlink_Beacon_Power = [];
                PassSimulation.Downlink_Beacon_Link_Model = [];
            end


            %does the hardware support an uplink beacon?
            Uplink_Beacon_Flag = ~isempty(Ground_Station.Beacon)&&~isempty(Satellite.Camera);
            PassSimulation.Uplink_Beacon_Flag = Uplink_Beacon_Flag;

            %% Uplink beacon modelling
            if Uplink_Beacon_Flag
                % if a beacon is present, simulate the beacon channel
                [Beacon_Uplink_model, UplinkBeaconLossdB] = ...
                    Compute_Link_Loss(Beacon_Uplink_Model(N_Steps, Visibility), ...
                    Satellite, ...
                    Ground_Station);
                %compute beacon received power
                Uplink_Beacon_Power = Ground_Station.Beacon.Power*10.^(-UplinkBeaconLossdB/10);
                PassSimulation.Uplink_Beacon_Power = Uplink_Beacon_Power;

                if ~isempty(smarts_configuration)
                %computed beacon channel noise
                %% need some smarts involvement here
                Uplink_Beacon_Noise = Satellite.Camera.Noise;
                else
                    Uplink_Beacon_Noise = Ground_Station.Camera.Noise;
                end

                %compute SNR
                PassSimulation.Uplink_Beacon_SNR_dB = 10*log10(Uplink_Beacon_Power./Uplink_Beacon_Noise);
                PassSimulation.Uplink_Beacon_Link_Model = Beacon_Uplink_model;
            else
                %if no uplink beacon, return empty data
                PassSimulation.Uplink_Beacon_SNR_dB = [];
                PassSimulation.Uplink_Beacon_Power = [];
                PassSimulation.Uplink_Beacon_Link_Model = [];
            end
        end

        function Satellite = Satellite(PassSimulation)
            %% return the satellite object in use, whether a transmitter or receiver
            switch PassSimulation.Link_Direction
                case 'Up'
                    Satellite = PassSimulation.QKD_Receiver;
                case 'Down'
                    Satellite = PassSimulation.QKD_Transmitter;
                otherwise
                    Satellite = [];
                    warning('simulation has not yet had satellite assigned');
            end
        end

        function OGS = Ground_Station(PassSimulation)
            %% return the satellite object in use, whether a transmitter or receiver
            switch PassSimulation.Link_Direction
                case 'Up'
                    OGS = PassSimulation.QKD_Transmitter;
                case 'Down'
                    OGS = PassSimulation.QKD_Receiver;
                otherwise
                    OGS = [];
                    warning('simulation has not yet had OGS assigned');
            end
        end

        function [SatelliteScenario, AccessIntervals] = Scenario(PassSimulation)
            %% output a SatelliteScenario which can be simulated and viewed by MATLAB
%the structure of transmitter and receiver doesn't matter here. The link is just a visual indicator of the pass duration

            %% initialise scenario
            StartTime = PassSimulation.Satellite.Times(1);
            StopTime = PassSimulation.Satellite.Times(end);
            SampleTime = seconds(PassSimulation.Satellite.Times(2)-PassSimulation.Satellite.Times(1));
            %ensure these are datetime, datetime, double respectively.
            assert(isdatetime(StartTime), 'can only simulate passes using datetime format');
            %initialise
            SatelliteScenario = satelliteScenario(StartTime, StopTime, SampleTime);
            

            %% get details of satellite
            SatDetails = GetOrbitDetails(PassSimulation.Satellite);
            %include satellite
            SatSimObj = satellite(SatelliteScenario, SatDetails{:});


            %% get details of OGS
            OGSDetails = GetOGSDetails(PassSimulation.Ground_Station);
            %include OGS
            OGSSimObj = groundStation(SatelliteScenario, OGSDetails{:});


            %% produce access object for analysis
            Access = access(OGSSimObj, SatSimObj);
            AccessIntervals = accessIntervals(Access);
        end
    
        function Play(PassSimulation)
            %% show this pass in the MATLAB satellite simulator

            %note- this does not require simulating the pass
            SatelliteScenario = Scenario(PassSimulation);
            play(SatelliteScenario);
        end

        function Access = Access(PassSimulation)
            %% return the access table for this passsimulation

            %note- this does not require simulating the pass
            [~, Access] = Scenario(PassSimulation);
        end
    end
end
