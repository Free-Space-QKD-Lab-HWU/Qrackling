%Author: Cameron Simmons, Peter Barrow
%Date: 24/1/22

classdef Ground_Station < nodes.Located_Object & nodes.QKD_Receiver & nodes.QKD_Transmitter & nodes.Free_Space_Optical_Node
    % GROUND_STATION an object containing all of the simulation parameters of the ground station

    properties (Abstract = false, SetAccess = public)

        % is is possible to replace this with a hash or index to get the object
        % from the toolbox scenario? Maybe the name is enough?
        toolbox_ground_station

        %the camera which receives beacon light, if beaconing is simulated
        Camera = [];

        %uplink beacon, if simulated
        Beacon = [];

       % enviroment object describing atmospheric loss and background
        % light
        Environment (1,1) environment.Environment = environment.Environment.Load("Examples\Data\atmospheric transmittance\Dark Environment 50km.mat");


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
    end

    methods
        function [Ground_Station, varargout] = Ground_Station(Telescope, options)
            % GROUND_STATION instantiate a ground station using either its
            % component classes and requiring a name and location (LLA = lat
            % lon alt)

            % Ground_Station should support an empty constructor to be default
            % instantiated correctly

            arguments
                Telescope (1,1) components.Telescope
                options.Detector = [];
                options.Camera = []
                options.Beacon = [];
                options.Source = [];
                options.scenario = nan;
                options.useSatCommsToolbox logical = false;
                options.startTime datetime = NaT
                options.stopTime datetime = NaT
                options.sampleTime = [];
                options.latitude (1,1) double = nan;
                options.longitude (1,1) double = nan;
                options.altitude (1,1) double = 0;
                options.LLA = nan;
                options.Name = 'Unnamed OGS';
                options.Environment =  environment.Environment.Load("Examples\Data\atmospheric transmittance\Dark Environment 50km.mat")
            end

            if nargin==0
                return
            end

            % telescope is a required input
            Ground_Station.Telescope = Telescope;

            %infer correct wavelength from source or detector
            if ~isempty(options.Source)
                %if source is present, use this
                Ground_Station.Source = options.Source;
                Ground_Station.Telescope = SetWavelength(Ground_Station.Telescope, ...
                    Ground_Station.Source.Wavelength);

                assert(isempty(options.Detector),...
                    'Currently, only a Ground_Station object may only have a detector OR a source');

            elseif ~isempty(options.Detector)
                %if detector is present, use this
                Ground_Station.Detector = options.Detector;
                Ground_Station.Telescope = SetWavelength(Ground_Station.Telescope, ...
                    Ground_Station.Detector.Wavelength);
            else
                error('must provide either a source or detector')
            end

            wvl_s = 0;
            if ~isempty(options.Source)
                wvl_s = options.Source.Wavelength;
            end

            wvl_d = 0;
            if ~isempty(options.Detector)
                wvl_d = options.Detector.Wavelength;
            end

            wvl_opts = [wvl_s, wvl_d];
            for i = 1:numel(wvl_opts)
                if wvl_opts(i) ~= 0
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

            % set camera and beacon
            Ground_Station.Camera = options.Camera;
            Ground_Station.Beacon = options.Beacon;

            %parse location (lat, lon, alt)
            if isnan(options.LLA)
                LLA = [options.latitude, options.longitude, options.altitude];
            else
                LLA = options.LLA;
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
                'LLA', options.LLA, ...
                'Name', options.Name);

            if (options.useSatCommsToolbox == true) & (~isobject(options.scenario))
                Ground_Station.useSatCommsToolbox = true;
                scenario = utilities.satelliteScenarioWrapper(options.startTime, ...
                    options.stopTime, ...
                    'sampleTime', ...
                    options.sampleTime);
                varargout{1} = scenario;
            end

            if isobject(options.scenario)
                Ground_Station.useSatCommsToolbox = true;
                scenario = options.scenario;
            end

            if Ground_Station.useSatCommsToolbox == true
                Ground_Station.toolbox_groundStation = ...
                    groundStation( scenario, ...
                    lat, ...
                    lon, ...
                    alt, ...
                    'Name', ...
                    options.Name );
            end


            %set name
            Ground_Station.Name = options.Name;

            %set environment object
            Ground_Station.Environment = options.Environment;
        end

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
