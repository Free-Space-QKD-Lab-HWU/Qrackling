classdef Satellite_Uplink_Model < Link_Model
    %Satellite_Uplink_Model a link model specific to satellite to OGS downlink

    properties (SetAccess=protected,Abstract=false)
        N                                                                  %number of time steps to simulate
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
            if isscalar(Geometric_Loss)
                Geometric_Loss=Geometric_Loss*ones(1,Link_Models.N); %if provided a scalar, put this into everywhere in the array 
            elseif isrow(Geometric_Loss)
            elseif iscolumn(Geometric_Loss)
                Geometric_Loss=Geometric_Loss'; %can transpose lengths to match dimensions of Link_Models
            else
                error('Array must be a vector or scalar');
            end

            Link_Models.Geometric_Loss=Geometric_Loss;
            Link_Models.Geometric_Loss_dB=-10*log10(Geometric_Loss);
        end

        function Link_Models=SetAtmosphericLoss(Link_Models,Atmospheric_Loss)
            %%SETATMOSPHERICLOSS

            %% input validation
            if ~all(isreal(Atmospheric_Loss)&Atmospheric_Loss>=0)
                error('atmospheric loss must be a real, nonnegative array of numeric values')
            end
            if isscalar(Atmospheric_Loss)
                Atmospheric_Loss=Atmospheric_Loss*ones(1,Link_Models.N); %if provided a scalar, put this into everywhere in the array 
            elseif isrow(Atmospheric_Loss)
            elseif iscolumn(Atmospheric_Loss)
                Atmospheric_Loss=Atmospheric_Loss'; %can transpose lengths to match dimensions of Link_Models
            else
                error('Array must be a vector or scalar');
            end
            
            Link_Models.Atmospheric_Loss=Atmospheric_Loss;
            Link_Models.Atmospheric_Loss_dB=-10*log10(Atmospheric_Loss);
        end

        function Link_Models=SetOpticalEfficiencyLoss(Link_Models,Optical_Efficiency_Loss)
            %%SETOPTICALEFFICIENCYLOSS set the optical efficiency loss in the link

            %% input validation
            if ~all(isreal(Optical_Efficiency_Loss)&Optical_Efficiency_Loss>=0)
                error('optical efficiency loss must be a real, positive array of numeric values')
            end
            if isscalar(Optical_Efficiency_Loss)
                Optical_Efficiency_Loss=Optical_Efficiency_Loss*ones(1,Link_Models.N); %if provided a scalar, put this into everywhere in the array 
            elseif isrow(Optical_Efficiency_Loss)
            elseif iscolumn(Optical_Efficiency_Loss)
                Optical_Efficiency_Loss=Optical_Efficiency_Loss'; %can transpose lengths to match dimensions of Link_Models
            else
                error('Array must be a vector or scalar');
            end

            Link_Models.Optical_Efficiency_Loss=Optical_Efficiency_Loss;
            Link_Models.Optical_Efficiency_Loss_dB=-10*log10(Optical_Efficiency_Loss);
        end

        function Link_Models=SetAPTLoss(Link_Models,APT_Loss)
            %%SETAPTLOSS set the acquistion, pointing and tracking loss of the link

            %% input validation
            if ~all(isreal(APT_Loss)&APT_Loss>=0)
                error('tracking loss must be a real, nonnegative array of numeric values')
            end
            if isscalar(APT_Loss)
                APT_Loss=APT_Loss*ones(1,Link_Models.N); %if provided a scalar, put this into everywhere in the array 
            elseif isrow(APT_Loss)
            elseif iscolumn(APT_Loss)
                APT_Loss=APT_Loss'; %can transpose lengths to match dimensions of Link_Models
            else
                error('Array must be a vector or scalar');
            end

            Link_Models.APT_Loss=APT_Loss;
            Link_Models.APT_Loss_dB=-10*log10(APT_Loss);
        end

        function Link_Models=SetLinkLength(Link_Models,Lengths)
            %%SETLINKLENGTH set the length of the links in the input array

            %% input validation
            if ~all(isreal(Lengths)&Lengths>0)
                error('lengths must be a real, positive array of numeric values')
            end
            
            assert(isvector(Lengths),'Lengths must be a vector')
                if iscolumn(Lengths)
                    Lengths=Lengths'; %can transpose lengths to match dimensions of Link_Models
                else
                    error('Lengths array must have the same dimensions as the array of link models');
                end

            Link_Models.Length=Lengths;
        end

        function Link_Models = SetTurbulenceLoss(Link_Models,Turbulence_Loss)
            %%SETTURBULENCELOSS set the turbulence loss of the link

            %% input validation
            if ~all(isreal(Turbulence_Loss)&Turbulence_Loss>=0)
                error('tracking loss must be a real, nonnegative array of numeric values')
            end
            if isscalar(Turbulence_Loss)
                Turbulence_Loss=Turbulence_Loss*ones(1,Link_Models.N); %if provided a scalar, put this into everywhere in the array 
            elseif isrow(Turbulence_Loss)
            elseif iscolumn(Turbulence_Loss)
                Turbulence_Loss=Turbulence_Loss'; %can transpose lengths to match dimensions of Link_Models
            else
                error('Array must be a vector or scalar');
            end

            Link_Models.Turbulence_Loss=Turbulence_Loss;
            Link_Models.Turbulence_Loss_dB=-10*log10(Turbulence_Loss);
        end
    end
    methods (Access=public)

        function Satellite_Uplink_Model=Satellite_Uplink_Model(N,Visibility)
            %%Satellite_Downlink_Model construct an instance of Satellite_Downlink_Model with the indicated number of modelled points
            if nargin==0
                return
            elseif nargin==1
                Satellite_Uplink_Model=SetNumSteps(Satellite_Uplink_Model,N);
            elseif nargin==2
                Satellite_Uplink_Model=SetNumSteps(Satellite_Uplink_Model,N);
                Satellite_Uplink_Model=SetVisibility(Satellite_Uplink_Model,Visibility);
            else
                error('To instantiate link model, provide a number of steps and, optionally, a visibility string')
            end
        end

        function [Link_Model,Link_Loss_dB] = Compute_Link_Loss(Link_Model,Satellite,Ground_Station)
            %%COMPUTE_LINK_LOSS compute loss between ground station and
            %%satellite

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
            %computed using MODTRAN and cached in .mat files in this
            %package

            %compute elevation angles
            [~,Elevation_Angles]=RelativeHeadingAndElevation(Satellite,Ground_Station);
            %format spectral filters which correspond to these elevation angles
            Atmospheric_Spectral_Filter = Atmosphere_Spectral_Filter(Elevation_Angles,Ground_Station.Source.Wavelength,{Link_Model.Visibility});
            Atmos_Loss = computeTransmission(Atmospheric_Spectral_Filter,Ground_Station.Source.Wavelength);

            %% turbulence loss
            %see Point ahead angle prediction based on Kalman filtering of
            % optical axis pointing angle in satellite laser communication
            % Zhang Furui · Ruan Ping · Han Junfeng

            %we assume turbulence limited behaviour (with no adaptive
            %optics)
            %parameters
            Wavelength = Ground_Station.Source.Wavelength*10^-9;
            Wavenumber = 2*pi/Wavelength;
            %can only compute for positive elevation
            Elevation_Flags = Elevation_Angles'>0;
            Zenith = 90-Elevation_Angles(Elevation_Flags)';
            Satellite_Altitude = Satellite.Altitude(Elevation_Flags);
            Beam_Waist = Ground_Station.Telescope.Diameter;
            Rayleigh_Range = rayleigh_range(Beam_Waist, Wavelength, 1);
            Atmospheric_Turbulence_Coherence_Length = ...
                atmospheric_turbulence_coherence_length(Wavenumber,...
                                             Zenith, ...
                                             Satellite_Altitude, ghv_defaults);
            %output variables
            spot_tl = long_term_gaussian_beam_width(Beam_Waist, Link_Lengths(Elevation_Flags) ,...
                                        Rayleigh_Range, 2*pi/(Ground_Station.Source.Wavelength*10^-9), Atmospheric_Turbulence_Coherence_Length);
            %residual beam wander is not needed here as this is dealt with in
            %APT loss
            %wander_tl = residual_beam_wander(error_snr, error_delay, error_centroid, ...
            %                                   error_tilt, spot_tl, L);

            %turbulence loss is the ratio of geometric and turbulent spot areas
            Turb_Loss(~Elevation_Flags)=0;
            Turb_Loss(Elevation_Flags) = (Geo_Spot_Size(Elevation_Flags)./spot_tl).^2;

            %% Acquisition, pointing and tracking loss
            APTracking_Loss=...
                Ground_Station.Telescope.FOV^2/(Ground_Station.Telescope.Pointing_Jitter^2+Ground_Station.Telescope.FOV^2)*...%satellite pointing loss, assumes gaussian beam
                (1-exp(-(Satellite.Telescope.FOV^2/(8*Satellite.Telescope.Pointing_Jitter^2))));%ground station pointing loss, assumes flat-top FOV
        
            %record loss values
            Link_Model=SetGeometricLoss(Link_Model,Geo_Loss);
            Link_Model=SetOpticalEfficiencyLoss(Link_Model,Eff_Loss);
            Link_Model=SetAtmosphericLoss(Link_Model,Atmos_Loss);
            Link_Model=SetAPTLoss(Link_Model,APTracking_Loss);
            Link_Model=SetTurbulenceLoss(Link_Model,Turb_Loss);

            %compute total loss
            [Link_Model,Link_Loss_dB]=SetTotalLoss(Link_Model);
        end

        function Geometric_Loss_dB=GetGeometricLossdB(Satellite_Uplink_Model)
            %%GETGEOMETRICLOSSDB return an array of geometric losses in dB the same dimensions as the satellite link model
            
            Geometric_Loss_dB=Satellite_Uplink_Model.Geometric_Loss_dB;
        end

        function Atmospheric_Loss_dB=GetAtmosphericLossdB(Satellite_Uplink_Model)
            %%GETATMOSPHERICLOSSDB return an array of atmospheric losses in dB the
            %same dimensions as the satellite link model
            Atmospheric_Loss_dB=Satellite_Uplink_Model.Atmospheric_Loss_dB;
        end

        function OpticalEfficiency_Loss_dB=GetOpticalEfficiencyLossdB(Satellite_Uplink_Model)
            %%GETEFFICIENCYLOSSDB return an array of efficiency losses in dB the
            % same dimensions as the satellite link model

            OpticalEfficiency_Loss_dB = Satellite_Uplink_Model.Optical_Efficiency_Loss_dB;
        end

        function APT_Loss_dB=GetAPTLossdB(Satellite_Uplink_Model)
            %%GETAPTLOSSDB return an array of acquistition, pointing and tracking
            % losses in dB the same dimensions as the satellite link model

            APT_Loss_dB=Satellite_Uplink_Model.APT_Loss_dB;
        end

        function Turbulence_Loss_dB=GetTurbulenceLossdB(Satellite_Uplink_Model)
            %%GETTURBULENCELOSSDB return an array of acquistition, pointing and tracking
            % losses in dB the same dimensions as the satellite link model

            Turbulence_Loss_dB=Satellite_Uplink_Model.Turbulence_Loss_dB;
        end

        function Plot(Satellite_Uplink_Model,X_Axis, Plot_Select_Flags)
            %%PLOT plot the link loss over time of the satellite link


            Geo = GetGeometricLossdB(Satellite_Uplink_Model);
            Eff = GetOpticalEfficiencyLossdB(Satellite_Uplink_Model);
            APT = GetAPTLossdB(Satellite_Uplink_Model);
            Turb = GetTurbulenceLossdB(Satellite_Uplink_Model);
            Atmos = GetAtmosphericLossdB(Satellite_Uplink_Model);

            Geo=Geo(Plot_Select_Flags)';
            Eff=Eff(Plot_Select_Flags)';
            APT=APT(Plot_Select_Flags)';
            Turb=Turb(Plot_Select_Flags)';
            Atmos=Atmos(Plot_Select_Flags)';

            area(X_Axis(Plot_Select_Flags),[Geo,Eff,APT,Turb,Atmos]);
            xlabel('Time (s)')
            ylabel('Losses (dB)')

            %% adjust legend to represent what is plotted
            %atmospheric loss is non zero
            legend('Geometric loss','Efficiency loss','APT loss','Turbulence loss','Atmospheric loss','Orientation','horizontal');
            legend('Location','south')
        end

        function [Link_Model,Total_Loss_dB]=SetTotalLoss(Link_Model)
            %%SETTOTALLOSS update total loss to reflect stored loss values

            Total_Loss_dB=Link_Model.Geometric_Loss_dB+Link_Model.Optical_Efficiency_Loss_dB+Link_Model.APT_Loss_dB+Link_Model.Turbulence_Loss_dB;
            Total_Loss= 10.^(Total_Loss_dB/10);
            Link_Model.Link_Loss_dB=Total_Loss_dB;
            Link_Model.Link_Loss=Total_Loss;
        end

        function Satellite_Uplink_Model = SetVisibility(Satellite_Uplink_Model,Visibility)
            %%SETVISIBILITY set the visibility tag of this link model

            Satellite_Uplink_Model.Visibility = Visibility;
        end

       function Satellite_Downlink_Model = SetNumSteps(Satellite_Downlink_Model,N)
            %%SETNUMSTEPS set the number of points in the simulated link model

        Satellite_Downlink_Model.N=N;
        Satellite_Downlink_Model.Geometric_Loss=zeros(1,N);                                                %geometric loss in absolute terms
        Satellite_Downlink_Model.Geometric_Loss_dB=zeros(1,N);                                             %geometric loss in dB
        Satellite_Downlink_Model.Turbulence_Loss=zeros(1,N);                                               %turbulence loss in absolute terms
        Satellite_Downlink_Model.Turbulence_Loss_dB=zeros(1,N);                                            %turbulence loss in dB
        Satellite_Downlink_Model.Optical_Efficiency_Loss=zeros(1,N);                                       %Optical Efficiency loss in absolute terms
        Satellite_Downlink_Model.Optical_Efficiency_Loss_dB=zeros(1,N);                                    %Optical Efficiency loss in dB
        Satellite_Downlink_Model.APT_Loss=zeros(1,N);                                                      %tracking loss in absolute term s
        Satellite_Downlink_Model.APT_Loss_dB=zeros(1,N);                                                   %tracking loss in dB
        Satellite_Downlink_Model.Atmospheric_Loss=zeros(1,N);                                              %atmospheric loss in absolute terms
        Satellite_Downlink_Model.Atmospheric_Loss_dB=zeros(1,N);                                           %atmospheric loss in dB
        Satellite_Downlink_Model.Length=zeros(1,N);                                                        %link distance in m
        end
    end
end
