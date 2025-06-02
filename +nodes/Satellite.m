%Author: Cameron Simmons, Peter Barrow
%Date: 24/1/22

classdef Satellite < nodes.Located_Object & nodes.QKD_Receiver & nodes.QKD_Transmitter & nodes.Free_Space_Optical_Node
    %SATELLITE abstract class containing the satellite properties for simulation

    %hide large or uninteresting properties, not abstract for this reason
    properties (SetAccess=protected, Hidden=true)

        % Kind {mustBeA(Kind, "nodes.Optical_Node")}

        N_Steps{mustBeScalarOrEmpty, mustBePositive}

        % If using TLE or KeplerElements to define satellite path we will
        % store the satelliteScenario object as well as the corresponding
        % satellite object
        satellite_scenario;
        sc_sat;
        Kepler_Elements;    %the kepler elements of a satellite are:
        %Semimajor axis (m)
        %eccentricity (0-1)
        %inclination (deg)
        %right argument of the ascending node
        %argument of periapsis
        %true anomaly

        TLE_Uncertainty {mustBeScalarOrEmpty,mustBeNonnegative} = 5E3;  %uncertainty in satellite orbital position (in lat and long) in m
    end

    %do not hide small properties
    properties (SetAccess=protected, Hidden=false)
        %File location for Latitude, Longitude, Altitude and Time data
        Orbit_Data_File_Location{mustBeText} = '';

        Times {mustBeA(Times,'datetime')} = datetime.empty  %not sure what this would need to be for datetimes

        %% beacon on satellite
        Beacon =[];
        %% beacon camera on satellite
        Camera = [];
    end

    methods
        % FIX: Input validation here is a mess, clean up
        % TODO: Arguments block
        % TODO: Simplify kepler elements arguments
        % TODO: Replace 'LLAT', 'TLE', and kepler elements with a {mustbemember}
        % TODO: Why is there still 'ToolBoxSatellite', 'scenario' and 'useSatCommsToolbox' ?
        function [Satellite, varargout] = Satellite(Telescope, options)

            % SATELLITE Construct an instance of satellite using an orbital
            % User must provide either an 'OrbitDataFileLocation' file, TLE
            % information or KeplerElements, if more than once of these is
            % provided the precedence listed here is applied. I.e. if both
            % 'OrbitDataFileLocation' and KeplerElements are supplied the
            % 'OrbitDataFileLocation' will be used.
            % If TLE information or KeplerElements are supplied then a startTime,
            %     stopTime and sampleTime must also be supplied.

            arguments
                Telescope components.Telescope
                options.Source = [];
                options.Detector = [];
                options.Beacon =[]
                options.Camera = []

                options.OrbitDataFileLocation = '';
                options.ToolBoxSatellite = [];
                options.scenario = nan;
                options.UseSatCommsToolbox (1,1) logical = false;
                options.LLAT {mustBeNumeric} = [];
                options.TLE = [];
                options.KeplerElements = [];
                options.semiMajorAxis = nan;
                options.eccentricity = nan;
                options.inclination = nan;
                options.rightAscensionOfAscendingNode = nan;
                options.argumentOfPeriapsis = nan;
                options.trueAnomaly = nan;
                options.startTime datetime = NaT;
                options.stopTime datetime = NaT;
                options.sampleTime = NaT
                options.Name = 'Unnamed Satellite';
                options.TLE_Uncertainty (1,1) {mustBeNonnegative} = 5E3
            end


            %% satellite should support an empty constructor
            if nargin==0
                return
            end

            sma = options.semiMajorAxis;
            ecc = options.eccentricity;
            inc = options.inclination;
            raan = options.rightAscensionOfAscendingNode;
            aop = options.argumentOfPeriapsis;
            ta = options.trueAnomaly;

            hasVelocity = false;

            %store kepler elements
            if (~any(isnan(arrayfun(@isnan, [sma, ecc, inc, raan, aop, ta]))) ...
                    & isempty(options.KeplerElements))
                KeplerElements = [sma, ecc, inc, raan, aop, ta];
            else
                KeplerElements = options.KeplerElements;
            end
            Satellite.Kepler_Elements = KeplerElements;

            %store name
            if ~isempty(options.Name)
                Satellite.Name = options.Name;
            end

            if (0 > utilities.nan_present(options.OrbitDataFileLocation, ...
                    options.scenario, ...
                    options.ToolBoxSatellite, ...
                    options.TLE, ...
                    KeplerElements))
                error(['Input does not contain one of the following: [', ...
                    'OrbitDataFileLocation', 'TLE', 'KeplerElements', ']']);
            end

            if ~isempty(options.OrbitDataFileLocation)
                [Satellite, lat, lon, alt, t] = ReadOrbitLLATFile(Satellite,...
                    options.OrbitDataFileLocation);
            elseif ~isempty(options.LLAT)
                %if LLAT (latitude, longitude, altitude, time) is provided manually, use this
                LLAT = options.LLAT;
                lat = LLAT(:,1);
                lon = LLAT(:,2);
                alt = LLAT(:,3);
                time_seconds   = LLAT(:,4);
                %either refer time in seconds to startTime, or use default
                %startTime
                if ~isempty(options.startTime)
                    t = startTime + seconds(time_seconds);
                else
                    t= datetime(2000,1,1,12,0,0) + seconds(time_seconds);
                end

            elseif options.UseSatCommsToolbox == true
                if isempty(options.ToolBoxSatellite) | isempty(options.scenario)
                    error('No toolbox satellite supplied');

                else
                    [Satellite, lat, lon, alt, t, vE, vN, vU] = ...
                        llatAndVelFromScenario(Satellite, ...
                        satCommsSatellite=options.ToolBoxSatellite, ...
                        scenario=options.scenario);
                    hasVelocity = true;
                end

            else
                if isdatetime(options.startTime)
                    if isduration(options.sampleTime)
                        sampleTime = seconds(options.sampleTime);
                    else
                        sampleTime = options.sampleTime;
                    end
                    scenario = utilities.satelliteScenarioWrapper(options.startTime, ...
                                                        options.stopTime, ...
                                                        'sampleTime',sampleTime);
                else
                    scenario = options.scenario;

                end

                varargout{1} = scenario;
                if ~isempty(options.TLE)
                    [Satellite, lat, lon, alt, t, vE, vN, vU] = llatAndVelFromScenario(...
                        Satellite, 'scenario', scenario, 'TLE', TLE);
                    hasVelocity = true;

                elseif ~isempty(KeplerElements)
                    [~, cols] = size(KeplerElements);
                    if cols ~= 6
                        error(['Require all 6 Kepler Elements, in order:', ...
                          newline, char(9), 'semiMajorAxis', ...
                          newline, char(9), 'eccentricity', ...
                          newline, char(9), 'inclination', ...
                          newline, char(9), 'rightAscensionOfAscendingNode', ...
                          newline, char(9), 'argumentOfPeriapsis', ...
                          newline, char(9), 'trueAnomaly'])
                    end
                    [Satellite, lat, lon, alt, t, vE, vN, vU] = llatAndVelFromScenario(...
                        Satellite, 'scenario', scenario, 'KeplerElements', KeplerElements);
                    hasVelocity = true;
                end
            end

            %check data is compatible
            if ~utilities.AreSameDimensions(t, lat, lon, alt)
                error('Latitude, Longitude, Altitude and Time data must be of the same length')
            end
            %set N_Steps
            Satellite = SetPosition(Satellite, ...
                Latitude = lat, ...
                Longitude = lon, ...
                Altitude = alt, ...
                Name = Satellite.Name);

            if true == hasVelocity
                Satellite = SetVelocities(Satellite, vE, vN, vU);
            end

            Satellite.N_Steps = Satellite.N_Position;

            %enforce a time zone on times. if none is provided, assume UTC
            if isempty(t.TimeZone)
                t.TimeZone = 'UTC';
            end
            Satellite.Times = t;

            Satellite.TLE_Uncertainty = options.TLE_Uncertainty;

            %% currently, both transmit and receive scopes are the same
            Satellite.Telescope = Telescope;

            %infer correct wavelength from source or detector
            if ~isempty(options.Source)

            Satellite.Source = options.Source;
            Satellite.Telescope = SetWavelength(Satellite.Telescope, ...
                Satellite.Source.Wavelength);
            elseif ~isempty(options.Detector)
            Satellite.Detector = options.Detector;
            Satellite.Telescope = SetWavelength(Satellite.Telescope, ...
                Satellite.Detector.Wavelength);
            else
                %error('must provide either a source or detector')
                warning('must provide either a source or detector')
            end


            %% set beacon and beaconing camera
            Satellite.Beacon = options.Beacon;
            Satellite.Camera = options.Camera;

            %% add detector if wanted
            Satellite.Detector = options.Detector;
        end

        function [Satellite, lat, lon, alt, t] = ReadOrbitLLATFile(Satellite, ...
                Orbit_Data_File_Location)
            %ReadOrbitLLATFile Read in the given (or internally pointed to
            %if no file is given) orbit data file
            %% add orbit files to path

            % TODO: LocationofFile function is deprecated with module structure
            addpath(utilities.LocationofFile(Orbit_Data_File_Location));

            if nargin < 2
                error('ReadOrbitLLATFile takes only a satellite object and .txt file location as arguments');
            end

            %if a file is provided, use this file location
            if ~(exist(Orbit_Data_File_Location, 'file'))
                error('cannot find a text file of that name and location');
            end
            Satellite.Orbit_Data_File_Location=Orbit_Data_File_Location;

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
            t = datetime(LLATData(4,:),'ConvertFrom','epochtime','Epoch',datetime(2023,1,1,0,0,0));
        end

        function [Satellite, lat, lon, alt, t, vE, vN, vU] = ...
                            llatAndVelFromScenario(Satellite, options)
            
            arguments
                Satellite
                options.satCommsSatellite = nan;
                options.scenario = nan;
                options.TLE = nan;
                options.KeplerElements = nan;
            end

            % the below coul have been in a switch statement but this would 
            % have been more indententation than is wanted

            % Conditionally get the position, velocity and time for a satellite
            % described by the input arguments. The 'states' function from the 
            % satellite communications toolbox can be supplied with a relevent
            % 'CoordinateFrame' argument to set the format of the return values.
            % Here they have been set to 'geographic' giving a result in terms
            % of {latitiude, longitude, altitude}, velocities in a 'North-East-
            % Down' format and time in matlab datetime

            if ~isempty(options.scenario) && isnan(options.TLE) ...
                    && isempty(options.KeplerElements)

                % First case: we have been supplied with only a satCommsToolbox
                % satellite object, get its position, velocity and time 

                [position, velocity, t] = states(options.satCommsSatellite, ...
                                            'CoordinateFrame', 'geographic');
                Satellite.Name = options.satCommsSatellite.Name;

            elseif ~any([isempty(options.scenario), isnan(options.TLE)])

                % Second case: we have been supplied with a satCommsToolbox
                % scenario along with some TLE data. So, use the scenario and
                % the TLE data to construct a satellite and get its position, 
                % velocity and time steps

                sc_sat = satellite(options.scenario, options.TLE, ...
                                   "Name", Satellite.Name, ...
                                   "OrbitPropagator", "two-body-keplerian");

                [position, velocity, t] = states(...
                                    sc_sat, 'CoordinateFrame', 'geographic');
                Satellite.Name = sc_sat.satellite(1).Name;

            elseif ~isempty(options.scenario) ...
                   && ~isempty(options.KeplerElements)

                % Third case: same as above except we have received an array of
                % kepler elements rather than TLE data

                % [sma, ecc, inc, raan, aop, ta] = ...
                %         utilities.splat(options.KeplerElements);

                sma = options.KeplerElements(1);
                ecc = options.KeplerElements(2);
                inc = options.KeplerElements(3);
                raan = options.KeplerElements(4);
                aop = options.KeplerElements(5);
                ta = options.KeplerElements(6);

                sc_sat = satellite(options.scenario, sma, ecc, inc, ...
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


        function OrbitDetails = GetOrbitDetails(Satellite)
            %% return the orbit details sufficient to create a MATLAB satellite object
            %returned asa cell array of arguments (give to function using
            %OrbitDetails{:})
         
            OrbitDetails = timetable(Satellite.Times',[Satellite.Latitude,Satellite.Longitude,Satellite.Altitude]);
            OrbitDetails = {OrbitDetails,...
                            'CoordinateFrame','geographic',...
                            'Name',Satellite.Name};
        end
    

        function [Satellite_Scenario,Sim_Sat] = AddSimulatorSatellite(Satellite,Satellite_Scenario)
            %%ADDSIMULATORSATELLITE add a MATLAB simulator representation of this satellite to
            %%the existing satelliteScenario

            %% get details of satellite
            SatDetails = GetOrbitDetails(Satellite);
            %include satellite
            Sim_Sat = satellite(Satellite_Scenario, SatDetails{:});
            %modify labelling
            Sim_Sat.LabelFontSize = 25;
            Sim_Sat.MarkerSize = 12;
        end
    end
end
