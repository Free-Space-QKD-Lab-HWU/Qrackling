classdef GroundStation < nodes.LocatedObject & nodes.QKDReceiver & ...
        nodes.QKDTransmitter & nodes.FreeSpaceOpticalNode
    % GroundStation
    %
    % An object containing all simulation parameters for a ground station
    % in a free-space optical communication system.
    %
    % Syntax:
    % gs = nodes.GroundStation(telescope, options)

    properties (Abstract = false, SetAccess = public)
        % camera - receives beacon light if beaconing is simulated
        camera = []

        % beacon - uplink beacon if simulated
        beacon = []

        % environment - describes atmospheric loss and background light
        environment (1,1) environment.Environment = ...
            environment.Environment.load("Examples\Data\atmospheric transmittance\Dark Environment 50km.mat")

        % elevation_limit - minimum elevation to establish a link (degrees)
        elevation_limit {mustBeScalarOrEmpty} = 30
    end


    methods
        function [ground_station, varargout] = GroundStation(telescope, options)
            % GroundStation
            %
            % Instantiate a ground station using component classes and location.
            %
            % Syntax:
            % gs = GroundStation(telescope, options)
            %
            % Inputs:
            % telescope - components.Telescope object
            % options   - struct with optional fields:
            %             .Detector, .Camera, .Beacon, .Source, .LLA,
            %             .latitude, .longitude, .altitude, .Name,
            %             .Environment, .scenario, .useSatCommsToolbox,
            %             .startTime, .stopTime, .sampleTime
            %
            % Output:
            % ground_station - GroundStation object

            arguments
                telescope (1,1) components.Telescope
                options.Detector = []
                options.Camera = []
                options.Beacon = []
                options.Source = []
                options.scenario = nan
                options.useSatCommsToolbox logical = false
                options.startTime datetime = NaT
                options.stopTime datetime = NaT
                options.sampleTime = []
                options.latitude (1,1) double = nan
                options.longitude (1,1) double = nan
                options.altitude (1,1) double = 0
                options.LLA = nan
                options.Name = 'Unnamed OGS'
                options.Environment = environment.Environment.Load("Examples\Data\atmospheric transmittance\Dark Environment 50km.mat")
            end

            if nargin == 0
                return
            end

            ground_station.telescope = telescope;

            if ~isempty(options.Source)
                ground_station.source = options.Source;
                ground_station.telescope = setWavelength(ground_station.telescope, ...
                    ground_station.source.wavelength);

                assert(isempty(options.Detector), ...
                    'GroundStation may only have a detector OR a source');

            elseif ~isempty(options.Detector)
                ground_station.detector = options.Detector;
                ground_station.telescope = setWavelength(ground_station.telescope, ...
                    ground_station.detector.wavelength);
            else
                error('Must provide either a source or detector');
            end

            wvl_opts = [0, 0];
            if ~isempty(options.Source)
                wvl_opts(1) = options.Source.wavelength;
            end
            if ~isempty(options.Detector)
                wvl_opts(2) = options.Detector.wavelength;
            end

            wvl = wvl_opts(find(wvl_opts ~= 0, 1));

            if isnan(ground_station.telescope.fov)
                if isnan(ground_station.telescope.wavelength)
                    ground_station.telescope = ground_station.telescope.setWavelength(wvl);
                end
                ground_station.telescope = ground_station.telescope.setFOV();
            end

            ground_station.camera = options.Camera;
            ground_station.beacon = options.Beacon;

            if isnan(options.LLA)
                LLA = [options.latitude, options.longitude, options.altitude];
            else
                LLA = options.LLA;
            end

            if any(isnan(LLA))
                error(['No location supplied for ground station. Required:', ...
                    newline, char(9), 'latitude and longitude', ...
                    newline, char(9), 'optionally altitude']);
            else
                lat = LLA(1);
                lon = LLA(2);
                alt = LLA(3);
            end

            ground_station = setPosition(ground_station, ...
                'LLA', LLA, ...
                'Name', options.Name);

            if options.useSatCommsToolbox && ~isobject(options.scenario)
                ground_station.useSatCommsToolbox = true;
                scenario = satelliteScenario(options.startTime, ...
                    options.stopTime, ...
                    'sampleTime', options.sampleTime);
                varargout{1} = scenario;
            end

            if isobject(options.scenario)
                ground_station.use_sat_comms_toolbox = true;
                scenario = options.scenario;
            end

            if ground_station.use_sat_comms_toolbox
                ground_station.toolbox_groundStation = groundStation( ...
                    scenario, lat, lon, alt, 'Name', options.Name);
            end

            ground_station.name = options.Name;
            ground_station.environment = options.Environment;
        end


        function ground_station = setWavelength(ground_station, wavelength)
            % setWavelength
            %
            % Set the wavelength (in nm) of the detector and telescope.
            %
            % Syntax:
            % ground_station = ground_station.setWavelength(wavelength)
            %
            % Inputs:
            % wavelength - numeric, wavelength in nanometers
            %
            % Output:
            % ground_station - updated GroundStation object

            ground_station.detector = setWavelength(ground_station.detector, wavelength);
        end


        function ground_station = setElevationLimit(ground_station, elevation_limit)
            % setElevationLimit
            %
            % Set the minimum elevation angle above which communication is allowed.
            %
            % Syntax:
            % ground_station = ground_station.setElevationLimit(elevation_limit)
            %
            % Inputs:
            % elevation_limit - scalar, minimum elevation angle in degrees
            %
            % Output:
            % ground_station - updated GroundStation object

            ground_station.elevation_limit = elevation_limit;
        end


        function plotLos(ground_station, satellite_altitude)
            % plotLos
            %
            % Plot the ground station and its line of sight to a satellite at a given altitude.
            %
            % Syntax:
            % ground_station.plotLos(satellite_altitude)
            %
            % Inputs:
            % satellite_altitude - numeric, altitude of satellite in meters

            geoplot(ground_station.latitude, ground_station.longitude, 'k*', 'MarkerSize', 20);
            hold on

            headings = 1:359;
            window_lat = zeros(1, 359);
            window_lon = zeros(1, 359);

            arc_distance = utilities.computeLosWindow(satellite_altitude, ground_station.elevation_limit);

            for heading = headings
                [lat_i, lon_i] = utilities.moveAlongSurface( ...
                    ground_station.latitude, ground_station.longitude, arc_distance, heading);
                window_lat(heading) = lat_i;
                window_lon(heading) = lon_i;
            end

            geoplot(window_lat, window_lon, 'k--');
            leg = legend;
            leg.String{end + 1} = "Ground Station";
            leg.String{end} = "Ground Station orbit LOS";
        end


        function ogs_details = getOgsDetails(ground_station)
            % getOgsDetails
            %
            % Return the ground station details required to instantiate a MATLAB
            % satellite simulator object.
            %
            % Syntax:
            % ogs_details = ground_station.getOgsDetails()
            %
            % Output:
            % ogs_details - cell array of name-value pairs for simulator construction

            ogs_details = {'Latitude', ground_station.latitude, ...
                'Longitude', ground_station.longitude, ...
                'Altitude', ground_station.altitude, ...
                'MinElevationAngle', ground_station.elevation_limit, ...
                'Name', ground_station.name};
        end


        function [satellite_scenario, sim_ogs] = addSimulatorOgs(ground_station, satellite_scenario)
            % addSimulatorOgs
            %
            % Add a MATLAB Satellite Communications Toolbox representation of the
            % ground station to the given satellite scenario.
            %
            % Syntax:
            % [satellite_scenario, sim_ogs] = ground_station.addSimulatorOgs(satellite_scenario)
            %
            % Inputs:
            % satellite_scenario - satelliteScenario object
            %
            % Outputs:
            % satellite_scenario - updated scenario object
            % sim_ogs            - groundStation object added to the scenario

            ogs_details = getOgsDetails(ground_station);
            sim_ogs = groundStation(satellite_scenario, ogs_details{:});
            sim_ogs.LabelFontSize = 25;
            sim_ogs.MarkerSize = 12;
        end
    end
end