classdef Satellite < Located_Object
    %SATELLITE abstract class containing the satellite properties for simulation

    properties (SetAccess=protected,Hidden=true)%hide large or uninteresting properties, they are not abstract for this reason
        N_Steps{mustBeScalarOrEmpty,mustBePositive}                        %number of data steps available
        Times{mustBeNumeric}                                               %Time values during satellite pass
    end
    
    properties (SetAccess=protected,Hidden=false)%do not hide small properties
        Orbit_Data_File_Location{mustBeText}='';                           %Location of the file containing Latitude, Longitude, Altitude and Time data
        Source                                                             %object containing transmitter details
        Telescope Telescope                                                %object containing telescope details

        %% information about protocol
        Protocol{mustBeText}='';                                           %protocol used (BB84,BBN92,...)
        Protocol_Efficiency{mustBeScalarOrEmpty}=1;                        %efficiency of the protocol used

        %% information about reflection
        Frontal_Area{mustBeScalarOrEmpty,mustBePositive}=4;                %frontal area of the satellite in m^2
        Reflectivity{mustBeScalarOrEmpty,mustBeLessThan(Reflectivity,1)}=0.3;%reflectivity of satellite coating (dimensionless)

    end

    methods
        function Satellite = Satellite(OrbitDataFileLocation,Source,Telescope)
            %SATELLITE Construct an instance of satellite using an orbital
            %LLAT text file
            Satellite.Source=Source;

            % read in orbit data from LLAT file
            Satellite=ReadOrbitLLATFile(Satellite,OrbitDataFileLocation);

            Satellite.Telescope=Telescope;

            %set Telescope to be wavelength of transmitter
            Satellite.Telescope=SetWavelength(Satellite.Telescope,Satellite.Source.Wavelength);            
        end

        function [Satellite,Latitude,Longitude,Altitude,Time] = ReadOrbitLLATFile(Satellite,Orbit_Data_File_Location)
            %%READORBITLLATFILE Read in the given (or internally pointed to
            %if no file is given) orbit data file

            %% add orbit files to path
            addpath(LocationofFile(Orbit_Data_File_Location));

            if nargin==2
                %if a file is provided, use this file location
                if ~(exist(Orbit_Data_File_Location,'file'))
                    error('cannot find a text file of that name and location');
                end
                Satellite.Orbit_Data_File_Location=Orbit_Data_File_Location;
            elseif nargin>2
                error('ReadOrbitLLATFile takes only a satellite object and .txt file location as arguments');
            end

            %% read orbit data file
            %% open the file and assign it an ID
            FileID=fopen(Orbit_Data_File_Location);

            %% read file as an arrray
            LLATData=fscanf(FileID,'%f,%f,%f,%f',[4,inf]);
            %% close the file
            fclose(FileID);

            %% store data
            % Separate rows into LLA and T
            Latitude=LLATData(1,:);
            Longitude=LLATData(2,:);
            Altitude=LLATData(3,:)*1000; %conversion to m from km
            Time=LLATData(4,:);
            %check data is compatible
            if ~AreSameDimensions(Time,Latitude,Longitude,Altitude)
                error('Latitude, Longitude, Altitude and Time data must be of the same length')
            end
            %set N_Steps
            Satellite=SetPosition(Satellite,Latitude,Longitude,Altitude);
            Satellite.N_Steps=Satellite.N_Position;
            Satellite.Times=Time;

        end
    
        function Satellite=SetWavelength(Satellite,Wavelength)
            %%SETWAVELENGTH set the wavelength property of the internal transmitter and telescope
            Satellite.Source=SetWavelength(Satellite.Source,Wavelength);
            Satellite.Telescope=SetWavelength(Satellite.Telescope,Wavelength);
        end

        function Distances=ComputeDistancesTo(Satellite,LLA)
            %%COMPUTEDISTANCESTO return the distances to a fixed LLA over a satellite pass

            %% readout satellite positions
            Latitudes=Satellite.Latitudes;
            Longitudes=Satellite.Longitudes;
            Altitudes=Satellite.Altitudes;


            %% convert from LLA of satellite to ENU relative to ground station
                LLA_satellite=[Latitudes',Longitudes',Altitudes'];
                ENU=lla2enu(LLA_satellite,LLA,"ellipsoid");
                Distances=Row2Norms(ENU);
        end
        
        function Satellite=SetFrontalArea(Satellite,Area)
            %%SETFRONTALAREA set the frontal area property
            Satellite.Frontal_Area=Area;
        end

       function Satellite=SetReflectivity(Satellite,reflectivity)
            %%SETFRONTALAREA set the frontal area property
            Satellite.Reflectivity=reflectivity;
       end

    end
end