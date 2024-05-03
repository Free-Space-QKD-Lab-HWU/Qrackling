%Author: Cameron Simmons, Peter Barrow
%Date: 24/1/22

classdef Ground_Station < nodes.Located_Object & nodes.QKD_Receiver & nodes.QKD_Transmitter
    % GROUND_STATION an object containing all of the simulation parameters of the ground station

    properties (Abstract = false, SetAccess = protected)

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

        Latitude (1,1) {mustBeNumeric}
        Longitude (1,1) {mustBeNumeric}
        Altitude (1,1) {mustBeNumeric}
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

        % SMARTS wavelengths
        Wavelengths = [];

    end

    methods
        function [Ground_Station] = Ground_Station(Telescope, options)
            % GROUND_STATION instantiate a ground station using either its
            % component classes and requiring a name and location (LLA = lat
            % lon alt)
            arguments
                Telescope (1,1) components.Telescope
                options.Source (1,1) components.Source
                options.Detector (1,1) components.Detector
                options.Beacon (1,1) beacon.Beacon
                options.Camera (1,1) beacon.Camera
                options.Latitude (1,1) {mustBeNumeric} = nan
                options.Longitude (1,1) {mustBeNumeric} = nan;
                options.Altitude (1,1) {mustBeNumeric} = nan;
                options.LLA (1,3) {mustBeNumeric} = nan(1,3);
                options.Name {mustBeTextScalar};
            end


            Ground_Station.Telescope = Telescope;

            %infer correct wavelength from source or detector
            if ismember('Source',fieldnames(options))
                %if source is present, use this
                Ground_Station.Source = options.Source;
                Ground_Station.Telescope = SetWavelength(Ground_Station.Telescope, ...
                    Ground_Station.Source.Wavelength);

                assert(~ismember('Detector',fieldnames(options)),...
                    'Currently, only a Ground_Station object may only have a detector OR a source');

            elseif ismember('Detector',fieldnames(options))
                %if detector is present, use this
                Ground_Station.Detector = options.Detector;
                Ground_Station.Telescope = SetWavelength(Ground_Station.Telescope, ...
                    Ground_Station.Detector.Wavelength);
            else
                error('must provide either a source or detector')
            end

            % set camera and beacon
            if ismember('Camera',fieldnames(options))
            Ground_Station.Camera = options.Camera;
            end
            if ismember('Beacon',fieldnames(options))
            Ground_Station.Beacon = options.Beacon;
            end

            %% multiple ways to provide position, either as a single LLA variable or as Latitude, Longitude, Altitude 
            if ismember('LLA',fieldnames(options))
                Ground_Station.Latitude = options.LLA(1);
                Ground_Station.Longitude = options.LLA(2);
                Ground_Station.Altitude = options.LLA(3);
            elseif ismember('Latitude',fieldnames(options))&&...
                ismember('Longitude',fieldnames(options))&&...
                ismember('Altitude',fieldnames(options))

                Ground_Station.Latitude = options.Latitude;
                Ground_Station.Longitude = options.Longitude;
                Ground_Station.Altitude = options.Altitude;

            else
                error('must provide ground station position, either as single 1x3 LLA variable or as separate Latitude, Longitude and Altitude')
            end
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

        function [Satellite_Scenario,Ground_Station] = AddSimulatorOGS(Ground_Station,Satellite_Scenario)
            %%ADDSIMULATOROGS add a MATLAB satellite simulator
            %%representation of the current OGS to the satellite scenario

            %include OGS
            Sim_OGS = groundStation(Satellite_Scenario,...
                                    Ground_Station.Latitude,...
                                    Ground_Station.Longitude,...
                                    "Altitude",Ground_Station.Altitude,...
                                    "Name",Ground_Station.Name,...
                                    "MinElevationAngle",Ground_Station.Elevation_Limit);

            %include telescope
            conicalSensor(Sim_OGS,"MaxViewAngle",rad2deg(Ground_Station.Telescope.FOV))

            %modify labelling
            Sim_OGS.LabelFontSize = 25;
            Sim_OGS.MarkerSize = 12;

            Ground_Station.ToolboxObj = Sim_OGS;
            Ground_Station.HasToolboxObj = true;
        end
    end
end
