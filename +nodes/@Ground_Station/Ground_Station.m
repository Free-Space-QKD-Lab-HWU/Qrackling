%Author: Cameron Simmons, Peter Barrow
%Date: 24/1/22

classdef Ground_Station < nodes.Located_Object & nodes.QKD_Receiver & nodes.QKD_Transmitter
    % GROUND_STATION an object containing all of the simulation parameters of the ground station

    properties (Abstract = false, SetAccess = protected)

        % is is possible to replace this with a hash or index to get the object
        % from the toolbox scenario? Maybe the name is enough?
        toolbox_ground_station

        % path to a file containing the background count rate data for this
        % ground station (stored in counts/ s steradian nm)
        Background_Count_Rate_File_Location{mustBeText} = 'none';

        % path to a Sky_Brightness_Store object which unifies the background
        % light data interface between sources
        Sky_Brightness_Store_Location{mustBeText} = 'none';

        %the camera which receives beacon light, if beaconing is simulated
        Camera = [];

        %uplink beacon, if simulated
        Beacon = [];

        %atmosphere file location
        Atmosphere_File_Location = [];

        Name = '';
    end

    properties (Abstract = false, SetAccess = protected)
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
        function [Ground_Station, varargout] = Ground_Station(Telescope, varargin)
            % GROUND_STATION instantiate a ground station using either its
            % component classes and requiring a name and location (LLA = lat
            % lon alt)

            % Ground_Station should support an empty constructor to be default
            % instantiated correctly

            if nargin==0
                return
            end

            %% construct from inputs
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
            addParameter(p, 'Beacon', []);
            addParameter(p, 'Source', []);
            addParameter(p, 'Atmosphere_File_Location',[]);
            addParameter(p, 'Sky_Brightness_Store_Location','none');
            addParameter(p, 'Sky_Brightness_Store',[]);

            parse(p, Telescope, varargin{:});

            % telescope is a required input
            Ground_Station.Telescope = p.Results.Telescope;

            %infer correct wavelength from source or detector
            if ~isempty(p.Results.Source)
                %if source is present, use this
                Ground_Station.Source = p.Results.Source;
                Ground_Station.Telescope = SetWavelength(Ground_Station.Telescope, ...
                    Ground_Station.Source.Wavelength);

                assert(isempty(p.Results.Detector),...
                    'Currently, only a Ground_Station object may only have a detector OR a source');

            elseif ~isempty(p.Results.Detector)
                %if detector is present, use this
                Ground_Station.Detector = p.Results.Detector;
                Ground_Station.Telescope = SetWavelength(Ground_Station.Telescope, ...
                    Ground_Station.Detector.Wavelength);
            else
                error('must provide either a source or detector')
            end

            wvl_s = 0;
            if ~isempty(p.Results.Source)
                wvl_s = p.Results.Source.Wavelength;
            end

            wvl_d = 0;
            if ~isempty(p.Results.Detector)
                wvl_d = p.Results.Detector.Wavelength;
            end

            wvl_opts = [wvl_s, wvl_d];
            for i = 1:numel(wvl_opts)
                if wvl_opts(i) ~= 0;
                    break
                end
            end

            wvl = wvl_opts(i);

            if isnan(Ground_Station.Telescope.FOV)
                if isnan(Ground_Station.Telescope.Wavelength)
                    Ground_Station.Telescope = Ground_Station.Telescope.SetWavelength(wvl);
                end
                Ground_Station.Telescope = Ground_Station.Telescope.SetFOV();
            end

            % set Background count rate data
            % Ground_Station = ReadBackgroundCountRateData(Ground_Station, ...
            %     p.Results.Background_Count_Rate_File_Location);

            % set camera and beacon
            Ground_Station.Camera = p.Results.Camera;
            Ground_Station.Beacon = p.Results.Beacon;

            %parse location (lat, lon, alt)
            if isnan(p.Results.LLA)
                LLA = [p.Results.latitude, p.Results.longitude, p.Results.altitude];
            else
                LLA = p.Results.LLA;
            end

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
                scenario = utilities.satelliteScenarioWrapper(p.Results.startTime, ...
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
                Ground_Station.toolbox_groundStation = ...
                    groundStation( scenario, ...
                    lat, ...
                    lon, ...
                    alt, ...
                    'Name', ...
                    p.Results.name );
            end

            Ground_Station.Name = p.Results.name;


            %store atmosphere file location
            Ground_Station.Atmosphere_File_Location = p.Results.Atmosphere_File_Location;
            %store Sky_Brightness_Store location
            Ground_Station.Sky_Brightness_Store_Location = p.Results.Sky_Brightness_Store_Location;
        end

        % function [ogs, varargout] = Ground_Station( ...
        %     Latitude, Longitude, Altitude, Telescope, options)
        %     arguments
        %         Latitude {mustBeNumeric}
        %         Longitude {mustBeNumeric}
        %         Altitude {mustBeNumeric}
        %         Telescope components.Telescope
        %         options.Source components.Source = []
        %         options.Detector components.Detector = []
        %         options.Camera beacon.Camera = []
        %         options.Beacon beacon.Beacon = []
        %         options.satelliteScenario {isa(options.satelliteScenario, ['satelliteScenario', 'logical'])} = false
        %         options.useSatCommsToolbox = false
        %         options.name = Bob
        %     end

        %     result = [utilities.sameSize(Latitude, Longitude), ...
        %               utilities.sameSize(Latitude, Altitude)];
        %     if any(false == result)
        %         msg = [ ...
        %             'Latitude: { ', inputname(1), ' }, ', newline, ...
        %             'Longitude: { ', inputname(2), ' }, ', newline, ...
        %             'Altitude: { ', inputname(3), ' }, ', newline, ...
        %             ' do not have matching sizes. ', newline, ...
        %             'size(', inputname(1), ') = ', num2str(Latitude), ...
        %             'size(', inputname(2), ') = ', num2str(Longitude), ...
        %             'size(', inputname(3), ') = ', num2str(Altitude), ...
        %                ];
        %         error(msg);
        %     end

        %     ogs.Telescope = Telescope;

        %     ogs.Camera = options.Camera;
        %     ogs.Source = options.Source;
        %     ogs.Detector = options.Detector;
        %     ogs.Beacon = options.Beacon;

        %     scenario = [];
        %     switch class(options.satelliteScenario)
        %     case 'satelliteScenario'
        %         scenario = options.satelliteScenario;

        %     case 'logical'
        %         % we don't currently have a scenario and we want to make one
        %         msg = [newline, newline, ...
        %             '##############################', newline, ...
        %             'Making a new satelliteScenario. If you already have one ', ...
        %             'and wanted to use it, pass it in as an argument to ', ...
        %             'Ground_Station.', newline, ...
        %             'HINT: ogs = nodes.Ground_Station(latitude, longitude, ', ...
        %             'altitude, telescope, "satelliteScenario", MY_SCENARIO)', ...
        %             newline, ...
        %             '##############################', ...
        %             newline ...
        %         ];
        %         warning(msg)
        %         if true == options.satelliteScenario
        %             nargoutchk(2);
        %             scenario = satelliteScenario();
        %             varargout{1} = scenario;
        %         end
        %     end

        %     if ~isempty(scenario)
        %         %ogs.toolbox_ground_station = groundStation(scenario ...
        %         %    Latitude, Longitude, Altitude, Name=options.Name);
        %         ogs.toolbox_ground_station = groundStation(scenario, ...
        %             Latitude, Longitude, Altitude, 'Name', options.name);
        %     end

        %     ogs = ogs.SetPosition( ...
        %         "Latitude",  Latitude,  ...
        %         "Longitude", Longitude, ...
        %         "Altitude",  Altitude,  ...
        %         "Name",      options.name);

        % end


        function Ground_Station = SetWavelength(Ground_Station, Wavelength)
            % SETWAVELENGTH set the wavelength (in nm) of the receiver and
            % the detector it contains
            Ground_Station.Detector = SetWavelength(Ground_Station.Detector, Wavelength);
        end

        function Ground_Station = SetElevationLimit(Ground_Station, Elevation_Limit)
            % SETELEVATIONLIMIT set the minimum elevation over which
            % communication can occur
            Ground_Station.Elevation_Limit = Elevation_Limit;
        end

        % TODO: MOVE 
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
            ArcDistance = utilities.ComputeLOSWindow(Satellite_Altitude, Ground_Station.Elevation_Limit);
            for Heading = Headings
                % NOTE: this is the only call site for MoveAlongSurface
                [CurrentWindowLat, CurrentWindowLon] = utilities.MoveAlongSurface(Ground_Station.Latitude, Ground_Station.Longitude, ArcDistance, Heading);
                WindowLat(Heading) = CurrentWindowLat;
                WindowLon(Heading) = CurrentWindowLon;
            end
            geoplot(WindowLat, WindowLon, 'k--')
            leg = legend;
            leg.String{end + 1} = "Ground Station";
            leg.String{end} = "Ground Station orbit LOS";
        end

        function OGSDetails = GetOGSDetails(Ground_Station)
            %% return the details of a ground station necessary to make a MATLAB simulator object
            %returned as a cell array, use OGSDetails{:} to give to function

            OGSDetails = {'Latitude',Ground_Station.Latitude,...
                'Longitude',Ground_Station.Longitude,...
                'Altitude',Ground_Station.Altitude,...
                'MinElevationAngle',Ground_Station.Elevation_Limit,...
                'Name',Ground_Station.Location_Name};
        end

        function [Satellite_Scenario,Sim_OGS] = AddSimulatorOGS(Ground_Station,Satellite_Scenario)
            %%ADDSIMULATOROGS add a MATLAB satellite simulator
            %%representation of the current OGS to the satellite scenario

           %% get details of OGS
            OGSDetails = GetOGSDetails(Ground_Station);
            %include OGS
            Sim_OGS = groundStation(Satellite_Scenario, OGSDetails{:});
            %modify labelling
            Sim_OGS.LabelFontSize = 25;
            Sim_OGS.MarkerSize = 12;
        end
    end
end
