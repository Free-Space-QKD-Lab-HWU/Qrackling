%Author: Cameron Simmons, Peter Barrow
%Date: 24/1/22

classdef Satellite < Located_Object
    %SATELLITE abstract class containing the satellite properties for simulation

    %hide large or uninteresting properties, not abstract for this reason
    properties (SetAccess=protected, Hidden=true)
        N_Steps{mustBeScalarOrEmpty, mustBePositive}
        Times % {mustBeNumeric} not sure what this would need to be for datetimes

        %% ways of defining satellite position
        %File location for Latitude, Longitude, Altitude and Time data
        Orbit_Data_File_Location{mustBeText} = '';

        % orbital properties for if location data is unknown
        Inclination {mustBeScalarOrEmpty}=nan;
        SemimajorAxis {mustBeScalarOrEmpty}=nan;
        Eccentricity {mustBeScalarOrEmpty}=nan;
        RightAscensionofAscedningNode {mustBeScalarOrEmpty}=nan;
        ArgumentofPeriapsis {mustBeScalarOrEmpty}=nan;
        TrueAnomoly {mustBeScalarOrEmpty}=nan;

        % TLE
        TLE=[];
    end

    %do not hide small properties
    properties (SetAccess=protected, Hidden=false)
        % If not set, initialised to UUID
        Name{mustBeText} = '';

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
            addParameter(p, 'Name', "");
            addParameter(p,'SemimajorAxis',[]);
            addParameter(p,'Eccentricity',[]);
            addParameter(p,'Inclination',[]);
            addParameter(p,'RightAscensionOfAscendingNode',[]);
            addParameter(p,'ArgumentOfPeriapsis',[]);
            addParameter(p,'TrueAnomaly',[]);

            parse(p, Source, Telescope, varargin{:});

            %% sort out unique satellite naming if not previously done
            if strcmp(p.Results.Name, "")
                Satellite.Name = string(matlab.lang.internal.uuid());
            else
                Satellite.Name = p.Results.Name;
            end

            %% check that one of an orbit data file, a TLE set or kepler elements are present
            if (0 > utils().nan_present(p.Results.OrbitDataFileLocation, ...
                    p.Results.ToolBoxSatellite, ...
                    p.Results.TLE, ...
                    p.Results.KeplerElements))
                error(['Input does not contain one of the following: [', ...
                    'OrbitDataFileLocation', 'TLE', 'KeplerElements', ']']);
            end

            %% if an orbit file is provided, store this
            if ~isempty(p.Results.OrbitDataFileLocation)
                [Satellite, lat, lon, alt, t] = ReadOrbitLLATFile(Satellite,...
                    p.Results.OrbitDataFileLocation);
                %            elseif ~isempty(p.Results.ToolBoxSatellite)
                %                scenario = p.Results.ToolBoxSatellite;
                %                 [Satellite, lat, lon, alt, t] = llatFromScenario(Satellite,...
                %                     scenario);

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
            end

            %% if a TLE is provided, store this
            if ~isempty(p.Results.TLE)
                %                 Satellite.satellite_scenario = satelliteScenario(startTime, ...
                %                     stopTime, ...
                %                     sampleTime);
                Satellite.TLE=p.Results.TLE;
            end

            %% if kepler elements are provided as one unit, store them
            if ~isempty(p.Results.KeplerElements)
                %check that these form a 6 element set
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

                % store kepler elements
                Kepler_Elements=p.Results.Kepler_Elements;
                Satellite.Semimajor_Axis=Kepler_Elements(1);
                Satellite.Eccentricity=Kepler_Elements(2);
                Satellite.Inclination=Kepler_Elements(3);
                Satellite.RightAscensionofAscedningNode=Kepler_Elements(4);
                Satellite.ArgumentofPeriapsis=Kepler_Elements(5);
                Satellite.TrueAnomoly=Kepler_Elements(6);
            end

            %% if kepler elements are provided individually
            if ~isempty(p.Results.SemimajorAxis)||...
                    isempty(p.Results.Eccentricity)||...
                    isempty(p.Results.Inclination)||...
                    isempty(p.Results.RightAscensionOfAscendingNode)||...
                    isempty(p.Results.ArgumentOfPeriapsis)||...
                    isempty(p.Results.TrueAnomaly) % if all kepler elements are present

                Satellite.SemimajorAxis=p.Results.SemimajorAxis;
                Satellite.Eccentricity=p.Results.Eccentricity;
                Satellite.Inclination=p.Results.Inclination;
                Satellite.RightAscensionofAscedningNode=p.Results.RightAscensionOfAscendingNode;
                Satellite.ArgumentofPeriapsis=p.Results.ArgumentOfPeriapsis;
                Satellite.TrueAnomoly=p.Results.TrueAnomaly;
            end


            %                     [Satellite, lat, lon, alt, t] = llatFromKepler(...
            %                         Satellite, ...
            %                         KeplerElements, ...
            %                         startTime, ...
            %                         stopTime, ...
            %                         sampleTime);





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

        function HasLLATFlag = HasLLAT(Satellite)
            %%HATLLAT return a logical value which is true when the satellite
            %%has had its LLAT values simulated
            HasLLATFlag=~(isempty(GetLLA(Satellite))||isempty(Satellite.Times));
        end

        function HasKeplerFlag = HasKepler(Satellite)
            %%HATLLAT return a logical value which is true when the satellite
            %%has valid kepler orbit parameters
            HasKeplerFlag=~(isnan(Satellite.Inclination)||...
                isnan(Satellite.SemimajorAxis)||...
                isnan(Satellite.Inclination)||...
                isnan(Satellite.Eccentricity)||...
                isnan(Satellite.RightAscensionofAscedningNode)||...
                isnan(Satellite.ArgumentofPeriapsis)||...
                isnan(Satellite.TrueAnomoly));
        end

        function HasTLEFlag = HasTLE(Satellite)
            %%HASTLE return a logical value which is true when the satellite has
            %%a valid TLE set stored in it
            HasTLEFlag = ~isempty(Satellite.TLE);
        end

        function Toolbox_Scenario = AddSatelliteToToolboxScenario(Satellite,Toolbox_Scenario)
            %%ADDSATELLITETOTOOLBOXSCENARIO add a toolboc satellite with the
            %%same properties as the given satellite to the satellite
            %%communications toolbox scenario

            %% if satellite has kepler orbital parameters, use these
            if HasKepler(Satellite)
                satellite(Toolbox_Scenario,...
                    Satellite.SemimajorAxis,...
                    Satellite.Eccentricity,...
                    Satellite.Inclination,...
                    Satellite.RightAscensionofAscedningNode,...
                    Satellite.ArgumentofPeriapsis,...
                    Satellite.TrueAnomoly,...
                    'Name',Satellite.Name);

            elseif HasLLAT(Satellite)
                %% otherwise, if satellite has numerically defined position, use this
                %get lat lon alt data
                LLA=GetLLA(Satellite);
                %parse this into a table including time
                LLATTable=table('VariableNames',{'LLA','Time'});
                LLATTable.LLA=LLA;
                LLATTable.Time=seconds(Satellite.Times);
                %then pass this table to the satellite constructor
                satellite(Toolbox_Scenario,...
                    LLATTable,'CoordinateFrame','geographic',...
                    'Name',Satellite.Name);

            elseif HasTLE(Satellite)
                %% otherwise, if satellite has a TLE set stored, use this
                satellite(Toolbox_Scenario, ...
                    TLE, "Name", Satellite.Name, ...
                    "OrbitPropagator", ...
                    "two-body-keplerian");

            else
                error('Satellite must have either kepler orbital parameters, a TLE set or lat lon alt time data to be constructed in satcomms toolbox')
            end
        end

        function Satellite=SetTimes(Satellite,Times)
            %%SETTIMES set the times for which this satellite must be simulated


            assert(isvector(Times)&&(isnumeric(Times)||isdatetime(Times)||isduration(Times)),'Times must be a datetime or numeric vector')

            if HasKepler(Satellite)||HasTLE(Satellite)
                %if using orbit paramemters, set times freely

                Satellite.Times=Times;
                Satellite.N_Steps=numel(Times);

            elseif HasLLAT(Satellite)
                %if using LLAT data, can only set times if this matches the length
                %of the data
                if numel(Times)==Satellite.N_Steps
                    Satellite.Times=Times;
                else
                    error('Times must have the same number of elements as LLA data')
                end
            else
                error('Satellite must have some position data format')
            end
        end


    end
end
