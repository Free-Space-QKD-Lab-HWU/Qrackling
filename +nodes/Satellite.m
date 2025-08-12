classdef Satellite < nodes.LocatedObject & nodes.QKDReceiver & nodes.QKDTransmitter & nodes.FreeSpaceOpticalNode
    % Satellite
    %
    % Abstract class containing satellite properties for QKD simulation.
    % Supports initialization via orbit data file, TLE, or Kepler elements.
    % Implements both transmitter and receiver interfaces.
    %
    % Syntax:
    % sat = nodes.Satellite(telescope, options)
    %
    % The satellite must be initialized with either:
    % - OrbitDataFileLocation
    % - TLE (Two-Line Element set)
    % - KeplerElements
    %
    % If TLE or KeplerElements are used, startTime, stopTime, and sampleTime
    % must also be provided.

    %% Hidden properties for orbital modeling
    properties (SetAccess = protected, Hidden = true)
        % satellite_scenario - satelliteScenario object (if toolbox used)
        satellite_scenario

        % sc_sat - satellite object from toolbox
        sc_sat

        % kepler_elements - [sma, ecc, inc, raan, aop, ta]
        kepler_elements

        % tle_uncertainty - (1,1) double, uncertainty in orbital position (m)
        tle_uncertainty {mustBeScalarOrEmpty, mustBeNonnegative} = 5E3
    end

    %% Public satellite properties
    properties (SetAccess = protected, Hidden = false)
        % orbit_data_file_location - (1,1) string, path to orbit data file
        orbit_file_data_location {mustBeText} = ''

        % times - (1,N) datetime, satellite timestamps
        times {mustBeA(times, 'datetime')} = datetime.empty()

        % beacon - (1,1) object, beacon source on satellite
        beacon = []

        % camera - (1,1) object, beaconing camera on satellite
        camera = []
    end


    methods
        function [satellite, varargout] = Satellite(telescope, options)
            % Satellite
            %
            % Constructs a Satellite object using orbital data or orbital elements.
            %
            % Syntax:
            % [satellite, scenario] = nodes.Satellite(telescope, options)
            %
            % Inputs:
            % telescope - (1,1) components.Telescope, optical system
            % options   - struct with fields:
            %   .Source, .Detector, .Beacon, .Camera
            %   .OrbitDataFileLocation, .TLE, .KeplerElements
            %   .startTime, .stopTime, .sampleTime
            %   .ToolBoxSatellite, .scenario
            %   .TLE_Uncertainty
            %
            % Outputs:
            % satellite - (1,1) nodes.Satellite object
            % scenario  - optional satelliteScenario object (if generated)

            arguments
                telescope components.Telescope
                options.Source = []
                options.Detector = []
                options.Beacon = []
                options.Camera = []
                options.OrbitDataFileLocation = ''
                options.ToolBoxSatellite = []
                options.scenario = nan
                options.UseSatCommsToolbox (1,1) logical = false
                options.LLAT {mustBeNumeric} = []
                options.TLE = []
                options.KeplerElements = []
                options.semiMajorAxis = nan
                options.eccentricity = nan
                options.inclination = nan
                options.rightAscensionOfAscendingNode = nan
                options.argumentOfPeriapsis = nan
                options.trueAnomaly = nan
                options.startTime datetime = NaT
                options.stopTime datetime = NaT
                options.sampleTime = NaT
                options.Name = 'Unnamed Satellite'
                options.TLE_Uncertainty (1,1) {mustBeNonnegative} = 5E3
            end

            %% Support empty constructor
            if nargin == 0
                return
            end

            %% Extract and store Kepler elements
            sma = options.semiMajorAxis;
            ecc = options.eccentricity;
            inc = options.inclination;
            raan = options.rightAscensionOfAscendingNode;
            aop = options.argumentOfPeriapsis;
            ta = options.trueAnomaly;

            if ~any(isnan([sma, ecc, inc, raan, aop, ta])) && isempty(options.KeplerElements)
                kepler_elements = [sma, ecc, inc, raan, aop, ta];
            else
                kepler_elements = options.KeplerElements;
            end

            satellite.kepler_elements = kepler_elements;

            %% Store name
            satellite.name = options.Name;

            %% Validate orbital input
            assert(any([~isnan(options.OrbitDataFileLocation), ...
                       ~isnan(options.scenario), ...
                       ~isnan(options.ToolBoxSatellite), ...
                       ~isnan(options.TLE), ...
                       ~isnan(kepler_elements)]), ...
                              ['Must provide one of: OrbitDataFileLocation,' ...
                              'TLE, or KeplerElements'])

            %% Load orbit data
            if ~isempty(options.OrbitDataFileLocation)
                [satellite, lat, lon, alt, t] = readOrbitLLATFile(satellite, options.OrbitDataFileLocation);

            elseif ~isempty(options.LLAT)
                llat = options.LLAT;
                lat = llat(:, 1);
                lon = llat(:, 2);
                alt = llat(:, 3);
                time_seconds = llat(:, 4);

                if ~isempty(options.startTime)
                    t = options.startTime + seconds(time_seconds);
                else
                    t = datetime(2000, 1, 1, 12, 0, 0) + seconds(time_seconds);
                end

            elseif options.UseSatCommsToolbox
                if isempty(options.ToolBoxSatellite) || isempty(options.scenario)
                    error('Toolbox satellite and scenario must be provided')
                end

                [satellite, lat, lon, alt, t] = llatFromScenario( ...
                    satellite, ...
                    satCommsSatellite = options.ToolBoxSatellite, ...
                    scenario = options.scenario);

            else
                if isdatetime(options.startTime)
                    if isduration(options.sampleTime)
                        sample_time = seconds(options.sampleTime);
                    else
                        sample_time = options.sampleTime;
                    end

                    scenario = satelliteScenario( ...
                        options.startTime, options.stopTime, sample_time);
                else
                    scenario = options.scenario;
                end

                varargout{1} = scenario;

                if ~isempty(options.TLE)
                    [satellite, lat, lon, alt, t] = llatFromScenario( ...
                        satellite, 'scenario', scenario, 'TLE', options.TLE);

                elseif ~isempty(kepler_elements)
                    if size(kepler_elements, 2) ~= 6
                        error(['Require all 6 Kepler Elements: ', ...
                            'semiMajorAxis, eccentricity, inclination, ', ...
                            'RAAN, argumentOfPeriapsis, trueAnomaly'])
                    end

                    [satellite, lat, lon, alt, t] = llatFromScenario( ...
                        satellite, 'scenario', scenario, 'KeplerElements', kepler_elements);
                end
            end

            %% Validate orbit data dimensions
            if ~utilities.haveEqualDimensions(t, lat, lon, alt)
                error('Latitude, Longitude, Altitude, and Time must be same length')
            end

            %% Set position and timestamps
            satellite = setPosition(satellite, ...
                Latitude = lat, Longitude = lon, Altitude = alt, Name = satellite.name);

            if isempty(t.TimeZone)
                t.TimeZone = 'UTC';
            end

            satellite.times = t;
            satellite.tle_uncertainty = options.TLE_Uncertainty;

            %% Assign telescope and wavelength
            satellite.telescope = telescope;

            if ~isempty(options.Source)
                satellite.source = options.Source;
                satellite.telescope = setWavelength(telescope, options.Source.wavelength);

            elseif ~isempty(options.Detector)
                satellite.detector = options.Detector;
                satellite.telescope = setWavelength(telescope, options.Detector.wavelength);

            else
                warning('Must provide either a source or detector')
            end

            %% Assign beacon and camera
            satellite.beacon = options.Beacon;
            satellite.camera = options.Camera;

            %% Reassign detector if needed
            satellite.detector = options.Detector;
        end

        function [satellite, lat, lon, alt, t] = readOrbitLLATFile( ...
                satellite, orbit_data_file_location)
            % readOrbitLLATFile
            %
            % Reads a .txt file containing satellite orbit data in LLAT format.
            %
            % Syntax:
            % [satellite, lat, lon, alt, t] = satellite.readOrbitLLATFile(file_path)
            %
            % Inputs:
            % orbit_data_file_location - (1,1) string, path to LLAT file
            %
            % Outputs:
            % lat - (1,N) double, latitude in degrees
            % lon - (1,N) double, longitude in degrees
            % alt - (1,N) double, altitude in meters
            % t   - (1,N) datetime, timestamps

            if nargin < 2
                error('readOrbitLLATFile requires a satellite and file path')
            end

            if ~exist(orbit_data_file_location, 'file')
                error('Cannot find orbit data file at specified location')
            end

            [folder_path,~,~] = fileparts(which(orbit_data_file_location));
            addpath(folder_path)
            satellite.orbit_file_data_location = orbit_data_file_location;

            file_id = fopen(orbit_data_file_location);
            llat_data = fscanf(file_id, '%f, %f, %f, %f', [4, inf]);
            fclose(file_id);

            lat = llat_data(1, :);
            lon = llat_data(2, :);
            alt = llat_data(3, :) * 1000;
            t = datetime(llat_data(4, :), ...
                'ConvertFrom', 'epochtime', ...
                'Epoch', datetime(2023, 1, 1, 0, 0, 0));
        end


        function [Satellite, lat, lon, alt, t] = ...
                llatFromScenario(Satellite, options)
            % llatFromScenario
            %
            % Extracts position and time from a satellite scenario.
            %
            % Syntax:
            % [satellite, lat, lon, alt, t] = ...
            %     satellite.llatFromScenario(options)
            %
            % Inputs:
            % options - struct with fields:
            %   .satCommsSatellite, .scenario, .TLE, .KeplerElements
            %
            % Outputs:
            % lat, lon, alt - (1,N) double, geographic coordinates
            % t             - (1,N) datetime, timestamps
            % v_e, v_n, v_u - (1,N) double, ENU velocity components

            arguments
                Satellite
                options.satCommsSatellite = nan
                options.scenario = nan
                options.TLE = nan
                options.KeplerElements = nan
            end

            if ~isempty(options.scenario) && isnan(options.TLE) && ...
                    isempty(options.KeplerElements)
                [position, velocity, t] = states(options.satCommsSatellite, ...
                    'CoordinateFrame', 'geographic');
                Satellite.name = options.satCommsSatellite.Name;

            elseif ~isempty(options.scenario) && ~isnan(options.TLE)
                sc_sat = satellite(options.scenario, options.TLE, ...
                    "Name", Satellite.name, ...
                    "OrbitPropagator", "two-body-keplerian");

                [position, velocity, t] = states(sc_sat, 'CoordinateFrame', 'geographic');
                Satellite.name = sc_sat.satellite(1).Name;

            elseif ~isempty(options.scenario) && ~isempty(options.KeplerElements)
                ke = options.KeplerElements;
                sc_sat = satellite(options.scenario, ke(1), ke(2), ke(3), ...
                    ke(4), ke(5), ke(6), ...
                    "Name", Satellite.name, ...
                    "OrbitPropagator", "two-body-keplerian");

                [position, velocity, t] = states(sc_sat, 'CoordinateFrame', 'geographic');
                Satellite.name = sc_sat.Name;
            end

            lat = position(1, :);
            lon = position(2, :);
            alt = position(3, :);
        end


        function satellite = setWavelength(satellite, wavelength)
            % setWavelength
            %
            % Sets the wavelength for both source and telescope.
            %
            % Syntax:
            % satellite = satellite.setWavelength(wavelength)

            satellite.source = SetWavelength(satellite.Source, wavelength);
            satellite.telescope = SetWavelength(satellite.telescope, wavelength);
        end


        function satellite = setSource(satellite, source)
            % setSource
            %
            % Assigns a source and updates wavelength accordingly.
            %
            % Syntax:
            % satellite = satellite.setSource(source)

            satellite.source = source;
            satellite = satellite.setWavelength(source.Wavelength);
        end


        function distances = computeDistancesTo(satellite, lla)
            % computeDistancesTo
            %
            % Computes ENU distances from satellite to a fixed LLA.
            %
            % Syntax:
            % distances = satellite.computeDistancesTo(lla)

            lla_sat = [satellite.latitudes', ...
                satellite.longitudes', ...
                satellite.altitudes'];

            enu = lla2enu(lla_sat, lla, "ellipsoid");
            distances = utilities.Row2Norms(enu);
        end

        function orbit_details = getOrbitDetails(satellite)
            % getOrbitDetails
            %
            % Returns orbit details for constructing a MATLAB satellite object.
            %
            % Syntax:
            % orbit_details = satellite.getOrbitDetails()

            orbit_details = timetable(satellite.times', ...
                [satellite.latitude, satellite.longitude, satellite.altitude]);

            orbit_details = {orbit_details, ...
                'CoordinateFrame', 'geographic', ...
                'Name', satellite.name};
        end


        function [scenario, sim_sat] = addSimulatorSatellite(satellite, scenario)
            % addSimulatorSatellite
            %
            % Adds a MATLAB simulator representation of this satellite.
            %
            % Syntax:
            % [scenario, sim_sat] = satellite.addSimulatorSatellite(scenario)

            sat_details = satellite.getOrbitDetails();
            sim_sat = satellite(scenario, sat_details{:});
            sim_sat.LabelFontSize = 25;
            sim_sat.MarkerSize = 12;
        end
    end
end