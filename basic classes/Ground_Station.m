%Author: Cameron Simmons, Peter Barrow
%Date: 24/1/22

classdef Ground_Station < Located_Object
    % GROUND_STATION an object containing all of the simulation parameters of the ground station

    properties (Abstract = false, SetAccess = protected)
        % name of protocol to be used
        %Protocol{mustBeText} = '';

        % a detector object, validated individually in subclasses
        Detector
        Telescope Telescope

        % is is possible to replace this with a hash or index to get the object
        % from the toolbox scenario? Maybe the name is enough?
        toolbox_groundStation

        % pointer to a file containing the background count rate data for this 
        % ground station (stored in counts/ s steradian nm)
        Background_Count_Rate_File_Location{mustBeText} = 'none';

        % background count rate (in counts/s) as a function of heading and 
        % elevation, stored as a structure with fields 'Count_Rate', 'Heading' 
        % and 'Elevation'
        Background_Rates{isstruct, ...
                         isfield(Background_Rates, 'Heading'), ...
                         isfield(Background_Rates, 'Elevation'), ...
                         isfield(Background_Rates, 'Count_Rate')};

        %the camera which receives beacon light, if beaconing is simulated
        Camera=[];

        %% source for uplink
        Source;
    end

    properties (Abstract = false, SetAccess = protected, Hidden = true)
        % Heading of the satellite in degrees as seen from the OGS
        Headings{mustBeVector} = nan;

        % Elevation of the satellite in degrees as seen from the OGS
        Elevations{mustBeVector} = nan;

        % the coordinates of the satellite relative to the ground station in 
        % metres east, north and up
        Satellite_ENUs{mustBeNumeric}

        % range to the satellite in m over many time steps
        Satellite_Ranges{mustBeVector} = nan;

        % minimum elevation to establish a link in deg
        Elevation_Limit{mustBeScalarOrEmpty} = 30;

        % count rates at the Ground station due to light pollution
        Light_Pollution_Count_Rates{mustBeVector, mustBeNonnegative} = 0;

        % count rates at the Ground station due to dark counts
        Dark_Count_Rates{mustBeVector, mustBeNonnegative} = 0;

        % count rates at the Ground station due to reflected light off satellite
        Reflection_Count_Rates{mustBeVector, mustBeNonnegative} = 0;

        % count rates at the Ground station due to reflected light off satellite
        Directed_Count_Rates{mustBeVector, mustBeNonnegative} = 0;

        % SMARTS data paths
        smarts_results = {};

        % SMARTS wavelengths
        Wavelengths = [];

        % Spectra of atmosphere as received by the ground station in terms of
        % photon number
        Sky_Irradiance = [];
        Sky_Radiance = [];

        % Sky photons calculated from 'Sky_Spectra' via
        % 'basic classes/sky_photons.m', see reference there for details.
        Sky_Photons = [];
        Sky_Photon_Rate = [];
    end

    methods
        function [Ground_Station, varargout] = Ground_Station(Detector, Telescope, varargin)
            % GROUND_STATION instantiate a ground station using either its
            % component classes and requiring a name and location (LLA = lat
            % lon alt)

            p = inputParser;
            % required inputs
            addRequired(p, 'Telescope');
            % optional inputs
            addParameter(p,'Detector',[])
            addParameter(p, 'scenario', nan);
            addParameter(p, 'useSatCommsToolbox', false);
            addParameter(p, 'startTime', nan);
            addParameter(p, 'stopTime', nan);
            addParameter(p, 'sampleTime', nan);
            addParameter(p, 'latitude', nan);
            addParameter(p, 'longitude', nan);
            addParameter(p, 'altitude', 0);
            addParameter(p, 'LLA', nan);
            addParameter(p, 'name', 'Bob');
            addParameter(p, 'Background_Count_Rate_File_Location', 'none');
            addParameter(p, 'Camera', []);
            addParameter(p, 'Source', []);

            parse(p, Detector, Telescope, varargin{:});

            % set Telescope parameters
            Ground_Station.Detector = Detector;
            Ground_Station.Telescope = Telescope;

            % set Telescope to be wavelength of detector
            Ground_Station.Telescope = SetWavelength(Telescope, ...
                                                     Detector.Wavelength);

            % set Background count rate data
            Ground_Station = ReadBackgroundCountRateData(Ground_Station, ...
                                p.Results.Background_Count_Rate_File_Location);

            % set camera
            Ground_Station.Camera = p.Results.Camera;
            
            if isnan(p.Results.LLA)
                LLA = [p.Results.latitude, p.Results.longitude, p.Results.altitude];
            else
                LLA = p.Results.LLA;
            end

            %set source for uplink
            Ground_Station.Source = p.Results.Source;

            if any(arrayfun(@isnan, LLA))
                error(['No location supplied for ground station, require:', ...
                       newline, char(9), 'latitude and longitude' ...
                       newline, char(9), 'optionally altitude']);
            else
                lat = LLA(1);
                lon = LLA(2);
                alt = LLA(3);
            end

            % set location using custom method
            Ground_Station = SetPosition(Ground_Station, ...
                                         'LLA', p.Results.LLA, ...
                                         'Name', p.Results.name);

            if (p.Results.useSatCommsToolbox == true) & (~isobject(p.Results.scenario))
                Ground_Station.useSatCommsToolbox = true;
                scenario = satelliteScenarioWrapper(p.Results.startTime, ...
                                                    p.Results.stopTime, ...
                                                    'sampleTime', ...
                                                    p.Results.sampleTime);
                varargout{1} = scenario;
            end

            if isobject(p.Results.scenario)
                Ground_Station.useSatCommsToolbox = true;
                scenario = p.Results.scenario;
            end
            
            if Ground_Station.useSatCommsToolbox == true
                Ground_Station.toolbox_groundStation = groundStation(scenario, ...
                                                                     lat, ...
                                                                     lon, ...
                                                                     alt, ...
                                                                     'Name', ...
                                                                     p.Results.name);
            end
        end


        function [Background_Rates, Background_Rates_sr_nm] = GetLightPollutionCountRate(Ground_Station, Headings, Elevations)
            % GETLIGHTPOLLUTIONCOUNTRATE return the background count rate
            % values closest to the input headings and elevations in an
            % array of the same dimensions at the given wavelength

            % input validation
            % heading and elevation arrays must be same dimensions
            assert(AreSameDimensions(Headings, Elevations),...
                'heading and elevation arrays must be of same dimensions')

            % assign memory for Background_Rates
            Background_Rates = zeros(size(Headings));
            Background_Rates_sr_nm = zeros(size(Headings));

            detector_eff = Ground_Station.Detector.Detection_Efficiency;
            filter_width = Ground_Station.Detector.Spectral_Filter_Width;
            fov = Ground_Station.Telescope.FOV;
            Known_Headings = Ground_Station.Background_Rates.Heading;
            Known_Elevation = Ground_Station.Background_Rates.Elevation;

            % iterating over entries in heading and elevation arrays
            Dimensions = size(Headings);
            for i = 1:Dimensions(1)
                for j = 1:Dimensions(2)
                    Heading = Headings(i, j);
                    Elevation = Elevations(i, j);

                    % find closest background count rate value to given heading
                    % and elevation
                    % find minimum distance from value
                    % does this need to be abs, shouldnt mod take care of that?
                    [~, Heading_Index] = min(abs(mod(Known_Headings - Heading, 360)));

                    % take a single, unique minimum
                    Heading_Index = Heading_Index(1);
                    [~, Elevation_Index] = min(abs(Known_Elevation - Elevation));

                    % get background counts per steradian
                    Background_Rates_sr_nm(i, j) = Ground_Station.Background_Rates.Count_Rate(Heading_Index, Elevation_Index);
                    % if any values are negative, nan or inf set them to zero
                    Background_Rates_sr_nm( Background_Rates_sr_nm < 0 ) = 0;
                    Background_Rates_sr_nm( isnan(Background_Rates_sr_nm) ) = 0;
                    Background_Rates_sr_nm( isinf(Background_Rates_sr_nm) ) = 0;

                    % convert to counts in this specific telescope
                    Background_Rates(i, j) = prod([detector_eff, ...
                                                   Background_Rates_sr_nm(i, j), ...
                                                   pi * (fov/2)^2, ...
                                                   filter_width]);


                end
            end
        end


        function Ground_Station = ReadBackgroundCountRateData(Ground_Station, Background_Count_Rate_File_Location)
            % input validation
            if ~nargin == 2
                error('ReadBackgroundCountRateData takes only a Ground_Station object and .mat file location as arguments');
            end

            % if 'none' is provided
            if isequal(Background_Count_Rate_File_Location, 'none')
                Ground_Station.Background_Count_Rate_File_Location = 'none';
                Ground_Station.Background_Rates.Count_Rate = 0;
                Ground_Station.Background_Rates.Heading = 0;
                Ground_Station.Background_Rates.Elevation = 0;
                return
            end

            % add background light files to path
            addpath(LocationofFile(Background_Count_Rate_File_Location));
            % if a file is provided, use this file location
            if ~(exist(Background_Count_Rate_File_Location, 'file'))
                error('cannot find a mat file of that name and location');
            end
            Ground_Station.Background_Count_Rate_File_Location = Background_Count_Rate_File_Location;

            % read in
            Ground_Station.Background_Rates = load(Background_Count_Rate_File_Location);
        end


        function Ground_Station = SetWavelength(Ground_Station, Wavelength)
            % SETWAVELENGTH set the wavelength (in nm) of the receiver
            Ground_Station.Detector = SetWavelength(Ground_Station.Detector, Wavelength);
        end


        function [Total_Background_Count_Rate,Ground_Station] = ComputeTotalBackgroundCountRate(Ground_Station, Background_Sources, Satellite, Headings, Elevations, SMARTS_Configuration)
            % COMPUTETOTALBACKGROUNDCOUNTRATE return the total count rate
            % at the given headings and elevations
            

            %% find light pollution count rate for given headings and elevations
            %if a SMARTS config is provided, use SMARTS for this calculation
            %% Run smarts
            % If 'smarts_configuration' contains a 'SMARTS_input' object run a
            % SMARTS simulation *ONLY* on the azimuth (heading) and elevation
            % positions that correspond to where 'Line_Of_Sight_Flags' is set
            % to true. (this is so that beaconing noise is simulated)
            if ~isempty(SMARTS_Configuration)
                [smarts_results, Wavelengths, Sky_Irradiance, Sky_Radiance, ...
                 Sky_Photons, sky_photon_rate] = ...
                    smartsSimForPass(SMARTS_Configuration, ...
                                     Headings, Elevations, ...
                                     Satellite.Times, ...
                                     Elevations>0, ...
                                     Ground_Station);

                Ground_Station.smarts_results = smarts_results;
                Ground_Station.Wavelengths = Wavelengths;
                Ground_Station.Sky_Irradiance = Sky_Irradiance;
                Ground_Station.Sky_Radiance = Sky_Radiance;
                Ground_Station.Sky_Photons = Sky_Photons;
                Ground_Station.Sky_Photon_Rate = sky_photon_rate;
                
                %add sky photons to OGS background count rate sum
                Light_Pollution_Count_Rate = sky_photon_rate';
            else
                %if no SMARTS config provided, use legacy system of lookup table
                Light_Pollution_Count_Rate = GetLightPollutionCountRate(Ground_Station, Headings, Elevations);
            end



            % Reflected light pollution
            Reflection_Count_Rate = zeros(size(Light_Pollution_Count_Rate));
            for i = 1:length(Background_Sources)
                % limit reflected light pollution to line of sight between
                % satellite and background source
                [~, Background_Source_Elevations] = RelativeHeadingAndElevation(Satellite, Background_Sources(i));
                Elevation_Limit = Background_Sources(i).Elevation_Limit; %#ok<*PROPLC>
                Possible_Refleced_Counts = GetReflectedLightPollution(Background_Sources(i), Satellite, Ground_Station);
                Reflection_Count_Rate(Background_Source_Elevations>Elevation_Limit) = ...
                    Reflection_Count_Rate(Background_Source_Elevations>Elevation_Limit)+...
                    Possible_Refleced_Counts(Background_Source_Elevations>Elevation_Limit); % #ok<*AGROW>
            end

            Direct_Count_Rate = zeros(size(Headings));
            %%%%%%%%%%%%%This does not currently work
            %{
            for i = 1:length(Background_Sources)
                solar_counts = Background_Sources(i).GetDirectedLight(Ground_Station, 16.35) .* ones(size(Direct_Count_Rate));
                Direct_Count_Rate = Direct_Count_Rate + solar_counts;
            end
            %}

            % Dark_Counts
            Dark_Counts = ones(size(Headings))*Ground_Station.Detector.Dark_Count_Rate;

            % output value
            Ground_Station.Light_Pollution_Count_Rates = Light_Pollution_Count_Rate;
            Ground_Station.Reflection_Count_Rates = Reflection_Count_Rate;
            Ground_Station.Dark_Count_Rates = Dark_Counts;
            Ground_Station.Directed_Count_Rates = Direct_Count_Rate;
            Total_Background_Count_Rate = Light_Pollution_Count_Rate + ...
                                          Reflection_Count_Rate + ...
                                          Direct_Count_Rate + ...
                                          + Dark_Counts;
        end


        function PlotBackgroundCountRates(Ground_Station, Plotting_Indices, X_Axis)
            % PLOTBACKGROUNDCOUNTRATES plot the background count rates
            % affecting the ground station
            %disp(size(Ground_Station.Dark_Count_Rates(Plotting_Indices)'));
            %disp(size(Ground_Station.Reflection_Count_Rates(Plotting_Indices)'));
            %disp(size(Ground_Station.Light_Pollution_Count_Rates(Plotting_Indices)'));
            %disp(size(Ground_Station.Directed_Count_Rates(Plotting_Indices)'));
            
            area(X_Axis, ...
                 [Ground_Station.Dark_Count_Rates(Plotting_Indices)', ...
                 Ground_Station.Reflection_Count_Rates(Plotting_Indices)', ...
                 Ground_Station.Light_Pollution_Count_Rates(Plotting_Indices)', ...
                 Ground_Station.Directed_Count_Rates(Plotting_Indices)']);
            ylabel('Background Count Rate (cps)')

            % adjust legend to represent what is plotted
            % reflection and light poluution are non zero
            if any(Ground_Station.Reflection_Count_Rates(Plotting_Indices))&&any(Ground_Station.Light_Pollution_Count_Rates(Plotting_Indices))
                legend('Dark counts', 'Reflection', 'Light pollution');
                % no reflection
            elseif (~any(Ground_Station.Reflection_Count_Rates(Plotting_Indices)))&&any(Ground_Station.Light_Pollution_Count_Rates(Plotting_Indices))
                legend('Dark counts', '', 'Light pollution','');
                % no Light pollution
            elseif (any(Ground_Station.Reflection_Count_Rates(Plotting_Indices)))&&(~any(Ground_Station.Light_Pollution_Count_Rates(Plotting_Indices)))
                legend('Dark counts', 'Reflection', '');
            elseif (any(Ground_Station.Directed_Count_Rates(Plotting_Indices)))&&(~any(Ground_Station.Directed_Count_Rates(Plotting_Indices)))
                legend('Dark counts', 'Directed count rates (Solar)', '');
            else
                % neither reflection nor light pollution
                legend('Dark counts', '', '');
            end
            legend('Location', 'southeast')
        end


        function Ground_Station = SetElevationLimit(Ground_Station, Elevation_Limit)
            % SETELEVATIONLIMIT set the minimum elevation over which
            % communication can occur
            Ground_Station.Elevation_Limit = Elevation_Limit;
        end

        function PlotLOS(Ground_Station, Satellite_Altitude)
            % PLOTLOS plot the ground station and its line of sight to a
            % given altitude

            % plot ground station
            geoplot(Ground_Station.Latitude, Ground_Station.Longitude, 'k*', 'MarkerSize', 20);
            hold on
            % plot the ground station's elevation window
            Headings = 1:359;
            WindowLat = zeros(1, 359);
            WindowLon = zeros(1, 359);
            ArcDistance = ComputeLOSWindow(Satellite_Altitude, Ground_Station.Elevation_Limit);
            for Heading = Headings
                [CurrentWindowLat, CurrentWindowLon] = MoveAlongSurface(Ground_Station.Latitude, Ground_Station.Longitude, ArcDistance, Heading);
                WindowLat(Heading) = CurrentWindowLat;
                WindowLon(Heading) = CurrentWindowLon;
            end
            geoplot(WindowLat, WindowLon, 'k--')
            AddToLegend('Ground Station orbit LOS', 'Ground Station')
        end

        function [Total_Background_Count_Rate,Ground_Station] = ComputeTotalBeaconNoisePower(Ground_Station, Background_Sources, Satellite, Headings, Elevations)
            % COMPUTETOTALBEACONNOISE return the total noise present in the
            % beacon system, from camera, sky and background sources
            


            %% sky noise goes here. Needs SMARTS integration
            %run SMARTS
            [smarts_results, Wavelengths, Sky_Irradiance, Sky_Radiance, ...
          Sky_Photons, sky_photon_rate] = ...
    smartsSimForPass(solar_background_errol, Headings, Elevations, [], Ground_Station);

            %% Reflected light pollution
            %reflected light pollution does not contribute to noise in this
            %case. All downlinked light from the satellite at the beacon
            %wavelength should be considered a valid beacon, even if it has high
            %divergence

            % camera noise power
            Noise_Power = ones(size(Headings))*Ground_Station.Beacon.Noise;
            
            % output value
            Ground_Station.Light_Pollution_Count_Rates = Light_Pollution_Count_Rate;
            Ground_Station.Reflection_Count_Rates = Reflection_Count_Rate;
            Ground_Station.Dark_Count_Rates = Dark_Counts;
            Total_Background_Count_Rate = Light_Pollution_Count_Rate+Reflection_Count_Rate+Dark_Counts;
        end

    end
end
