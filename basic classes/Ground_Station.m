%Author: Cameron Simmons
%Date: 24/1/22

classdef Ground_Station < Located_Object
    %Ground_Station an object containing all of the simulation parameters of the ground station

    properties (Abstract=false,SetAccess=protected)
        Protocol{mustBeText}='';                                           %name of protocol to be used
        
        Detector                                                           %a receiver object, validated individually in subclasses
        Telescope Telescope

        Background_Count_Rate_File_Location{mustBeText}='';                    %pointer to a file containing the background count rate data for this ground station (stored in counts/steradian)
        Background_Count_Rates{isstruct,isfield(Background_Count_Rates,'Heading'),isfield(Background_Count_Rates,'Elevation'),isfield(Background_Count_Rates,'Count_Rate')};%background count rate (in counts/s) as a function of heading and elevation, stored as a structure with fields 'Count_Rate','Heading' and 'Elevation'
    end
    
    properties (Abstract=false,SetAccess=protected,Hidden=true)
        Headings{mustBeVector}=nan;                                        %Heading of the satellite in degrees as seen from the OGS
        Elevations{mustBeVector}=nan;                                      %Elevation of the satellite in degrees as seen from the OGS
        Satellite_ENUs{mustBeNumeric}                                      %the coordinates of the satellite relative to the ground station in metres east, north and up
        Satellite_Ranges{mustBeVector}=nan;                                %range to the satellite in m over many time steps

        Elevation_Limit{mustBePositive}=30;                                %minimum elevation to establish a link in deg

        Light_Pollution_Count_Rates{mustBeVector,mustBeNonnegative}=0;        %count rates at the Ground station due to light pollution
        Dark_Count_Rates{mustBeVector,mustBeNonnegative}=0;                   %count rates at the Ground station due to dark counts
        Reflection_Count_Rates{mustBeVector,mustBeNonnegative}=0;             %count rates at the Ground station due to reflected light off satellite
    end

    methods
        function Ground_Station = Ground_Station(Background_Count_Rate_File_Location,Detector,Telescope,Location_Name,LLA)
            %GROUND_STATION instantiate a ground station using either a
            %named location or a location name and LLA
            
            %set Telescope parameters
            Ground_Station.Detector=Detector;
            Ground_Station.Telescope=Telescope;

            %set Background count rate data
            Ground_Station=ReadBackgroundCountRateData(Ground_Station,Background_Count_Rate_File_Location);

            %set location using custom method
            Ground_Station=SetPosition(Ground_Station,LLA,Location_Name);
        end


        function [Background_Count_Rates,Background_Count_Rates_Per_Steradian_Per_nm]=GetLightPollutionCountRate(Ground_Station,Headings,Elevations)
            %%GETBACKGROUNDCOUNTRATE return the background count rate
            %%values closest to the input headings and elevations in an
            %%array of the same dimensions

            %% input validation
            %heading and elevation arrays must be same dimensions
            if ~AreSameDimensions(Headings,Elevations)
                error('heading and elevation arrays must be of same dimensions')
            else
                %assign memory for Background_Count_Rates
                Background_Count_Rates=zeros(size(Headings));
                Background_Count_Rates_Per_Steradian_Per_nm=zeros(size(Headings));
            end

            %% iterating over entries in heading and elevation arrays
            Dimensions=size(Headings);
            for i=1:Dimensions(1)
                for j=1:Dimensions(2)
                    Heading=Headings(i,j);
                    Elevation=Elevations(i,j);

                        %% find closest per steradian value to given heading and elevation
                        %get heading and elevation of measurements
                        Measurement_Headings=Ground_Station.Background_Count_Rates.Heading;
                        Measurement_Elevation=Ground_Station.Background_Count_Rates.Elevation;
                        %find minimum distance from value
                        [~,Heading_Index]=min(abs(mod(Measurement_Headings-Heading,360)));
                        Heading_Index=Heading_Index(1);%take a single, unique minimum
                        [~,Elevation_Index]=min(abs(Measurement_Elevation-Elevation));
                        %get background counts per steradian
                        Background_Count_Rate_Per_Steradian_Per_nm=Ground_Station.Background_Count_Rates.Count_Rate(Heading_Index,Elevation_Index);

                        %% convert to counts in this specific telescope
                        Background_Count_Rate=Ground_Station.Detector.Detection_Efficiency*Background_Count_Rate_Per_Steradian_Per_nm*pi*(Ground_Station.Telescope.FOV/2)^2*Ground_Station.Detector.Spectral_Filter_Width;

                        %% store this result
                        Background_Count_Rates(i,j)=Background_Count_Rate;
                        Background_Count_Rates_Per_Steradian_Per_nm(i,j)=Background_Count_Rate_Per_Steradian_Per_nm;
                end
            end
        end

        function Ground_Station=ReadBackgroundCountRateData(Ground_Station,Background_Count_Rate_File_Location)
            %% input validation
            if ~nargin==2
                error('ReadBackgroundCountRateData takes only a Ground_Station object and .mat file location as arguments');
            end
            
                % if 'none' is provided
                if isequal(Background_Count_Rate_File_Location,'none')
                    Ground_Station.Background_Count_Rate_File_Location='none';
                    Ground_Station.Background_Count_Rates.Count_Rate=0;
                    Ground_Station.Background_Count_Rates.Heading=0;
                    Ground_Station.Background_Count_Rates.Elevation=0;
                    return
                end

            %% add background light files to path
            addpath(LocationofFile(Background_Count_Rate_File_Location));
                %if a file is provided, use this file location
                if ~(exist(Background_Count_Rate_File_Location,'file'))
                    error('cannot find a mat file of that name and location');
                end
                Ground_Station.Background_Count_Rate_File_Location=Background_Count_Rate_File_Location;
 
            %% read in
            Ground_Station.Background_Count_Rates=load(Background_Count_Rate_File_Location);
        end
    
        function Ground_Station=SetWavelength(Ground_Station,Wavelength)
            %%SETWAVELENGTH set the wavelength (in nm) of the receiver
            Ground_Station.Detector=SetWavelength(Ground_Station.Detector,Wavelength);
        end
    
        function [Total_Background_Count_Rate,Ground_Station,Headings,Elevations]=ComputeTotalBackgroundCountRate(Ground_Station,Background_Sources,Satellite)
            %%COMPUTETOTALBACKGROUNDCOUNTRATE return the total count rate
            %%at the given headings and elevations
            
            %% Background light pollution
            % compute relative heading and elevation
            [Headings,Elevations,~]=RelativeHeadingAndElevation(Satellite,Ground_Station); %#ok<*PROP> 
            % find light pollution count rate for given headings and elevations
            Light_Pollution_Count_Rate=GetLightPollutionCountRate(Ground_Station,Headings,Elevations);
            

            %% Reflected light pollution
            Reflection_Count_Rate=zeros(size(Light_Pollution_Count_Rate));
            for i=1:length(Background_Sources)
                %limit reflected light pollution to line of sight between
                %satellite and background source
                [~,Background_Source_Elevations]=RelativeHeadingAndElevation(Satellite,Background_Sources(i));
                Elevation_Limit=Background_Sources(i).Elevation_Limit; %#ok<*PROPLC> 
                Possible_Refleced_Counts=GetReflectedLightPollution(Background_Sources(i),Satellite,Ground_Station);
                Reflection_Count_Rate(Background_Source_Elevations>Elevation_Limit)=Reflection_Count_Rate(Background_Source_Elevations>Elevation_Limit)+Possible_Refleced_Counts(Background_Source_Elevations>Elevation_Limit); %#ok<*AGROW> 
            end
            
            %% Dark_Counts
            Dark_Counts=ones(size(Headings))*Ground_Station.Detector.Dark_Count_Rate;
            
            %% output value
            Ground_Station.Light_Pollution_Count_Rates=Light_Pollution_Count_Rate;
            Ground_Station.Reflection_Count_Rates=Reflection_Count_Rate;
            Ground_Station.Dark_Count_Rates=Dark_Counts;
            Total_Background_Count_Rate=Light_Pollution_Count_Rate+Reflection_Count_Rate+Dark_Counts;
        end
       
        function PlotBackgroundCountRates(Ground_Station,Plotting_Indices,X_Axis)
            %%PLOTBACKGROUNDCOUNTRATES plot the background count rates
            %%affecting the ground station
            area(X_Axis,[Ground_Station.Dark_Count_Rates(Plotting_Indices)',Ground_Station.Reflection_Count_Rates(Plotting_Indices)',Ground_Station.Light_Pollution_Count_Rates(Plotting_Indices)']);
            ylabel('Background count rate (cps)')

            %% adjust legend to represent what is plotted
            %reflection and light poluution are non zero
            if any(Ground_Station.Reflection_Count_Rates(Plotting_Indices))&&any(Ground_Station.Light_Pollution_Count_Rates(Plotting_Indices))
            legend('Dark counts','Reflection off satellite','Light pollution count rates');
            %no reflection
            elseif (~any(Ground_Station.Reflection_Count_Rates(Plotting_Indices)))&&any(Ground_Station.Light_Pollution_Count_Rates(Plotting_Indices))
            legend('Dark counts','','Light pollution count rates');
            %no Light pollution
            elseif (any(Ground_Station.Reflection_Count_Rates(Plotting_Indices)))&&(~any(Ground_Station.Light_Pollution_Count_Rates(Plotting_Indices)))
            legend('Dark counts','Reflection off satellite','');
            else
            %neither reflection nor light pollution
            legend('Dark counts','','');
            end
            legend('Location','southeast')

        end
    
        function Ground_Station=SetElevationLimit(Ground_Station,Elevation_Limit)
            %%SETELEVATIONLIMIT set the minimum elevation over which
            %%communication can occur
            Ground_Station.Elevation_Limit=Elevation_Limit;
        end
    
        function PlotLOS(Ground_Station,Satellite_Altitude)

            % plot ground station
            geoplot(Ground_Station.Latitude,Ground_Station.Longitude,'k*','MarkerSize',20);
            hold on
                %plot the ground station's elevation window
                Headings=1:359;
                WindowLat=zeros(1,359);
                WindowLon=zeros(1,359);
                ArcDistance=ComputeLOSWindow(Satellite_Altitude,Ground_Station.Elevation_Limit);
                for Heading=Headings
                [CurrentWindowLat,CurrentWindowLon]=MoveAlongSurface(Ground_Station.Latitude,Ground_Station.Longitude,ArcDistance,Heading);
                WindowLat(Heading)=CurrentWindowLat;
                WindowLon(Heading)=CurrentWindowLon;
                end
                geoplot(WindowLat,WindowLon,'k--')
                AddToLegend('Ground Station orbit LOS','Ground Station')
        end
        
    end
end