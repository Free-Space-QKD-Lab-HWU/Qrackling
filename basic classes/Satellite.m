%Author: Cameron Simmons, Peter Barrow
%Date: 24/1/22

classdef Satellite < Located_Object
    %SATELLITE abstract class containing the satellite properties for simulation

    %hide large or uninteresting properties, not abstract for this reason
    properties (SetAccess=protected, Hidden=true)
        N_Steps{mustBeScalarOrEmpty, mustBePositive}
        Times % {mustBeNumeric} not sure what this would need to be for datetimes

        %{
        If using TLE or KeplerElements to define satellite path we will
        store the satelliteScenario object as well as the corresponding
        satellite object
        %}
        using_satcomms_toolbox{mustBeNumericOrLogical} = false;
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
        %   - frontal area of the satellite in m^2
        %   - reflectivity of satellite coating (dimensionless)
        Frontal_Area{mustBeScalarOrEmpty,mustBePositive} = 4;
        Reflectivity{mustBeScalarOrEmpty, ...
                     mustBeLessThan(Reflectivity, 1)} = 0.3;
    end

    methods
        function Satellite = Satellite(Source,Telescope,varargin)
            
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
            addParameter(p, 'TLE', []);
            addParameter(p, 'KeplerElements', []);
            addParameter(p, 'startTime', []);
            addParameter(p, 'stopTime', []);
            addParameter(p, 'sampleTime', []);
            addParameter(p, 'Name', "");

            parse(p, Source, Telescope, varargin{:});

            if strcmp(p.Results.Name, "")
                Satellite.Name = string(matlab.lang.internal.uuid());
            else
                Satellite.Name = p.Results.Name;
            end
            if (0 > utils().nan_present(p.Results.OrbitDataFileLocation, ...
                                       p.Results.ToolBoxSatellite, ...
                                       p.Results.TLE, ...
                                       p.Results.KeplerElements))
                error(['Input does not contain one of the following: [', ...
                       'OrbitDataFileLocation', 'TLE', 'KeplerElements', ']']);
            end


            % if ~(sum(isnan([p.Results.startTime, ...
            %                 p.Results.stopTime, ...
            %                 p.Results.sampleTime])) == 3)
            %     error('startTime, stopTime and sampleTime are all required');
            % end

            if ~isempty(p.Results.OrbitDataFileLocation)
                [Satellite, lat, lon, alt, t] = ReadOrbitLLATFile(Satellite,...
                                              p.Results.OrbitDataFileLocation);
            elseif ~isempty(p.Results.ToolBoxSatellite)
                scenario = p.Results.ToolBoxSatellite;
                [Satellite, lat, lon, alt, t] = llatFromScenario(Satellite,...
                                                                 scenario);
            else
                Satellite.satellite_scenario = satelliteScenario(startTime, ...
                                                                 stopTime, ...
                                                                 sampleTime);
                if ~isempty(p.Results.TLE)
                    [Satellite, lat, lon, alt, t] = llatFromPropagator(...
                                                                Satellite, ...
                                                                TLE);
                    Satellite.Name = Satellite.sc_sat.satellite(1).Name;

                elseif ~isempty(p.Results.KeplerElements)
                    [rows, cols] = size(p.Results.KeplerElements);
                    if cols ~= 6
                        error(['Require all 6 Kepler Elements, in order:', ...
                          newline, char(9), 'semiMajorAxis', ...
                          newline, char(9), 'eccentricity', ...
                          newline, char(9), 'inclination', ...
                          newline, char(9), 'rightAscensionOfAscendingNode', ...
                          newline, char(9), 'argumentOfPeriapsis', ...
                          newline, char(9), 'trueAnomaly'])
                    end
                    [Satellite, lat, lon, alt, t] = llatFromKepler(...
                                                            Satellite, ...
                                                            KeplerElements, ...
                                                            startTime, ...
                                                            stopTime, ...
                                                            sampleTime);
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
            Satellite.N_Steps = Satellite.N_Position;
            Satellite.Times = t;

            Satellite.Source = p.Results.Source;
            Satellite.Telescope = p.Results.Telescope;
            Satellite.Telescope = SetWavelength(Satellite.Telescope, ...
                                                Satellite.Source.Wavelength);            
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

        function [Satellite, lat, lon, alt, t] = llatFromScenario(Satellite, ...
                                                                  scenario)
            [pos, vel, t] = states(scenario, 'CoordinateFrame', 'geographic');
            [lat, lon, alt] = utils().splat(pos');
        end

        function [Satellite, lat, lon, alt, t] = llatFromTLE(Satellite, TLE)

            Satellite.sc_sat = satellite(Satellite.satellite_scenario, ...
                                         TLE, "Name", Satellite.Name, ...
                                         "OrbitPropagator", ...
                                         "two-body-keplerian");

            [position, velocity, t] = states(Satellite.sc_sat, ...
                                            'CoordinateFrame', 'geographic');
            lat = position(:, :, 1);
            lon = position(:, :, 2);
            alt = position(:, :, 3);
        end

        function [Satellite, lat, lon, alt, t] = llatFromKepler(Satellite, ...
                                                                KeplerElements)
            % Takes KeplerElements in the form (and order):
            %     semiMajorAxis,
            %     eccentricity,
            %     inclination,
            %     rightAscensionOfAscendingNode,
            %     argumentOfPeriapsis,
            %     trueAnomaly,

            [sma, ecc, inc, raan, aop, ta] = utils().splat(KeplerElements);

            Satellite.sc_sat = satellite(Satellite.satellite_scenario, ...
                                         sma, ecc, inc, raan, aop, ta, ...
                                         "Name", Satellite.Name, ...
                                         "OrbitPropagator", ...
                                         "two-body-keplerian");

            [position, velocity, t] = states(Satellite.sc_sat, ...
                                            'CoordinateFrame', 'geographic');
            lat = position(:, :, 1);
            lon = position(:, :, 2);
            alt = position(:, :, 3);
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
            Satellite.Frontal_Area = Area;
        end

        function Satellite = SetReflectivity(Satellite, reflectivity)
             %%SETFRONTALAREA set the frontal area property
             Satellite.Reflectivity = reflectivity;
        end

    end
end
