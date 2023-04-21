classdef Satellite_Reflection_Link_Model < Link_Model
    %Satellite_Reflection_Link_Model link model specified for reflection
    %of background light off a satellite

    properties (SetAccess=protected)
        Reflectivity_Loss{mustBeVector,mustBeLessThanOrEqual(Reflectivity_Loss,1)}=0;%absolute loss due to satellite reflectivity
        Reflectivity_Loss_dB{mustBeVector,mustBeNonnegative}=inf;             %dB loss due to satellite reflectivity

        Uplink_Loss{mustBeVector,mustBeLessThanOrEqual(Uplink_Loss,1)}=0;   %absolute loss between source and satellite power absoroption
        Uplink_Loss_dB{mustBeVector,mustBeNonnegative}=inf;                   %dB loss between source and satellite power absoroption
        Uplink_Distance{mustBePositive}=inf;                               %distance from background source to satellite

        Downlink_Loss{mustBeVector,mustBeLessThanOrEqual(Downlink_Loss,1)}=0; %absolute loss between satellite reflected emission and ground station
        Downlink_Loss_dB{mustBeVector,mustBeNonnegative}=inf;                 %dB loss between satellite reflected emission and ground station
        Downlink_Distance{mustBePositive}=inf;                             %distance between satellite and ground station

        Visibility {mustBeText} ='clear'                                   %tag identifying the visibility conditions of this link
    end
    
    properties (SetAccess=protected,Abstract=false)%inherited properties
        N                                                                       %number of simulated datapoints
        Link_Loss
        Link_Loss_dB
    end

    methods

        function SRLM=Satellite_Reflection_Link_Model(Data_Length,Visibility)
            %%SATELLITE_REFLECTION_LINK_MODEL construct a scalar link model

            switch nargin
                case 0
                return

                case 1
                SRLM=SetNumSteps(SRLM,Data_Length);

                case 2
                SRLM=SetNumSteps(SRLM,Data_Length);
                SRLM=SetVisibility(SRLM,Visibility);
                otherwise
                error('provide at most a number of datapoints to simulate and a valid visibility string')
            end
        end

        function [Satellite_Reflection_Link_Model,Link_Loss_dB] = Compute_Link_Loss(Satellite_Reflection_Link_Model,Satellite,Ground_Station,Background_Source)
            %COMPUTE_LINK_LOSS between background source via satellite
            %reflection to ground station

            %% uplink loss

            %compute distances between background source and satellite
            Distances=ComputeDistanceBetween(Satellite,Background_Source)';
            %assuming uniform hemispherical emission from background
            %source, link loss is satellite frontal area over steradians in
            %the full sphere. spectral pointance is per str for this reason

            %% link loss depends on whether or not this background source is a jamming laser
            if ~isa(Background_Source,'Jamming_Laser')
                Uplink_Loss=Satellite.Surface.Area./(4*pi*(Distances.^2)); %#ok<*PROPLC>
            else
            Uplink_Loss=(sqrt(pi)/8)*((Satellite.Surface.Area)./(Distances.^2*(Background_Source.Pointing_Jitter^2+Background_Source.FOV^2)));
            %if the beam size at the transmitter is less than the area of the
            %transmitter, then set Uplink Loss to unity
            if Uplink_Loss>1
                Uplink_Loss=1;
            end
            
            end
            
            % atmospheric loss
            %compute elevation angles
            [~,Uplink_Elevation_Angles]=RelativeHeadingAndElevation(Satellite,Background_Source);
            %format spectral filters which correspond to these elevation angles
            Uplink_Atmospheric_Spectral_Filter = Atmosphere_Spectral_Filter(Uplink_Elevation_Angles,...
                                                                            Satellite.Source.Wavelength,...
                                                                            {Satellite_Reflection_Link_Model.Visibility});
            Uplink_Atmos_Loss = computeTransmission(Uplink_Atmospheric_Spectral_Filter,Satellite.Source.Wavelength);
            Uplink_Loss=Uplink_Loss.*Uplink_Atmos_Loss;

             %is uplink from background source to satellite shadowed?
            Uplink_Loss(IsEarthShadowed(Satellite,Background_Source))=0;
            Satellite_Reflection_Link_Model=SetUplinkLoss(Satellite_Reflection_Link_Model,Uplink_Loss);
            
            %record distance
            Satellite_Reflection_Link_Model.Uplink_Distance = Distances;

            %% downlink loss
            %downlink loss includes the geometric loss on downlink
            %compute distances between OGS and satellite
            Distances=ComputeDistanceBetween(Satellite,Ground_Station)';
            %assuming emission is relative to uniform hemispherical emission from background
            %source, link loss is satellite frontal area over hemisphere of
            %radius equal to link distance
            Receiving_Steradians = (pi/4)*Ground_Station.Telescope.Diameter^2./Distances.^2;
            Downlink_Loss=Receiving_Steradians/(2*pi);                          % divide through by 2*pi steradians in a hemisphere


            %compute elevation angles
            [~,Downlink_Elevation_Angles]=RelativeHeadingAndElevation(Satellite,Ground_Station);
            %format spectral filters which correspond to these elevation angles
            Downlink_Atmospheric_Spectral_Filter = Atmosphere_Spectral_Filter(Downlink_Elevation_Angles,...
                                                                            Satellite.Source.Wavelength,...
                                                                            {Satellite_Reflection_Link_Model.Visibility});
            Downlink_Atmos_Loss = computeTransmission(Downlink_Atmospheric_Spectral_Filter,Satellite.Source.Wavelength);
            Downlink_Loss=Downlink_Loss.*Downlink_Atmos_Loss;
             %is downlink from background source to satellite shadowed?
            Downlink_Loss(IsEarthShadowed(Satellite,Ground_Station))=0;
            Satellite_Reflection_Link_Model=SetDownlinkLoss(Satellite_Reflection_Link_Model,Downlink_Loss);

            %record distance
            Satellite_Reflection_Link_Model.Downlink_Distance = Distances;

            %% reflectivity loss
            %compute angle of incoming light
                %first compute a vector representing the incoming light
                %direction in ENU space
                Background_Vector = ComputeDirection(Background_Source,Satellite);
                %then compute a vector representing the surface normal of the
                %satellite, which we assume to be pointing towards the OGS
                Surface_Normal = ComputeDirection(Ground_Station,Satellite);
                %then compute dot product and the arccos of the these vectors to
                %find the angle between them
                Dot_Product = dot(Background_Vector,Surface_Normal,2);
            Incoming_Angle = acos(Dot_Product);                                 %output is in radians


            %assume outgoing angle is zero because it runs down the surface
            %normal of the surface
            Outgoing_Angle = zeros(size(Incoming_Angle));
            
            %compute proportion of light reflected
            Reflectivity_Loss = GetReflectedLightProportion(Satellite.Surface, Satellite.Source.Wavelength, Incoming_Angle, Outgoing_Angle);
            
            %where reflectivity loss is inf here, it is due to downlink being
            %obscured. set reflectivity loss to 0
            Reflectivity_Loss(Reflectivity_Loss==inf)=0;

            %store value
            Satellite_Reflection_Link_Model = SetReflectivityLoss(Satellite_Reflection_Link_Model,Reflectivity_Loss);

            %% set total loss
            [Satellite_Reflection_Link_Model,Link_Loss_dB]=SetTotalLoss(Satellite_Reflection_Link_Model);
        end

        function Plot(Satellite_Reflection_Link_Model,X_Axis)
            %%PLOT plot the link loss over time of the satellite link

            %must use column vector of losses for area
            if isrow(Satellite_Reflection_Link_Model)
                Satellite_Reflection_Link_Model=Satellite_Reflection_Link_Model';
            end
            area(X_Axis,[GetUplinkLossdB(Satellite_Reflection_Link_Model),GetReflectivityLossdB(Satellite_Reflection_Link_Model),GetDownlinkLossdB(Satellite_Reflection_Link_Model)]);
            xlabel('Time (s)')
            ylabel('Losses (dB)')

            %% display shadowed time
            Uplink_Loss_dB=GetUplinkLossdB(Satellite_Reflection_Link_Model);
            Downlink_Loss_dB=GetDownlinkLossdB(Satellite_Reflection_Link_Model);
            Shadowing_Indices=(Uplink_Loss_dB==inf|Downlink_Loss_dB==inf);
            if any(Shadowing_Indices)
                Max_Up_Loss=max(Uplink_Loss_dB(~Shadowing_Indices));
                hold on
                scatter(X_Axis(Shadowing_Indices),Max_Up_Loss*ones(1,sum(Shadowing_Indices)),'k.');
                if ~isempty(Max_Up_Loss)
                    text(X_Axis(end),Max_Up_Loss,'Link shadowed by earth','VerticalAlignment','bottom','HorizontalAlignment','right')
                else
                    text(X_Axis(end),0,'Link constantly shadowed by earth','VerticalAlignment','bottom','HorizontalAlignment','right')
                end
                hold off
            end

            %% adjust legend to represent what is plotted
            legend('Uplink loss','Reflectivity loss','Downlink loss');
            legend('Location','south')
        end
    
        function [Link_Model,Total_Loss_dB,Total_Loss]=SetTotalLoss(Link_Model)
        %update total loss to reflect internal stored computations
                    Current_Total_Loss_dB=Link_Model.Uplink_Loss_dB+Link_Model.Reflectivity_Loss_dB+Link_Model.Downlink_Loss_dB;
                    Total_Loss_dB=Current_Total_Loss_dB;
                    Link_Model.Link_Loss_dB=Current_Total_Loss_dB;
                    Current_Total_Loss=10.^(-Current_Total_Loss_dB/10);
                    Total_Loss=Current_Total_Loss;
                    Link_Model.Link_Loss=Current_Total_Loss;

        end

        function Link_Model = SetNumSteps(Link_Model,N)
                %%SETNUMSTEPS set the number of points in the simulated link model
    
            Link_Model.N=N;
            Link_Model.Uplink_Loss=zeros(1,N);
            Link_Model.Uplink_Loss_dB=zeros(1,N);
            Link_Model.Downlink_Loss=zeros(1,N);
            Link_Model.Downlink_Loss_dB=zeros(1,N);
            Link_Model.Reflectivity_Loss=zeros(1,N);
            Link_Model.Reflectivity_Loss_dB=zeros(1,N);
        end
    end

    methods (Access=protected)
        function Link_Models=SetReflectivityLoss(Link_Models,Reflectivity_Loss)
            %%SETREFLECTIVITYLOSS set the acquistion, pointing and tracking loss of the link

            %% input validation
            if ~all(isreal(Reflectivity_Loss)&Reflectivity_Loss>=0)
                error('tracking loss must be a real, nonnegative array of numeric values')
            end
            if isscalar(Reflectivity_Loss)
                Reflectivity_Loss=Reflectivity_Loss*ones(1,Link_Models.N); %if provided a scalar, put this into everywhere in the array 
            elseif isrow(Reflectivity_Loss)
            elseif iscolumn(Reflectivity_Loss)
                Reflectivity_Loss=Reflectivity_Loss'; %can transpose lengths to match dimensions of Link_Models
            else
                error('Array must be a vector or scalar');
            end

            Link_Models.Reflectivity_Loss=Reflectivity_Loss;
            Link_Models.Reflectivity_Loss_dB=-10*log10(Reflectivity_Loss);
        end

        function Link_Models=SetUplinkLoss(Link_Models,Uplink_Loss)
            %%SETUPLINKLOSS set the acquistion, pointing and tracking loss of the link

            %% input validation
            if ~all(isreal(Uplink_Loss)&Uplink_Loss>=0)
                error('tracking loss must be a real, nonnegative array of numeric values')
            end
            if isscalar(Uplink_Loss)
                Uplink_Loss=Uplink_Loss*ones(1,Link_Models.N); %if provided a scalar, put this into everywhere in the array 
            elseif isrow(Uplink_Loss)
            elseif iscolumn(Uplink_Loss)
                Uplink_Loss=Uplink_Loss'; %can transpose lengths to match dimensions of Link_Models
            else
                error('Array must be a vector or scalar');
            end

            Link_Models.Uplink_Loss=Uplink_Loss;
            Link_Models.Uplink_Loss_dB=-10*log10(Uplink_Loss);
        end

        function Link_Models=SetDownlinkLoss(Link_Models,Downlink_Loss)
            %%SETDOWNLINKLOSS set the acquistion, pointing and tracking loss of the link

            %% input validation
            if ~all(isreal(Downlink_Loss)&Downlink_Loss>=0)
                error('tracking loss must be a real, nonnegative array of numeric values')
            end
            if isscalar(Downlink_Loss)
                Downlink_Loss=Downlink_Loss*ones(1,Link_Models.N); %if provided a scalar, put this into everywhere in the array 
            elseif isrow(Downlink_Loss)
            elseif iscolumn(Downlink_Loss)
                Downlink_Loss=Downlink_Loss'; %can transpose lengths to match dimensions of Link_Models
            else
                error('Array must be a vector or scalar');
            end

            Link_Models.Downlink_Loss=Downlink_Loss;
            Link_Models.Downlink_Loss_dB=-10*log10(Downlink_Loss);
        end

        function Uplink_Loss_dB=GetUplinkLossdB(Link_Model)
            %%GETUPLINKLOSSDB return an array of geometric losses in dB the same dimensions as the satellite link model
            
            Uplink_Loss_dB=Link_Model.Uplink_Loss_dB;
        end

        function Downlink_Loss_dB=GetDownlinkLossdB(Link_Model)
            %%GETDOWNLINKLOSSDB return an array of geometric losses in dB the same dimensions as the satellite link model
            
            Downlink_Loss_dB=Link_Model.Downlink_Loss_dB;
        end

        function Reflectivity_Loss_dB=GetReflectivityLossdB(Link_Model)
            %%GETREFLECTIVITYLOSSDB return an array of geometric losses in dB the same dimensions as the satellite link model
            
            Reflectivity_Loss_dB=Link_Model.Reflectivity_Loss_dB;
        end

       function Satellite_Link_Model = SetVisibility(Satellite_Link_Model,Visibility)
            %%SETVISIBILITY set the visibility tag of this link model

            Satellite_Link_Model.Visibility = Visibility;
        end
    end

end