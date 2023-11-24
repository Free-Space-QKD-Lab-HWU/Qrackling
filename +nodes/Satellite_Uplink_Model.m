classdef Satellite_Uplink_Model < Satellite_Link_Model
    %Satellite_Uplink_Model a link model specific to satellite to OGS downlink

    methods (Access=protected)
        function [Link_Models,Geo_Spot_Size]=SetGeometricLoss(Link_Models,Satellite,Ground_Station)
            %%SETGEOMETRICLOSS set the geometric loss in a link model array


            %% geometric loss
            %Link loss analysis for a satellite quantum communication down-link Chunmei Zhang*, Alfonso Tello, Ugo Zanforlin, Gerald S. Buller, Ross J. Donaldson
            Geo_Spot_Size = (ones(size(Link_Models.Length))*Ground_Station.Telescope.Diameter+Link_Models.Length*Ground_Station.Telescope.FOV);
            Geo_Loss=(sqrt(pi)/8)*(Satellite.Telescope.Diameter./Geo_Spot_Size).^2;
            Geo_Loss=min(Geo_Loss,1);%make sure loss cannot be positive
            %compute when earth shadowing of link is present
            Shadowing=IsEarthShadowed(Satellite,Ground_Station);
            Geo_Loss(Shadowing)=0;



            %% input validation
            if ~all(isreal(Geo_Loss)&Geo_Loss>=0)
                error('geometric loss must be a non-negative array of numeric values')
            end
            if isscalar(Geo_Loss)
                Geo_Loss=Geo_Loss*ones(1,Link_Models.N); %if provided a scalar, put this into everywhere in the array 
            elseif isrow(Geo_Loss)
            elseif iscolumn(Geo_Loss)
                Geo_Loss=Geo_Loss'; %can transpose lengths to match dimensions of Link_Models
            else
                error('Array must be a vector or scalar');
            end

            Link_Models.Geometric_Loss=Geo_Loss;
            Link_Models.Geometric_Loss_dB=-10*log10(Geo_Loss);
        end

        function Link_Models=SetAtmosphericLoss(Link_Models,~,Ground_Station)
            %%SETATMOSPHERICLOSS
            
            %% atmospheric loss
            %computed using MODTRAN software package and cached in .mat
            %files in this package

            %format spectral filters which correspond to these elevation angles
            Atmospheric_Spectral_Filter = Atmosphere_Spectral_Filter(Link_Models.Elevation, Ground_Station.Source.Wavelength, {Link_Models.Visibility});
            Atmos_Loss = ComputeTransmission(Atmospheric_Spectral_Filter,Ground_Station.Source.Wavelength);

            %% input validation
            if ~all(isreal(Atmos_Loss)&Atmos_Loss>=0)
                error('atmospheric loss must be a real, nonnegative array of numeric values')
            end
            if isscalar(Atmos_Loss)
                Atmos_Loss=Atmos_Loss*ones(1,Link_Models.N); %if provided a scalar, put this into everywhere in the array 
            elseif isrow(Atmos_Loss)
            elseif iscolumn(Atmos_Loss)
                Atmos_Loss=Atmos_Loss'; %can transpose lengths to match dimensions of Link_Models
            else
                error('Array must be a vector or scalar');
            end
            
            Link_Models.Atmospheric_Loss=Atmos_Loss;
            Link_Models.Atmospheric_Loss_dB=-10*log10(Atmos_Loss);
        end

        function Link_Models=SetOpticalEfficiencyLoss(Link_Models,Satellite,Ground_Station)
            %%SETOPTICALEFFICIENCYLOSS set the optical efficiency loss in the link

            %% compute received wavelenth from doppler shift
            Doppler_Wavelength = DopplerShift(Ground_Station,Satellite);
            Filter_Efficiency = ComputeTransmission(Satellite.Detector.Spectral_Filter,Doppler_Wavelength);

            Eff = Ground_Station.Source.Efficiency ...
            * Ground_Station.Telescope.Optical_Efficiency ...
            * Satellite.Detector.Detection_Efficiency ...
            * Satellite.Detector.Jitter_Loss ...
            * Satellite.Telescope.Optical_Efficiency ...
            * Filter_Efficiency;


            %% input validation
            if ~all(isreal(Eff)&Eff>=0)
                error('optical efficiency loss must be a real, positive array of numeric values')
            end
            if isscalar(Eff)
                Eff=Eff*ones(1,Link_Models.N); %if provided a scalar, put this into everywhere in the array 
            elseif isrow(Eff)
            elseif iscolumn(Eff)
                Eff=Eff'; %can transpose lengths to match dimensions of Link_Models
            else
                error('Array must be a vector or scalar');
            end

            Link_Models.Optical_Efficiency_Loss=Eff;
            Link_Models.Optical_Efficiency_Loss_dB=-10*log10(Eff);
        end

        function Link_Models=SetAPTLoss(Link_Models,Satellite,Ground_Station)
            %%SETAPTLOSS set the acquistion, pointing and tracking loss of the link


            %% Acquisition, pointing and tracking loss
            %see Wiki for calculation details. QKD signal is assumed to be
            %a gaussian beam.
            Acquisition_Pointing_Tracking_Loss=...
                Ground_Station.Telescope.FOV^2/(Ground_Station.Telescope.Pointing_Jitter^2+Ground_Station.Telescope.FOV^2)*...%satellite pointing loss, assumes gaussian beam
                (1-exp(-(Satellite.Telescope.FOV^2/(8*Satellite.Telescope.Pointing_Jitter^2))));%ground station pointing loss, assumes flat-top FOV



            %% input validation
            if ~all(isreal(Acquisition_Pointing_Tracking_Loss)&Acquisition_Pointing_Tracking_Loss>=0)
                error('tracking loss must be a real, nonnegative array of numeric values')
            end
            if isscalar(Acquisition_Pointing_Tracking_Loss)
                Acquisition_Pointing_Tracking_Loss=Acquisition_Pointing_Tracking_Loss*ones(1,Link_Models.N); %if provided a scalar, put this into everywhere in the array 
            elseif isrow(Acquisition_Pointing_Tracking_Loss)
            elseif iscolumn(Acquisition_Pointing_Tracking_Loss)
                Acquisition_Pointing_Tracking_Loss=Acquisition_Pointing_Tracking_Loss'; %can transpose lengths to match dimensions of Link_Models
            else
                error('Array must be a vector or scalar');
            end

            Link_Models.APT_Loss=Acquisition_Pointing_Tracking_Loss;
            Link_Models.APT_Loss_dB=-10*log10(Acquisition_Pointing_Tracking_Loss);
        end

        function [Link_Models,Turbulence_Beam_Width] = SetTurbulenceLoss(Link_Models,Satellite,Ground_Station,Geo_Spot_Size)
            %%SETTURBULENCELOSS set the turbulence loss of the link
            %Geo_Spot_Size is the geometrically-limited spot size at the
            %receiver

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
            Elevation_Flags = Link_Models.Elevation>0;
            Zenith = 90-Link_Models.Elevation(Elevation_Flags);
            Satellite_Altitude = Satellite.Altitude(Elevation_Flags)';
            Atmospheric_Turbulence_Coherence_Length = ...
                atmospheric_turbulence_coherence_length_uplink(Wavenumber,...
                                             Zenith, ...
                                             Satellite_Altitude, ghv_defaults('Standard',Link_Models.Turbulence));
            %output variables
            Turbulence_Beam_Width(~Elevation_Flags)=0;
            Turbulence_Beam_Width(Elevation_Flags) = long_term_gaussian_beam_width(Geo_Spot_Size(Elevation_Flags), Link_Models.Length(Elevation_Flags) ,...
                                        Wavenumber, Atmospheric_Turbulence_Coherence_Length);
            %residual beam wander is not needed here as this is dealt with in
            %APT loss
            %wander_tl = residual_beam_wander(error_snr, error_delay, error_centroid, ...
            %                                   error_tilt, spot_tl, L);

            %turbulence loss is the ratio of geometric and turbulent spot areas
            Turb_Loss(~Elevation_Flags)=0;
            Turb_Loss(Elevation_Flags) = (Turbulence_Beam_Width(Elevation_Flags)./Geo_Spot_Size(Elevation_Flags)).^(-2);



            %% input validation
            if ~all(isreal(Turb_Loss)&Turb_Loss>=0)
                error('tracking loss must be a real, nonnegative array of numeric values')
            end
            if isscalar(Turb_Loss)
                Turb_Loss=Turb_Loss*ones(1,Link_Models.N); %if provided a scalar, put this into everywhere in the array 
            elseif isrow(Turb_Loss)
            elseif iscolumn(Turb_Loss)
                Turb_Loss=Turb_Loss'; %can transpose lengths to match dimensions of Link_Models
            else
                error('Array must be a vector or scalar');
            end

            Link_Models.Turbulence_Loss=Turb_Loss;
            Link_Models.Turbulence_Loss_dB=-10*log10(Turb_Loss);
            Link_Models.Turbulent_Spot_Size = Turbulence_Beam_Width;
            Link_Models.r0(Elevation_Flags) = Atmospheric_Turbulence_Coherence_Length;

        end

    end
    methods (Access=public)
        function Satellite_Uplink_Model=Satellite_Uplink_Model(N,Visibility,Turbulence)
            %%Satellite_Downlink_Model construct an instance of Satellite_Downlink_Model with the indicated number of modelled points
            if nargin==0
                return
            elseif nargin==1
                Satellite_Uplink_Model=SetNumSteps(Satellite_Uplink_Model,N);
            elseif nargin==2
                Satellite_Uplink_Model=SetNumSteps(Satellite_Uplink_Model,N);
                Satellite_Uplink_Model=SetVisibility(Satellite_Uplink_Model,Visibility);
            elseif nargin==3
                Satellite_Uplink_Model=SetNumSteps(Satellite_Uplink_Model,N);
                Satellite_Uplink_Model=SetVisibility(Satellite_Uplink_Model,Visibility);
                Satellite_Uplink_Model=SetTurbulence(Satellite_Uplink_Model,Turbulence);
            else
                error('To instantiate link model, provide a number of steps and, optionally, a visibility string')
            end
        end

    end
end
