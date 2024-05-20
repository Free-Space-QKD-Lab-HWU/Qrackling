%Author: Cameron Simmons, Peter Barrow
%Date: 24/1/22

classdef Satellite < nodes.Located_Object & nodes.QKD_Receiver & nodes.QKD_Transmitter
    %SATELLITE abstract class containing the satellite properties for simulation

    %hide large or uninteresting properties, not abstract for this reason
    properties (SetAccess=protected, Hidden=true)

        % Kind {mustBeA(Kind, "nodes.Optical_Node")}

        N_Steps{mustBeScalarOrEmpty, mustBePositive}

    end

    %do not hide small properties
    properties (SetAccess=protected, Hidden=false)

        %% beacon on satellite
        Beacon =[];
        %% beacon camera on satellite
        Camera = [];



        Kepler_Elements (1,6) {mustBeNumeric} = nan(1,6);    %the kepler elements of a satellite are:
        %Semimajor axis (m)
        %eccentricity (0-1)
        %inclination (deg)
        %right argument of the ascending node
        %argument of periapsis
        %true anomaly

        LLAT (:,1) struct = struct('LLA',[],'Time',duration.empty());
        %LLAT contains latitude, longitude, altitude and time data for an
        %orbit

        OrbitDataSource {mustBeMember(OrbitDataSource,...
            {'Kepler Elements','LLAT','none'})} = 'none'

        TLE_File
    end

    methods
        % FIX: Input validation here is a mess, clean up
        % TODO: Arguments block
        % TODO: Simplify kepler elements arguments
        % TODO: Replace 'LLAT', 'TLE', and kepler elements with a {mustbemember}
        % TODO: Why is there still 'ToolBoxSatellite', 'scenario' and 'useSatCommsToolbox' ?
        function [Satellite] = Satellite(Telescope, options)

            % SATELLITE Construct an instance of satellite using an orbital
            % User must provide either an 'OrbitDataFileLocation' file, TLE
            % information or KeplerElements, if more than once of these is
            % provided the precedence listed here is applied. I.e. if both
            % 'OrbitDataFileLocation' and KeplerElements are supplied the
            % 'OrbitDataFileLocation' will be used.
            % If TLE information or KeplerElements are supplied then a startTime,
            %     stopTime and sampleTime must also be supplied.

            arguments
                Telescope (1,1) components.Telescope
                options.Source (1,1) components.Source
                options.Detector (1,1) components.Detector
                options.Beacon (1,1) beacon.Beacon
                options.Camera (1,1) beacon.Camera
                options.KeplerElements (1,6) {mustBeNumeric} = nan(1,6);
                % options.OrbitDataFileLocation {mustBeFile}
                options.LLAT (:,4) {mustBeNumeric}
                options.TLE_File {mustBeFile}
                options.Name {mustBeTextScalar};
                options.SatCommsToolboxSatellite (1, 1) matlabshared.satellitescenario.Satellite
            end

            Satellite.Telescope = Telescope;

            %% many different ways of providing orbital data

            %first, let's check if there are kepler elements available
            if ~all(isnan(options.KeplerElements))
                %if all elements are provided individually, use these
                Satellite.Kepler_Elements = options.Kepler_Elements;
                Satellite.OrbitDataSource = 'Kepler Elements';

            % elseif ismember('OrbitDataFileLocation',fieldnames(options))
            %     [lat, lon, alt, t] = Satellite.ReadOrbitLLATFile(options.OrbitDataFileLocation);
            %     Satellite.LLAT.LLA = [lat',lon',alt'];
            %     Satellite.LLAT.Time = t';
            %     Satellite.OrbitDataSource = 'LLAT';

            elseif ismember('LLAT',fieldnames(options))
                %if LLAT (latitude, longitude, altitude, time) is provided manually, use this
                Satellite.LLAT = options.LLAT;
                Satellite.OrbitDataSource = 'LLAT';

            elseif ismember('TLE_File',fieldnames(options))
                Satellite.TLE_File = options.TLE_File;
                Satellite.OrbitDataSource = 'TLE File';
            end

            %% currently, both transmit and receive scopes are the same
            Satellite.Telescope = Telescope;

            %infer correct wavelength from source or detector
            if ismember('Source',fieldnames(options))
                Satellite.Source = options.Source;
                Satellite.Telescope = SetWavelength(Satellite.Telescope, ...
                    Satellite.Source.Wavelength);
            elseif ismember('Detector',fieldnames(options))
                Satellite.Detector = options.Detector;
                Satellite.Telescope = SetWavelength(Satellite.Telescope, ...
                    Satellite.Detector.Wavelength);
            else
                warning('must provide either a source or detector')
            end


            %store name
            if ismember('Name',fieldnames(options))
                Satellite.Name = options.Name;
            end


            %% set beacon and beaconing camera
            if ismember('Beacon',fieldnames(options))
                Satellite.Beacon = options.Beacon;
            end
            if ismember('Camera',fieldnames(options))
                Satellite.Camera = options.Camera;
            end
        end


        function [Satellite, lat, lon, alt, t, vE, vN, vU] = ...
                llatAndVelFromScenario(Satellite, varargin)
            p = inputParser();
            addRequired(p, 'Satellite');
            addParameter(p, 'satCommsSatellite', nan);
            addParameter(p, 'scenario', []);
            addParameter(p, 'TLE', nan);
            addParameter(p, 'KeplerElements', []);

            parse(p, Satellite, varargin{:});

            % the below coul have been in a switch statement but this would
            % have been more indententation than is wanted

            % Conditionally get the position, velocity and time for a satellite
            % described by the input arguments. The 'states' function from the
            % satellite communications toolbox can be supplied with a relevent
            % 'CoordinateFrame' argument to set the format of the return values.
            % Here they have been set to 'geographic' giving a result in terms
            % of {latitiude, longitude, altitude}, velocities in a 'North-East-
            % Down' format and time in matlab datetime

            if ~isempty(p.Results.scenario) && isnan(p.Results.TLE) ...
                    && isempty(p.Results.KeplerElements)

                % First case: we have been supplied with only a satCommsToolbox
                % satellite object, get its position, velocity and time

                [position, velocity, t] = states(p.Results.satCommsSatellite, ...
                    'CoordinateFrame', 'geographic');
                Satellite.Name = p.Results.satCommsSatellite.Name;

            elseif ~any([isempty(p.Results.scenario), isnan(p.Results.TLE)])

                % Second case: we have been supplied with a satCommsToolbox
                % scenario along with some TLE data. So, use the scenario and
                % the TLE data to construct a satellite and get its position,
                % velocity and time steps

                sc_sat = satellite(p.Results.scenario, p.Results.TLE, ...
                    "Name", Satellite.Name, ...
                    "OrbitPropagator", "two-body-keplerian");

                [position, velocity, t] = states(...
                    sc_sat, 'CoordinateFrame', 'geographic');
                Satellite.Name = sc_sat.satellite(1).Name;

            elseif ~isempty(p.Results.scenario) ...
                    && ~isempty(p.Results.KeplerElements)

                % Third case: same as above except we have received an array of
                % kepler elements rather than TLE data

                % [sma, ecc, inc, raan, aop, ta] = ...
                %         utilities.splat(p.Results.KeplerElements);

                sma = p.Results.KeplerElements(1);
                ecc = p.Results.KeplerElements(2);
                inc = p.Results.KeplerElements(3);
                raan = p.Results.KeplerElements(4);
                aop = p.Results.KeplerElements(5);
                ta = p.Results.KeplerElements(6);

                sc_sat = satellite(p.Results.scenario, sma, ecc, inc, ...
                    raan, aop, ta, "Name", Satellite.Name, ...
                    "OrbitPropagator", "two-body-keplerian");

                [position, velocity, t] = states(...
                    sc_sat, 'CoordinateFrame', 'geographic');
                Satellite.Name = sc_sat.Name;
            end

            % Next break out the position matrix into an array each for:
            %   - {latitiude, longitude, altitude}
            lat = position(1, :);
            lon = position(2, :);
            alt = position(3, :);

            % Since we work in the East-North-Up coordinate frame we need to
            % change the format of the velocities from NED to ENU.
            % See 'basic classes/utilities.m for details.
            velocity_enu = utilities.ned2enu(velocity);
            vE = velocity_enu(1, :);
            vN = velocity_enu(2, :);
            vU = velocity_enu(3, :);
        end


        function Satellite = SetWavelength(Satellite, Wavelength)
            %%SETWAVELENGTH set the wavelength property of the internal
            %%transmitter
            Satellite.Source = SetWavelength(Satellite.Source, Wavelength);
            Satellite.Telescope = SetWavelength(Satellite.Telescope, ...
                Wavelength);
        end


        function Satellite = SetSource(Satellite, Source)
            Satellite.Source = Source;
            Satellite = Satellite.SetWavelength(Source.Wavelength);
        end


        function Distances = ComputeDistancesTo(Satellite, LLA)
            %%COMPUTEDISTANCESTO return the distances to a fixed LLA over a
            %%satellite pass
            %% convert from LLA of satellite to ENU relative to ground station
            LLA_satellite = [Satellite.Latitudes', ...
                Satellite.Longitudes', ...
                Satellite.Altitudes'];

            ENU = lla2enu(LLA_satellite, LLA, "ellipsoid");
            Distances = utilities.Row2Norms(ENU);
        end


        function Satellite = SetFrontalArea(Satellite, Area)
            %%SETFRONTALAREA set the frontal area property
            Satellite.Surface = SetArea(Satellite.Surface, Area);
        end


        function Satellite = SetReflectivity(Satellite, reflectivity)
            %%SETFRONTALAREA set the frontal area property
            Satellite.Reflectivity = reflectivity;
            warning('this behaviour is legacy and may no longer be support. Instead access the "Surface" class of the satellite')
        end

        function [Satellite_Scenario,Satellite] = AddSimulatorSatellite(Satellite,Satellite_Scenario)
            %%ADDSIMULATORSATELLITE add a MATLAB simulator representation of this satellite to
            %%the existing satelliteScenario

            %% get details of satellite
            switch Satellite.OrbitDataSource
                case 'Kepler Elements'
                    Sim_Sat = satellite(Satellite_Scenario,...
                        Satellite.Kepler_Elements(1),...
                        Satellite.Kepler_Elements(2),...
                        Satellite.Kepler_Elements(3),...
                        Satellite.Kepler_Elements(4),...
                        Satellite.Kepler_Elements(5),...
                        Satellite.Kepler_Elements(6),...
                        "Name",Satellite.Name);

                case 'LLAT'
                    PositionTable = timetable(Satellite.LLAT.Time,Satellite.LLAT.LLA);
                    Sim_Sat = satellite(Satellite_Scenario, PositionTable,"Name",Satellite.Name,"CoordinateFrame","geographic");

                case 'TLE File'
                    Sim_Sat = satellite(Satellite_Scenario, Satellite.TLE_File,"Name",Satellite.Name);

                otherwise
                    error('Satellite has no orbit data. This can be provided as kepler elements, a TLE file or a file or array of latitude, longitude, altitude and time values')
            end

            %include telescope
            conicalSensor(Sim_Sat,"MaxViewAngle",rad2deg(Satellite.Telescope.FOV));

            %modify labelling
            Sim_Sat.LabelFontSize = 25;
            Sim_Sat.MarkerSize = 12;

            Satellite.ToolboxObj = Sim_Sat;
            Satellite.HasToolboxObj = true;
        end

        function times = Times(Satellite)
            %%TIMES returns the times in UTC datetime that simulation is
            %%being performed for

            [~,~,times]=states(Satellite.ToolboxObj);
        end
    end

    methods (Static)
        function [lat, lon, alt, t] = ReadOrbitLLATFile(Orbit_Data_File_Location)
            %ReadOrbitLLATFile Read in the given (or internally pointed to
            %if no file is given) orbit data file
            arguments
                Orbit_Data_File_Location {mustBeFile}
            end

            %% read orbit data file
            %% open the file and assign it an ID
            FileID=fopen(Orbit_Data_File_Location);

            %% read file as an arrray
            LLATData=fscanf(FileID, '%f, %f, %f, %f', [4, inf]);
            %% close the file
            fclose(FileID);

            %% store data
            % Separate rows into LLA and T
            lat = LLATData(1,:);
            lon = LLATData(2,:);
            alt = LLATData(3,:) * 1000; %conversion to m from km
            %time must now conform to being a datetime object
            t = seconds(LLATData(4,:));
        end

        function new_satellite = NewFromLLATFile(telescope, scenario, ...
            path_to_llat_file, Name, options)
            arguments
                telescope components.Telescope
                scenario satelliteScenario
                path_to_llat_file {mustBeFile}
                Name {mustBeTextScalar}
                options.Source components.Source
                options.Detector components.Detector
                options.Beacon beacon.Beacon
                options.Camera beacon.Camera
            end

            position_table = nodes.Satellite.ReadLLATFile(path_to_llat_file);
            sat = satellite(scenario, ...
                position_table, ...
                "CoordinateFrame", "geographic", ...
                "Name", Name);

            args = {telescope, 'Name', Name, 'SatCommsToolboxSatellite', sat};
            for f = fieldnames(options)'
                args = {args, f{1}, options.(f{1})};
            end

            new_satellite = nodes.Satellite(args{:});
        end

        function new_satellite = NewFromTLEFile(telescope, scenario, ...
            path_to_tle_file, Name, options)
            arguments
                telescope components.Telescope
                scenario satelliteScenario
                path_to_tle_file {mustBeFile}
                Name {mustBeTextScalar}
                options.Source components.Source
                options.Detector components.Detector
                options.Beacon beacon.Beacon
                options.Camera beacon.Camera
            end

            sat = satellite(scenario, path_to_tle_file, "Name", Name);

            args = {telescope, 'Name', Name, 'SatCommsToolboxSatellite', sat};
            for f = fieldnames(options)'
                args = {args, f{1}, options.(f{1})};
            end

            new_satellite = nodes.Satellite(args{:});
        end
    end
end
