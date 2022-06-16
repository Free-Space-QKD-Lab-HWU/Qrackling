classdef Satellite_Reflection_Link_Model < Link_Model
    %Satellite_Reflection_Link_Model link model specified for reflection
    %of background light off a satellite

    properties (SetAccess=protected)
        Reflectivity_Loss{mustBeVector,mustBeLessThanOrEqual(Reflectivity_Loss,1),mustBeScalarOrEmpty}=0;%absolute loss due to satellite reflectivity
        Reflectivity_Loss_dB{mustBeVector,mustBePositive,mustBeScalarOrEmpty}=inf;             %dB loss due to satellite reflectivity

        Uplink_Loss{mustBeVector,mustBeLessThanOrEqual(Uplink_Loss,1),mustBeScalarOrEmpty}=0;   %absolute loss between source and satellite power absoroption
        Uplink_Loss_dB{mustBeVector,mustBePositive,mustBeScalarOrEmpty}=inf;                   %dB loss between source and satellite power absoroption
        Uplink_Distance{mustBePositive,mustBeScalarOrEmpty}=inf;                               %distance from background source to satellite

        Downlink_Loss{mustBeVector,mustBeLessThanOrEqual(Downlink_Loss,1),mustBeScalarOrEmpty}=0; %absolute loss between satellite reflected emission and ground station
        Downlink_Loss_dB{mustBeVector,mustBePositive,mustBeScalarOrEmpty}=inf;                 %dB loss between satellite reflected emission and ground station
        Downlink_Distance{mustBePositive,mustBeScalarOrEmpty}=inf;                             %distance between satellite and ground station

        Reflection_Correction_Factor=3/(2*pi*(2-2^(1/4)));                                     %the correction factor which ensures that reflection from a surface conserves energy
    end
    
    properties (SetAccess=protected,Abstract=false)%inherited properties
        Link_Loss
        Link_Loss_dB
    end

    methods

        function SRLM=Satellite_Reflection_Link_Model(Data_Length)
            %%SATELLITE_LINK_MODEL construct an instance of Satellite_Link_Model with the indicated  width
            if nargin==0
                return
            elseif isscalar(Data_Length)&&mod(Data_Length,1)==0&&Data_Length>0
                SRLM=repmat(SRLM,1,Data_Length);
            else
                error('Data length must be a positive scalar integer describing the length of the Link_Model vector')
            end
        end

        function [Satellite_Reflection_Link_Model,Link_Loss_dB] = Compute_Link_Loss(Satellite_Reflection_Link_Model,Satellite,Ground_Station,Background_Source)
            %COMPUTE_LINK_LOSS between background source via satellite
            %reflection to ground station

            %% uplink loss

            %compute distances between background source and satellite
            Distances=ComputeDistanceBetween(Satellite,Background_Source);
            %assuming uniform hemispherical emission from background
            %source, link loss is satellite frontal area over steradians in
            %the full sphere. spectral pointance is per str for this reason
            Uplink_Loss=Satellite.Frontal_Area./(4*pi*(Distances.^2)); %#ok<*PROPLC>

            %add in pointing loss if the source is a jamming terminal
            if isa(Background_Source,'Jamming_Laser')
            Uplink_Loss=Uplink_Loss*exp(-8*(Background_Source.Pointing_Jitter/Background_Source.FOV)^2);
            end
            
            %add in atmospheric loss
            [~,Satellite_From_Source_Elevation]=RelativeHeadingAndElevation(Satellite,Background_Source);
            Uplink_Atmospheric_Loss=AtmosphericTransmittance(Satellite.Source.Wavelength,Satellite_From_Source_Elevation);
            Uplink_Loss=Uplink_Loss.*Uplink_Atmospheric_Loss';

             %is uplink from background source to satellite shadowed?
            Uplink_Loss(IsEarthShadowed(Satellite,Background_Source))=0;
            Satellite_Reflection_Link_Model=SetUplinkLoss(Satellite_Reflection_Link_Model,Uplink_Loss);


            %% reflectivity loss
            %compute the half-angle between source, satellite and OGS
            ENU_Background=ComputeRelativeCoords(Background_Source,Satellite);
            ENU_OGS=ComputeRelativeCoords(Ground_Station,Satellite);
            %normalise and then take arccos to compute angle
            ENU_Background=ENU_Background./(Row2Norms(ENU_Background));
            ENU_OGS=ENU_OGS./(Row2Norms(ENU_OGS));
            Dot_btw_Coords=sum(ENU_OGS.*ENU_Background,2)'; %=cos(2*theta)
            cos_half_angle_of_reflection=sqrt((Dot_btw_Coords+1)/2); %cos(theta)=sqrt((cos(2*theta)+1)/2)

            %reflectivity=normal reflectivity* (cos(half angle))^1/2 * correction factor
            Angular_Reflectivity=Satellite.Reflectivity*cos_half_angle_of_reflection.^(1/2).*[Satellite_Reflection_Link_Model.Reflection_Correction_Factor];

            %store this loss value
            Satellite_Reflection_Link_Model=SetReflectivityLoss(Satellite_Reflection_Link_Model,Angular_Reflectivity);

            %% downlink loss
            %downlink loss includes the geometric loss on downlink
            %compute distances between OGS and satellite
            Distances=ComputeDistanceBetween(Satellite,Ground_Station);
            %assuming emission is relative to uniform hemispherical emission from background
            %source, link loss is satellite frontal area over hemisphere of
            %radius equal to link distance
            Downlink_Loss=((pi/4)*Ground_Station.Telescope.Diameter^2)./(2*pi*Distances.^2); %#ok<*PROPLC>
            %add in atmospheric loss
            [~,Satellite_From_OGS_Elevation]=RelativeHeadingAndElevation(Satellite,Ground_Station);
            Downlink_Atmospheric_Loss=AtmosphericTransmittance(Satellite.Source.Wavelength,Satellite_From_OGS_Elevation);
            Downlink_Loss=Downlink_Loss.*Downlink_Atmospheric_Loss';
             %is downlink from background source to satellite shadowed?
            Downlink_Loss(IsEarthShadowed(Satellite,Ground_Station))=0;
            Satellite_Reflection_Link_Model=SetDownlinkLoss(Satellite_Reflection_Link_Model,Downlink_Loss);


            %% set total loss
            [Satellite_Reflection_Link_Model,Link_Loss_dB]=SetTotalLoss(Satellite_Reflection_Link_Model);
        end


        function Plot(Satellite_Reflectivity_Link_Model,X_Axis)
            %% plot the link loss over time of the satellite link
            %must use column vector of losses for area
            if isrow(Satellite_Reflectivity_Link_Model)
                Satellite_Reflectivity_Link_Model=Satellite_Reflectivity_Link_Model';
            end
            area(X_Axis,[GetUplinkLossdB(Satellite_Reflectivity_Link_Model),GetReflectivityLossdB(Satellite_Reflectivity_Link_Model),GetDownlinkLossdB(Satellite_Reflectivity_Link_Model)]);
            xlabel('Time (s)')
            ylabel('losses (dB)')
            legend('Uplink spreading loss','Reflection loss','Downlink spreading loss');
        end
    
        function [Link_Model,Total_Loss_dB,Total_Loss]=SetTotalLoss(Link_Model)
        %update total loss to reflect internal stored computations
                    %% input validation
            sz=size(Link_Model);
            Total_Loss_dB=zeros(sz);
            Total_Loss=zeros(sz);

            for i=1:sz(1)
                for j=1:sz(2)
                    Current_Total_Loss_dB=Link_Model(i,j).Uplink_Loss_dB+Link_Model(i,j).Reflectivity_Loss_dB+Link_Model(i,j).Downlink_Loss_dB;
                    Total_Loss_dB(i,j)=Current_Total_Loss_dB;
                    Link_Model(i,j).Link_Loss_dB=Current_Total_Loss_dB;
                    Current_Total_Loss=10^(-Current_Total_Loss_dB/10);
                    Total_Loss(i,j)=Current_Total_Loss;
                    Link_Model(i,j).Link_Loss=Current_Total_Loss;
                end
            end
        end
    end

    methods (Access=protected)
        function Link_Models=SetReflectivityLoss(Link_Models,Reflectivity_Loss)
            %%SETREFLECTIVITYLOSS set the reflectivity loss in a link model array

            %% input validation
            if ~all(isreal(Reflectivity_Loss)&Reflectivity_Loss>0)
                error('reflectivity loss must be a real, positive array of numeric values')
            end
            sz=size(Reflectivity_Loss);
            if ~isequal(sz,size(Link_Models))
                if isequal(size(Reflectivity_Loss'),size(Link_Models))
                    Reflectivity_Loss=Reflectivity_Loss'; %can transpose lengths to match dimensions of Link_Models
                    sz=size(Reflectivity_Loss);
                elseif isscalar(Reflectivity_Loss)
                    Reflectivity_Loss=Reflectivity_Loss*ones(size(Link_Models)); %if provided a scalar, put this into everywhere in the array
                    sz=size(Reflectivity_Loss);
                else
                    error('Lengths array must have the same dimensions as the array of link models');
                end
            end

            for i=1:sz(1)
                for j=1:sz(2)
                    Link_Models(i,j).Reflectivity_Loss=Reflectivity_Loss(i,j);
                    Link_Models(i,j).Reflectivity_Loss_dB=-10*log10(Reflectivity_Loss(i,j));
                end
            end
        end

        function Link_Models=SetUplinkLoss(Link_Models,Uplink_Loss)
            %%SETREFLECTIVITYLOSS set the reflectivity loss in a link model array

            %% input validation
            if ~all(isreal(Uplink_Loss)&Uplink_Loss>=0)
                error('uplink loss must be a real, non-negative array of numeric values')
            end
            sz=size(Uplink_Loss);
            if ~isequal(sz,size(Link_Models))
                if isequal(size(Uplink_Loss'),size(Link_Models))
                    Uplink_Loss=Uplink_Loss'; %can transpose lengths to match dimensions of Link_Models
                    sz=size(Uplink_Loss);
                elseif isscalar(Uplink_Loss)
                    Uplink_Loss=Uplink_Loss*ones(size(Link_Models)); %if provided a scalar, put this into everywhere in the array
                    sz=size(Uplink_Loss);
                else
                    error('Lengths array must have the same dimensions as the array of link models');
                end
            end

            for i=1:sz(1)
                for j=1:sz(2)
                    Link_Models(i,j).Uplink_Loss=Uplink_Loss(i,j);
                    Link_Models(i,j).Uplink_Loss_dB=-10*log10(Uplink_Loss(i,j));
                end
            end
        end

        function Link_Models=SetDownlinkLoss(Link_Models,Downlink_Loss)
            %%SETREFLECTIVITYLOSS set the reflectivity loss in a link model array

            %% input validation
            if ~all(isreal(Downlink_Loss)&Downlink_Loss>=0)
                error('downlink loss must be a real, non-negative array of numeric values')
            end
            sz=size(Downlink_Loss);
            if ~isequal(sz,size(Link_Models))
                if isequal(size(Downlink_Loss'),size(Link_Models))
                    Downlink_Loss=Downlink_Loss'; %can transpose lengths to match dimensions of Link_Models
                    sz=size(Downlink_Loss);
                elseif isscalar(Downlink_Loss)
                    Downlink_Loss=Downlink_Loss*ones(size(Link_Models)); %if provided a scalar, put this into everywhere in the array
                    sz=size(Downlink_Loss);
                else
                    error('Lengths array must have the same dimensions as the array of link models');
                end
            end

            for i=1:sz(1)
                for j=1:sz(2)
                    Link_Models(i,j).Downlink_Loss=Downlink_Loss(i,j);
                    Link_Models(i,j).Downlink_Loss_dB=-10*log10(Downlink_Loss(i,j));
                end
            end
        end
    end

end