classdef Satellite_Uplink_Model < Link_Model
    %Satellite_Uplink_Model a link model specific to satellite to OGS downlink

    properties (SetAccess=protected,Abstract=false)
        Link_Loss;                                                         %link loss in absolute terms
        Link_Loss_dB;                                                      %link loss measured in dB
        Shadow_Flag;                                                       %flag describing when the link is shadowed
    end
    properties (SetAccess=protected)
        Geometric_Loss=nan;                                                %geometric loss in absolute terms
        Geometric_Loss_dB=nan;                                             %geometric loss in dB
        Optical_Efficiency_Loss=nan;                                       %Optical Efficiency loss in absolute terms
        Optical_Efficiency_Loss_dB=nan;                                    %Optical Efficiency loss in dB
        APT_Loss=nan;                                                      %tracking loss in absolute term s
        APT_Loss_dB=nan;                                                   %tracking loss in dB
        Turbulence_Loss=nan;                                               %turbulence loss in absolute terms
        Turbulence_Loss_dB=nan;                                            %loss due to atmospheric turbulence
        Atmospheric_Loss=nan;                                              %atmospheric loss in absolute terms
        Atmospheric_Loss_dB=nan;                                           %atmospheric loss in dB
        Length=nan;                                                        %link distance in m
        Visibility {mustBeText} ='clear'                                   %tag identifying the visibility conditions of this link
    end


    methods (Access=protected)
        function Link_Models=SetGeometricLoss(Link_Models,Geometric_Loss)
            %%SETGEOMETRICLOSS set the geometric loss in a link model array

            %% input validation
            if ~all(isreal(Geometric_Loss)&Geometric_Loss>=0)
                error('geometric loss must be a non-negative array of numeric values')
            end
            sz=size(Geometric_Loss);
            if ~isequal(sz,size(Link_Models))
                if isequal(size(Geometric_Loss'),size(Link_Models))
                    Geometric_Loss=Geometric_Loss'; %can transpose lengths to match dimensions of Link_Models
                    sz=size(Geometric_Loss);
                elseif isscalar(Geometric_Loss)
                    Geometric_Loss=Geometric_Loss*ones(size(Link_Models)); %if provided a scalar, put this into everywhere in the array
                    sz=size(Geometric_Loss);
                else
                    error('Lengths array must have the same dimensions as the array of link models');
                end
            end

            for i=1:sz(1)
                for j=1:sz(2)
                    Link_Models(i,j).Geometric_Loss=Geometric_Loss(i,j);
                    Link_Models(i,j).Geometric_Loss_dB=-10*log10(Geometric_Loss(i,j));
                end
            end
        end

        function Link_Models=SetAtmosphericLoss(Link_Models,Atmospheric_Loss)
            %%SETATMOSPHERICLOSS

            %% input validation
            if ~all(isreal(Atmospheric_Loss)&Atmospheric_Loss>=0)
                error('atmospheric loss must be a real, nonnegative array of numeric values')
            end
            sz=size(Atmospheric_Loss);
            if ~isequal(sz,size(Link_Models))
                if isequal(size(Atmospheric_Loss'),size(Link_Models))
                    Atmospheric_Loss=Atmospheric_Loss'; %can transpose lengths to match dimensions of Link_Models
                    sz=size(Atmospheric_Loss);
                elseif isscalar(Atmospheric_Loss)
                    Atmospheric_Loss=Atmospheric_Loss*ones(size(Link_Models)); %if provided a scalar, put this into everywhere in the array
                    sz=size(Atmospheric_Loss);
                else
                    error('Lengths array must have the same dimensions as the array of link models');
                end
            end

            for i=1:sz(1)
                for j=1:sz(2)
                    Link_Models(i,j).Atmospheric_Loss=Atmospheric_Loss(i,j);
                    Link_Models(i,j).Atmospheric_Loss_dB=-10*log10(Atmospheric_Loss(i,j));
                end
            end
        end

        function Link_Models=SetOpticalEfficiencyLoss(Link_Models,Optical_Efficiency_Loss)
            %%SETOPTICALEFFICIENCYLOSS set the optical efficiency loss in the link

            %% input validation
            if ~all(isreal(Optical_Efficiency_Loss)&Optical_Efficiency_Loss>=0)
                error('optical efficiency loss must be a real, positive array of numeric values')
            end
            sz=size(Optical_Efficiency_Loss);
            if ~isequal(sz,size(Link_Models))
                if isequal(size(Optical_Efficiency_Loss'),size(Link_Models))
                    Optical_Efficiency_Loss=Optical_Efficiency_Loss'; %can transpose lengths to match dimensions of Link_Models
                    sz=size(Optical_Efficiency_Loss);
                elseif isscalar(Optical_Efficiency_Loss)
                    Optical_Efficiency_Loss=Optical_Efficiency_Loss*ones(size(Link_Models)); %if provided a scalar, put this into everywhere in the array
                    sz=size(Optical_Efficiency_Loss);
                else
                    error('Lengths array must have the same dimensions as the array of link models');
                end
            end

            for i=1:sz(1)
                for j=1:sz(2)
                    Link_Models(i,j).Optical_Efficiency_Loss=Optical_Efficiency_Loss(i,j);
                    Link_Models(i,j).Optical_Efficiency_Loss_dB=-10*log10(Optical_Efficiency_Loss(i,j));
                end
            end
        end

        function Link_Models=SetAPTLoss(Link_Models,APT_Loss)
            %%SETAPTLOSS set the acquistion, pointing and tracking loss of the link

            %% input validation
            if ~all(isreal(APT_Loss)&APT_Loss>=0)
                error('tracking loss must be a real, nonnegative array of numeric values')
            end
            sz=size(APT_Loss);
            if ~isequal(sz,size(Link_Models))
                if isequal(size(APT_Loss'),size(Link_Models))
                    APT_Loss=APT_Loss'; %can transpose lengths to match dimensions of Link_Models
                    sz=size(APT_Loss);
                elseif isscalar(APT_Loss)
                    APT_Loss=APT_Loss*ones(size(Link_Models)); %if provided a scalar, put this into everywhere in the array
                    sz=size(APT_Loss);
                else
                    error('Lengths array must have the same dimensions as the array of link models');
                end
            end

            for i=1:sz(1)
                for j=1:sz(2)
                    Link_Models(i,j).APT_Loss=APT_Loss(i,j);
                    Link_Models(i,j).APT_Loss_dB=-10*log10(APT_Loss(i,j));
                end
            end
        end

        function Link_Models=SetLinkLength(Link_Models,Lengths)
            %%SETLINKLENGTH set the length of the links in the input array

            %% input validation
            if ~all(isreal(Lengths)&Lengths>0)
                error('lengths must be a real, positive array of numeric values')
            end
            sz=size(Lengths);
            if ~isequal(sz,size(Link_Models))
                if isequal(size(Lengths'),size(Link_Models))
                    Lengths=Lengths'; %can transpose lengths to match dimensions of Link_Models
                    sz=size(Lengths);
                else
                    error('Lengths array must have the same dimensions as the array of link models');
                end
            end

            for i=1:sz(1)
                for j=1:sz(2)
                    Link_Models(i,j).Length=Lengths(i,j);
                end
            end

        end

    end
    methods (Access=public)

        function Satellite_Uplink_Model=Satellite_Uplink_Model(Data_Length,Visibility)
            %%Satellite_Uplink_Model construct an instance of Satellite_Uplink_Model with the indicated number of modelled points
            if nargin==0
                return
            elseif nargin==1
                Satellite_Uplink_Model=repmat(Satellite_Uplink_Model(),1,Data_Length);
            elseif nargin==2
                Satellite_Uplink_Model=repmat(Satellite_Uplink_Model(),1,Data_Length);
                Satellite_Uplink_Model=SetVisibility(Satellite_Uplink_Model,Visibility);
            else
                error('Data length must be a positive scalar integer describing the length of the Link_Model vector')
            end
        end

        function [Link_Model,Link_Loss_dB] = Compute_Link_Loss(Link_Model,Satellite,Ground_Station)
            %%COMPUTE_LINK_LOSS compute loss between satellite and ground
            %station

            %% compute link lengths
            Link_Lengths=ComputeDistanceBetween(Satellite,Ground_Station);
            Link_Model=SetLinkLength(Link_Model,Link_Lengths);

            %% see Link loss analysis for a satellite quantum communication down-link Chunmei Zhang*, Alfonso Tello, Ugo Zanforlin, Gerald S. Buller, Ross J. Donaldson
            Geo_Spot_Size = (ones(size(Link_Lengths))*Ground_Station.Telescope.Diameter+Link_Lengths*Ground_Station.Telescope.FOV);
            Geo_Loss=(sqrt(pi)/8)*(Satellite.Telescope.Diameter./Geo_Spot_Size).^2;
            %compute when earth shadowing of link is present
            Shadowing=IsEarthShadowed(Satellite,Ground_Station);
            Geo_Loss(Shadowing)=0;
            Eff_Loss=Ground_Station.Source.Efficiency*Ground_Station.Telescope.Optical_Efficiency*Satellite.Detector.Detection_Efficiency*Satellite.Detector.Jitter_Loss*Satellite.Telescope.Optical_Efficiency;

            %% atmospheric loss
            %compute elevation angles
            [~,Elevation_Angles]=RelativeHeadingAndElevation(Satellite,Ground_Station);
            %format spectral filters which correspond to these elevation angles
            Atmospheric_Spectral_Filter = Atmosphere_Spectral_Filter(Elevation_Angles,Satellite.Source.Wavelength,{Link_Model.Visibility});
            Atmos_Loss = computeTransmission(Atmospheric_Spectral_Filter,Ground_Station.Source.Wavelength);

            %% turbulence loss
            %we assume turbulence limited behaviour
            %parameters
            Wavelength = Ground_Station.Source.Wavelength*10^-9;
            Wavenumber = 2*pi/Wavelength;
            Zenith = 90-Elevation_Angles;
            Satellite_Altitude = Satellite.Altitude;
            Beam_Waist = Ground_Station.Telescope.Diameter;
            Rayleigh_Range = rayleigh_range(Beam_Waist, Wavelength, 1);
            Atmospheric_Turbulence_Coherence_Length = ...
                atmospheric_turbulence_coherence_length(Wavenumber,...
                                             Zenith, ...
                                             Satellite_Altitude, ghv_defaults);
            %output variables
            spot_tl = long_term_gaussian_beam_width(Beam_Waist, Link_Lengths ,...
                                        Rayleigh_Range, 2*pi/Ground_Station.Source.Wavelength, Atmospheric_Turbulence_Coherence_Length);
            %residual beam wander is not needed here as this is dealt with in
            %APT loss
            %wander_tl = residual_beam_wander(error_snr, error_delay, error_centroid, ...
            %                                   error_tilt, spot_tl, L);
            Turbulence_Loss = (Geo_Spot_Size./spot_tl).^2;

            %% Acquisition, pointing and tracking loss
            APTracking_Loss=...
                Ground_Station.Telescope.FOV^2/(Ground_Station.Telescope.Pointing_Jitter^2+Ground_Station.Telescope.FOV^2)*...%satellite pointing loss, assumes gaussian beam
                (1-exp(-(Satellite.Telescope.FOV^2/(8*Satellite.Telescope.Pointing_Jitter^2))));%ground station pointing loss, assumes flat-top FOV
        
            %record loss values
            Link_Model=SetGeometricLoss(Link_Model,Geo_Loss);
            Link_Model=SetOpticalEfficiencyLoss(Link_Model,Eff_Loss);
            Link_Model=SetAtmosphericLoss(Link_Model,Atmos_Loss);
            Link_Model=SetAPTLoss(Link_Model,APTracking_Loss);

            %compute total loss
            [Link_Model,Link_Loss_dB]=SetTotalLoss(Link_Model);
        end

        function Geometric_Loss_dB=GetGeometricLossdB(Satellite_Uplink_Model)
            %%GETGEOMETRICLOSSDB return an array of geometric losses in dB the same dimensions as the satellite link model

            Geometric_Loss_dB=Satellite_Uplink_Model.Geometric_Loss_dB;
        end

        function Atmospheric_Loss_dB=GetAtmosphericLossdB(Satellite_Uplink_Model)
            %%GETATMOSPHERICLOSSDB return an array of atmospheric losses in dB the

            Atmospheric_Loss_dB=Satellite_Uplink_Model.Atmospheric_Loss_dB;
        end

        function OpticalEfficiency_Loss_dB=GetOpticalEfficiencyLossdB(Satellite_Uplink_Model)
            %%GETEFFICIENCYLOSSDB return an array of efficiency losses in dB the

           OpticalEfficiency_Loss_dB=Satellite_Uplink_Model.Optical_Efficiency_Loss_dB;

        end

        function APT_Loss_dB=GetAPTLossdB(Satellite_Uplink_Model)
            %%GETAPTLOSSDB return an array of acquistition, pointing and tracking

          APT_Loss_dB=Satellite_Uplink_Model.APT_Loss_dB;

        end

        function Plot(Satellite_Uplink_Model,X_Axis)
            %%PLOT plot the link loss over time of the satellite link

            %must use column vector of losses for area
            if isrow(Satellite_Uplink_Model)
                Satellite_Uplink_Model=Satellite_Uplink_Model';
            end
            area(X_Axis,[GetGeometricLossdB(Satellite_Uplink_Model),GetAtmosphericLossdB(Satellite_Uplink_Model),GetOpticalEfficiencyLossdB(Satellite_Uplink_Model),GetAPTLossdB(Satellite_Uplink_Model)]);
            xlabel('Time (s)')
            ylabel('Losses (dB)')

            %% display shadowed time
            GeoLossdB=GetGeometricLossdB(Satellite_Uplink_Model);
            Shadowing_Indices=(GeoLossdB==inf);
            if any(Shadowing_Indices)
                Max_Geo_Loss=max(GeoLossdB(~Shadowing_Indices));
                hold on
                scatter(X_Axis(Shadowing_Indices),Max_Geo_Loss*ones(1,sum(Shadowing_Indices)),'k.');
                if ~isempty(Max_Geo_Loss)
                    text(X_Axis(end),Max_Geo_Loss,'Link shadowed by earth','VerticalAlignment','bottom','HorizontalAlignment','right')
                else
                    text(X_Axis(end),0,'Link constantly shadowed by earth','VerticalAlignment','bottom','HorizontalAlignment','right')
                end
                hold off
            end

            %% adjust legend to represent what is plotted
            %atmospheric loss is non zero
            legend('Geometric loss','Atmospheric loss','Efficiency loss','APT loss','Orientation','horizontal');
            legend('Location','south')
        end

        function [Link_Model,Total_Loss_dB]=SetTotalLoss(Link_Model)
            %%SETTOTALLOSS update total loss to reflect stored loss values

            Total_Loss_dB=Link_Model.Geometric_Loss_dB+Link_Model.Optical_Efficiency_Loss_dB+Link_Model.APT_Loss_dB;
        end

        function Satellite_Uplink_Model = SetVisibility(Satellite_Uplink_Model,Visibility)
            %%SETVISIBILITY set the visibility tag of this link model

            Satellite_Uplink_Model.Visibility = Visibility;
        end
    end
end
