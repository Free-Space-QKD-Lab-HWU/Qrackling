classdef Background_Source < Located_Object
    %Background_Source a source of optical interference for optical comms

    %this background source is modelled as a point source which has
    %pointance (power per unit solid angle) spread over many wavelengths
    properties
        Spectral_Pointance{mustBeNumeric}                                  %power per unit solid angle as a function of wavelength in W/str/nm for this source
        Wavelength_Limits{mustBeNumeric}                                   %wavelengths (in nm) over which the radiance per unit bandwidth is specified
        Elevation_Limit{mustBeScalarOrEmpty, mustBeLessThanOrEqual(Elevation_Limit, 90)} = 0;%minimum elevation at which laser can be fired in degrees
    end

    methods
        function obj = Background_Source(LLA, Spectral_Pointance, Wavelength_Limits, varargin)
            %Background_Source Construct an instance of this class
            %specify and set location (lat, lon, alt), radiance and
            %wavelength range

            %% create and use input parser
            P = inputParser;
            %required inputs
            addRequired(P, 'LLA');
            addRequired(P, 'Spectral_Pointance');
            addRequired(P, 'Wavelength_Limits');
            %optional inputs
            addParameter(P, 'Location_Name', 'Background source');
            addParameter(P, 'Elevation_Limit', obj.Elevation_Limit)
            %parse inputs
            parse(P, LLA, Spectral_Pointance, Wavelength_Limits, varargin{:});

            %% set values
            obj = SetPosition(obj, 'LLA', P.Results.LLA, 'Name', P.Results.Location_Name);
            obj.Spectral_Pointance = P.Results.Spectral_Pointance;
            obj.Wavelength_Limits = P.Results.Wavelength_Limits;
            obj = SetElevationLimit(obj, P.Results.Elevation_Limit);
        end

        function Total_Spectral_Pointance = GetRadiantEmission(Background_Source, Wavelength_Floor, Wavelength_Ceiling)
            %GETRADIANTEMISSION output the total emission in a wavelength
            %range specified by its minimum and maximum

            %% input validation
            if ~(isscalar(Wavelength_Floor)&&isscalar(Wavelength_Ceiling))
                error('Wavelength_Floor and Wavelength_Ceiling must be scalar values')
            end
            if ~(isnumeric(Wavelength_Floor)&&isnumeric(Wavelength_Ceiling)&&Wavelength_Ceiling >= 0&&Wavelength_Floor >= 0)
                error('Wavelength_Floor and Wavelength_Ceiling must be non-negative numeric values')
            end

            %% compute emission inside specified range
            %find and store wavelength range and radiance
            Wavelength_Limits = Background_Source.Wavelength_Limits; %#ok<*PROPLC>
            Spectral_Pointance = Background_Source.Spectral_Pointance;

            %% detect if no emission occurs in specified range
            if Wavelength_Ceiling<min(Wavelength_Limits)||Wavelength_Floor>max(Wavelength_Limits)
                Total_Spectral_Pointance = 0;
                return
            end

            %% detect if entire background source emission is within wavelength ceiling and floor
            if Wavelength_Floor <= min(Wavelength_Limits)&&Wavelength_Ceiling >= max(Wavelength_Limits)
                Total_Spectral_Pointance = dot(Spectral_Pointance, Wavelength_Limits(2:end)-Wavelength_Limits(1:end-1));
                return
            end

            %% detect if entire requested range is within one radiance measurement
            if all(Wavelength_Floor >= Wavelength_Limits|Wavelength_Ceiling <= Wavelength_Limits)
                [~, Relevant_Radiance_Index] = min(Wavelength_Limits >= Wavelength_Floor);
                Relevant_SP = Spectral_Pointance(Relevant_Radiance_Index);
                Total_Spectral_Pointance = Relevant_SP*(Wavelength_Ceiling-Wavelength_Floor)/(Wavelength_Limits(Relevant_Radiance_Index+1)-Wavelength_Limits(Relevant_Radiance_Index));
                return
            end



            %% segment wavelength vector by bounds
            Below_Wavelength_Floor_Indices = Wavelength_Limits<Wavelength_Floor;
            Between_Bounds_Indices = (Wavelength_Limits >= Wavelength_Floor)&(Wavelength_Limits <= Wavelength_Ceiling);
            Above_Wavelength_Ceiling_Indices = Wavelength_Limits>Wavelength_Ceiling;

            %% compute radiance from lower bound edge
            %get nearby values
            Below_Wavelength_Floor = Wavelength_Limits(Below_Wavelength_Floor_Indices);
            Immediately_Below_Wavelength_Floor = max(Below_Wavelength_Floor);
            Between_Bounds = Wavelength_Limits(Between_Bounds_Indices);
            Immediately_Above_Wavelength_Floor = min(Between_Bounds);

            %compute value
            Lower_Bound_Radiance = Spectral_Pointance(sum(Below_Wavelength_Floor_Indices))*(Immediately_Above_Wavelength_Floor-Wavelength_Floor)/(Immediately_Above_Wavelength_Floor-Immediately_Below_Wavelength_Floor);

            %% compute radiance from upper bound edge
            %get nearby values
            Above_Wavelength_Ceiling = Wavelength_Limits(Above_Wavelength_Ceiling_Indices);
            Immediately_Above_Wavelength_Ceiling = min(Above_Wavelength_Ceiling);
            Immediately_Below_Wavelength_Ceiling = max(Between_Bounds);

            %compute value
            Upper_Bound_Radiance = Spectral_Pointance(end+1-sum(Above_Wavelength_Ceiling_Indices))*(Wavelength_Ceiling-Immediately_Below_Wavelength_Ceiling)/(Immediately_Above_Wavelength_Ceiling-Immediately_Below_Wavelength_Ceiling);

            %% compute radiance between bounds
            In_Range_Radiance = sum(Spectral_Pointance(Between_Bounds_Indices));

            %% compute total
            Total_Spectral_Pointance = Lower_Bound_Radiance+In_Range_Radiance+Upper_Bound_Radiance;

        end

        function [Reflected_Count_Rate, Reflected_Power] = GetReflectedLightPollution( ...
                                Background_Source, Satellite, Ground_Station)
            %%GETREFLECTEDLIGHTPOLLUTION return the count rate and optical
            %%power reflected off a satellite and into a ground station
            %%from a background source over many time periods
            h = 6.62607015*10^-34;%plank's constant
            c = 299792458; %speed of light

            %% compute emission inside the ground_Station wavelength filter width
            Wavelength_Floor = Ground_Station.Detector.Wavelength ...
                               -Ground_Station.Detector.Spectral_Filter_Width / 2;

            Wavelength_Ceiling = Ground_Station.Detector.Wavelength ...
                                 +Ground_Station.Detector.Spectral_Filter_Width / 2;

            Radiant_Power = GetRadiantEmission(Background_Source, Wavelength_Floor, Wavelength_Ceiling);

            %% get reflective link loss
            Sat_Ref_Link_Model = Satellite_Reflection_Link_Model(Satellite.N_Steps);

            Sat_Ref_Link_Model = Compute_Link_Loss(Sat_Ref_Link_Model, ...
                                                   Satellite, ...
                                                   Ground_Station, ...
                                                   Background_Source);

            [~, ~, Total_Loss] = SetTotalLoss(Sat_Ref_Link_Model);

            %% use this to compute reflected power
            Reflected_Power = Radiant_Power .* Total_Loss;

            %% and photon count
            Reflected_Count_Rate = Reflected_Power * (...
                    Ground_Station.Detector.Wavelength * 10^-9) / (h*c);

        end

        function [Direct_Count_rate] = GetDirectedLight(...
                Background_Source, Ground_Station, telescope_field_diameter)
            % 20 / 09 / 22
            % Method relies on converting spectral pointance to spectral
            % radiance, this is fortunately straight forward. Pointance
            % describes the flux emitted from a light source for the entire
            % projected area, converting this to radiance is as simple as
            % dividing by the projected area. Projected are is simply the 
            % square of the distance between the ground station and the sun.

            h = 6.62607015*10^-34; % plank's constant
            c = 299792458; % speed of light

            % DOI: 10.1103/PhysRevApplied.16.014067 - Equation (1)
            N_SKY_PHOTONS = @(RADIANCE, RX_D, FOV, WL, DWL, DT) ...
                        (RADIANCE .* (FOV * pi * (RX_D^2) * WL * DWL * DT)) ...
                        ./ (4 * h * c);
            
            % Next we need the solid angle FOV for the telescope, this can be
            % calculated from the field-diameter (in arc-minutes) of the 
            % telescope converted to radians and then used to calculate the 
            % solid angle FOV in terms of steradians.
            % TODO: telescope_field_diameter will have to be parameterised 
            % within the telescope class properly for smooth operation
            fd2fov = @(fd_arcmin) 2 * pi ...
                                  * (1 - cos(deg2rad((fd_arcmin ./ 60) ./ 2)));

            telescope_field_diameter = 16.35;
            fov = fd2fov(telescope_field_diameter);

            % As of right now we are assuming that we have a detector that only
            % operated within the region defined by the spectral filter.
            % TODO: THIS MUST BE EXPANDED OUT LATER TO FULLY ENCOMPASS EFFECTS
            % AROUND BLINDING THE DETECTOR

            % Quick lambda function to get the lower and upper bounds
            array_limits = @(value, width) value + ([-1, 1] .* (width / 2));
            % Sadly we can't do [wl_floor, wl_ceil] = array_limits(..) so this
            % will have to do
            wavelength = Ground_Station.Telescope.Wavelength;
            width = Ground_Station.Detector.Spectral_Filter_Width;
            wl_lim = array_limits(wavelength, width);
            wl_floor = wl_lim(1);
            wl_ceil = wl_lim(2);
            
            % Another lambda function as short hand for making a mask that
            % extends from the lower bound up to the upper bound from above
            remaining = @(arr, lb, ub) (arr > lb) & (arr < ub);
            
            % Get the wavelengths (maybe we need these...)
            wls = Background_Source.Wavelength_Limits( ...
                        (Background_Source.Wavelength_Limits > wl_floor) ...
                        & (Background_Source.Wavelength_Limits < wl_ceil) ...
                            );

            % Get the values for the spectral pointance within the wavelength
            % range we are after and divide through by the projected area to 
            % get the spectral radiance
            ps = Background_Source.Spectral_Pointance( ...
                        (Background_Source.Wavelength_Limits > wl_floor) ...
                        & (Background_Source.Wavelength_Limits < wl_ceil) ...
                            ) ./ (Ground_Station.ComputeDistanceBetween(...
                                    Background_Source) .^ 2);

            N_sky_photons = N_SKY_PHOTONS(...
                            ps, Ground_Station.Telescope.Diameter, ...
                            fov, wavelength * (1e-9), width * (1e-9), ...
                            1); % 1 second integration time (DT in ...
                                % N_SKY_PHOTONS) gives us total number of 
                                % counts per second
                            %Ground_Station.Detector.Time_Gate_Width);

            Direct_Count_rate = N_sky_photons;

            % NOTE: FROM TESTING     
            % In testing the results all come out incredibly pessimistic...
            % I don't think the results are correct however, the process inside
            % this function does model the parameter we are looking for and
            % does perform it correctly however, my suspicions are that the 
            % data in spectral pointance is for the sun as if it were a black
            % body and not taking into account any power loss according to 
            % scattering in the atmosphere. Here the values for pointance are 
            % as if we are looking directly at the sun...
            % Essentially this is the difference between solar radiance and
            % sky radiance.
            %   - Can what we need be calculated from SMARTS or MODTRAN
            
        end

        function PlotLOS(Background_Source, Satellite_Altitude)
            %% plot the location and LOS of a background source

            % plot ground station
            geoplot(Background_Source.Latitude, ...
                    Background_Source.Longitude, 'r*', 'MarkerSize', 8);
            hold on
            %plot the ground station's elevation window
            Headings = 1:359;
            WindowLat = zeros(1, 359);
            WindowLon = zeros(1, 359);
            ArcDistance = ComputeLOSWindow(Satellite_Altitude, ...
                                           Background_Source.Elevation_Limit);
            for Heading = Headings
                [CurrentWindowLat, CurrentWindowLon] = MoveAlongSurface(...
                                                Background_Source.Latitude, ...
                                                Background_Source.Longitude, ...
                                                ArcDistance, ...
                                                Heading);
                WindowLat(Heading) = CurrentWindowLat;
                WindowLon(Heading) = CurrentWindowLon;
            end
            geoplot(WindowLat, WindowLon, 'r--')
            AddToLegend([Background_Source.Location_Name, ' orbit LOS'], ...
                        Background_Source.Location_Name);
        end

        function Background_Source = SetElevationLimit(Background_Source, Elevation_Limit)
            %%SETELEVATIONLIMIT
            Background_Source.Elevation_Limit = Elevation_Limit;
        end

    end
end
