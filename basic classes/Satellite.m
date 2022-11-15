%Author: Cameron Simmons, Peter Barrow
%Date: 24/1/22

classdef Satellite < Located_Object
    %SATELLITE abstract class containing the satellite properties for simulation

    %hide large or uninteresting properties, not abstract for this reason
    properties (SetAccess=protected, Hidden=true)
        N_Steps{mustBeScalarOrEmpty, mustBePositive}
        Times % {mustBeNumeric} not sure what this would need to be for datetimes

        % If using TLE or KeplerElements to define satellite path we will
        % store the satelliteScenario object as well as the corresponding
        % satellite object
        satellite_scenario;
        sc_sat;
    end

    %do not hide small properties
    properties (SetAccess=protected, Hidden=false)
        % If not set, initialised to UUID
        Name{mustBeText} = '';
        %File location for Latitude, Longitude, Altitude and Time data
        Orbit_Data_File_Location{mustBeText} = '';

        %object containing transmitter details
        Source Source = BB84_Source(1);
        Telescope Telescope

        %% information about protocol
        % protocol used (BB84,BBN92,...)
        Protocol{mustBeText} = '';
        Protocol_Efficiency{mustBeScalarOrEmpty} = 1;

        %% information about reflection
        % a surface object detailing angular and spectal dependence of
        % reflection
        Surface {isa(Surface,'Surface')}

        %% beacon on satellite
        Beacon =[];
    end

    methods
        function [Satellite, varargout] = Satellite(Source, Telescope, varargin)

            % SATELLITE Construct an instance of satellite using an orbital
            % User must provide either an 'OrbitDataFileLocation' file, TLE
            % information or KeplerElements, if more than once of these is
            % provided the precedence listed here is applied. I.e. if both
            % 'OrbitDataFileLocation' and KeplerElements are supplied the
            % 'OrbitDataFileLocation' will be used.
            % If TLE information or KeplerElements are supplied then a startTime,
            %     stopTime and sampleTime must also be supplied.

            p = inputParser();

            addRequired(p, 'Source');
            addRequired(p, 'Telescope')
            addParameter(p, 'OrbitDataFileLocation','');
            addParameter(p, 'ToolBoxSatellite', []);
            addParameter(p, 'scenario', nan);
            addParameter(p, 'useSatCommsToolbox', false);
            addParameter(p, 'TLE', []);
            addParameter(p, 'KeplerElements', []);
            addParameter(p, 'semiMajorAxis', nan)
            addParameter(p, 'eccentricity', nan);
            addParameter(p, 'inclination', nan);
            addParameter(p, 'rightAscensionOfAscendingNode', nan);
            addParameter(p, 'argumentOfPeriapsis', nan);
            addParameter(p, 'trueAnomaly', nan);
            addParameter(p, 'startTime', []);
            addParameter(p, 'stopTime', []);
            addParameter(p, 'sampleTime', []);
            addParameter(p, 'Name', '');
            % satellite surface reflection properties
            addParameter(p, 'Surface', Satellite_Foil_Surface(4))
            addParameter(p, 'Area', [])
            % downlink beacon, if wanted
            addParameter(p, 'Beacon', [])

            parse(p, Source, Telescope, varargin{:});

            sma = p.Results.semiMajorAxis;
            ecc = p.Results.eccentricity;
            inc = p.Results.inclination;
            raan = p.Results.rightAscensionOfAscendingNode;
            aop = p.Results.argumentOfPeriapsis;
            ta = p.Results.trueAnomaly;
            
            hasVelocity = false;

            if (~any(isnan(arrayfun(@isnan, [sma, ecc, inc, raan, aop, ta]))) ...
                    & isempty(p.Results.KeplerElements))
                KeplerElements = [sma, ecc, inc, raan, aop, ta];
            else
                KeplerElements = p.Results.KeplerElements;
            end

            if ~isempty(p.Results.Name)
                Satellite.Name = p.Results.Name;
            end

            if (0 > utils().nan_present(p.Results.OrbitDataFileLocation, ...
                    p.Results.scenario, ...
                    p.Results.ToolBoxSatellite, ...
                    p.Results.TLE, ...
                    KeplerElements))
                error(['Input does not contain one of the following: [', ...
                    'OrbitDataFileLocation', 'TLE', 'KeplerElements', ']']);
            end

            if ~isempty(p.Results.OrbitDataFileLocation)
                [Satellite, lat, lon, alt, t] = ReadOrbitLLATFile(Satellite,...
                    p.Results.OrbitDataFileLocation);

            elseif p.Results.useSatCommsToolbox == true
                if isempty(p.Results.ToolBoxSatellite) | isempty(p.Results.scenario)
                    error('No toolbox satellite supplied');
                    
                else
                    [Satellite, lat, lon, alt, t, vE, vN, vU] = llatAndVelFromScenario(...
                        Satellite, 'satCommsSatellite', p.Results.ToolBoxSatellite);
                    hasVelocity = true;
                end

            else
                if isdatetime(p.Results.startTime)
                    scenario = satelliteScenarioWrapper(p.Results.startTime, ...
                                                        p.Results.stopTime, ...
                                                        'sampleTime', p.Results.sampleTime);
                else
                    scenario = p.Results.scenario;

                end

                varargout{1} = scenario;
                if ~isempty(p.Results.TLE)
                    [Satellite, lat, lon, alt, t, vE, vN, vU] = llatAndVelFromScenario(...
                        Satellite, 'scenario', scenario, 'TLE', TLE);
                    hasVelocity = true;

                elseif ~isempty(KeplerElements)
                    [rows, cols] = size(KeplerElements);
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
            if ~AreSameDimensions(t, lat, lon, alt)
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
            Satellite.Times = t;

            Satellite.Source = p.Results.Source;
            Satellite.Telescope = p.Results.Telescope;
            Satellite.Telescope = SetWavelength(Satellite.Telescope, ...
                Satellite.Source.Wavelength);

            %% set surface object of satellite
            Satellite.Surface = p.Results.Surface;
            %and set area property if given
            if ~isempty(p.Results.Area)
                Satellite.Surface = SetArea(Satellite.Surface,p.Results.Area);
            end

            %% set beacon on satellite
            Satellite.Beacon = p.Results.Beacon;
        end


        function [Satellite, lat, lon, alt, t] = ReadOrbitLLATFile(Satellite, ...
                Orbit_Data_File_Location)
            %ReadOrbitLLATFile Read in the given (or internally pointed to
            %if no file is given) orbit data file
            %% add orbit files to path

            addpath(LocationofFile(Orbit_Data_File_Location));

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
            t = LLATData(4,:);
        end


        function [Satellite, lat, lon, alt, t, vE, vN, vU] = llatAndVelFromScenario(Satellite, ...
                                                                         varargin)
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

            if ~isempty(p.Results.scenario) & isnan(p.Results.TLE) ...
                    & isempty(p.Results.KeplerElements)

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

                sc_sat = satellite(p.Results.scenario, p.Results.TLE, "Name", ... 
                    Satellite.Name, "OrbitPropagator", "two-body-keplerian");

                [position, velocity, t] = states(sc_sat, ...
                                                 'CoordinateFrame', 'geographic');
                Satellite.Name = sc_sat.satellite(1).Name;

            % elseif ~any(arrayfun(@isnan, [p.Results.satCommsSatellite, ...
            %                               p.Results.KeplerElements]))
            elseif any([isnan(p.Results.satCommsSatellite), isempty(p.Results.KeplerElements)])

                % Third case: same as above except we have received an array of
                % kepler elements rather than TLE data

                [sma, ecc, inc, raan, aop, ta] = utils().splat(p.Results.KeplerElements);

                sc_sat = satellite(p.Results.scenario, sma, ecc, inc, raan, aop, ta, ...
                    "Name", Satellite.Name, "OrbitPropagator", "two-body-keplerian");

                [position, velocity, t] = states(sc_sat, ...
                                                 'CoordinateFrame', 'geographic');
                Satellite.Name = sc_sat.Name;
            end

            % Next break out the position matrix into an array each for:
            %   - {latitiude, longitude, altitude}
            lat = position(1, :);
            lon = position(2, :);
            alt = position(3, :);

            % Since we work in the East-North-Up coordinate frame we need to 
            % change the format of the velocities from NED to ENU.
            % See 'basic classes/utils.m for details.
            velocity_enu = utils().ned2enu(velocity);
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


        function Distances = ComputeDistancesTo(Satellite, LLA)
            %%COMPUTEDISTANCESTO return the distances to a fixed LLA over a
            %%satellite pass
            %% convert from LLA of satellite to ENU relative to ground station
            LLA_satellite = [Satellite.Latitudes', ...
                Satellite.Longitudes', ...
                Satellite.Altitudes'];

            ENU = lla2enu(LLA_satellite, LLA, "ellipsoid");
            Distances = Row2Norms(ENU);
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

    end
end
