classdef Background_Source < Located_Object
    %Background_Source a source of optical interference for optical comms

    %this background source is modelled as a point source which has
    %pointance (power per unit solid angle) spread over many wavelengths
    properties
        Spectral_Pointance{mustBeNumeric}                                  %power per unit solid angle as a function of wavelength in W/str/nm for this source
        Wavelength_Limits{mustBeNumeric}                                   %wavelengths (in nm) over which the radiance per unit bandwidth is specified
        Elevation_Limit{mustBeScalarOrEmpty,mustBeLessThanOrEqual(Elevation_Limit,90)}=0;%minimum elevation at which laser can be fired in degrees
    end

    methods
        function obj = Background_Source(LLA,Spectral_Pointance,Wavelength_Limits,varargin)
            %Background_Source Construct an instance of this class
            %specify and set location (lat, lon, alt), radiance and
            %wavelength range

            %% create and use input parser
            P=inputParser;
            %required inputs
            addRequired(P,'LLA');
            addRequired(P,'Spectral_Pointance');
            addRequired(P,'Wavelength_Limits');
            %optional inputs
            addParameter(P,'Location_Name','Background source');
            addParameter(P,'Elevation_Limit',obj.Elevation_Limit)
            %parse inputs
            parse(P,LLA,Spectral_Pointance,Wavelength_Limits,varargin{:});

            %% set values
            obj=SetPosition(obj,'LLA',P.Results.LLA,'Name',P.Results.Location_Name);
            obj.Spectral_Pointance=P.Results.Spectral_Pointance;
            obj.Wavelength_Limits=P.Results.Wavelength_Limits;
            obj=SetElevationLimit(obj,P.Results.Elevation_Limit);
        end

        function Total_Spectral_Pointance = GetRadiantEmission(Background_Source,Wavelength_Floor,Wavelength_Ceiling)
            %GETRADIANTEMISSION output the total emission in a wavelength
            %range specified by its minimum and maximum

            %% input validation
            if ~(isscalar(Wavelength_Floor)&&isscalar(Wavelength_Ceiling))
                error('Wavelength_Floor and Wavelength_Ceiling must be scalar values')
            end
            if ~(isnumeric(Wavelength_Floor)&&isnumeric(Wavelength_Ceiling)&&Wavelength_Ceiling>=0&&Wavelength_Floor>=0)
                error('Wavelength_Floor and Wavelength_Ceiling must be non-negative numeric values')
            end

            %% compute emission inside specified range
            %find and store wavelength range and radiance
            Wavelength_Limits=Background_Source.Wavelength_Limits; %#ok<*PROPLC>
            Spectral_Pointance=Background_Source.Spectral_Pointance;

            %% detect if no emission occurs in specified range
            if Wavelength_Ceiling<min(Wavelength_Limits)||Wavelength_Floor>max(Wavelength_Limits)
                Total_Spectral_Pointance=0;
                return
            end

            %% detect if entire background source emission is within wavelength ceiling and floor
            if Wavelength_Floor<=min(Wavelength_Limits)&&Wavelength_Ceiling>=max(Wavelength_Limits)
                Total_Spectral_Pointance=dot(Spectral_Pointance,Wavelength_Limits(2:end)-Wavelength_Limits(1:end-1));
                return
            end

            %% detect if entire requested range is within one radiance measurement
            if all(Wavelength_Floor>=Wavelength_Limits|Wavelength_Ceiling<=Wavelength_Limits)
                [~,Relevant_Radiance_Index]=min(Wavelength_Limits>=Wavelength_Floor);
                Relevant_SP=Spectral_Pointance(Relevant_Radiance_Index);
                Total_Spectral_Pointance=Relevant_SP*(Wavelength_Ceiling-Wavelength_Floor)/(Wavelength_Limits(Relevant_Radiance_Index+1)-Wavelength_Limits(Relevant_Radiance_Index));
                return
            end



            %% segment wavelength vector by bounds
            Below_Wavelength_Floor_Indices=Wavelength_Limits<Wavelength_Floor;
            Between_Bounds_Indices=(Wavelength_Limits>=Wavelength_Floor)&(Wavelength_Limits<=Wavelength_Ceiling);
            Above_Wavelength_Ceiling_Indices=Wavelength_Limits>Wavelength_Ceiling;

            %% compute radiance from lower bound edge
            %get nearby values
            Below_Wavelength_Floor=Wavelength_Limits(Below_Wavelength_Floor_Indices);
            Immediately_Below_Wavelength_Floor=max(Below_Wavelength_Floor);
            Between_Bounds=Wavelength_Limits(Between_Bounds_Indices);
            Immediately_Above_Wavelength_Floor=min(Between_Bounds);

            %compute value
            Lower_Bound_Radiance=Spectral_Pointance(sum(Below_Wavelength_Floor_Indices))*(Immediately_Above_Wavelength_Floor-Wavelength_Floor)/(Immediately_Above_Wavelength_Floor-Immediately_Below_Wavelength_Floor);

            %% compute radiance from upper bound edge
            %get nearby values
            Above_Wavelength_Ceiling=Wavelength_Limits(Above_Wavelength_Ceiling_Indices);
            Immediately_Above_Wavelength_Ceiling=min(Above_Wavelength_Ceiling);
            Immediately_Below_Wavelength_Ceiling=max(Between_Bounds);

            %compute value
            Upper_Bound_Radiance=Spectral_Pointance(end+1-sum(Above_Wavelength_Ceiling_Indices))*(Wavelength_Ceiling-Immediately_Below_Wavelength_Ceiling)/(Immediately_Above_Wavelength_Ceiling-Immediately_Below_Wavelength_Ceiling);

            %% compute radiance between bounds
            In_Range_Radiance=sum(Spectral_Pointance(Between_Bounds_Indices));

            %% compute total
            Total_Spectral_Pointance=Lower_Bound_Radiance+In_Range_Radiance+Upper_Bound_Radiance;

        end

        function [Reflected_Count_Rate,Reflected_Power]=GetReflectedLightPollution(Background_Source,Satellite,Ground_Station)
            %%GETREFLECTEDLIGHTPOLLUTION return the count rate and optical
            %%power reflected off a satellite and into a ground station
            %%from a background source over many time periods
            h=6.62607015*10^-34;%plank's constant
            c=299792458; %speed of light

            %% compute emission inside the ground_Station wavelength filter width
            Wavelength_Floor=Ground_Station.Detector.Wavelength-Ground_Station.Detector.Spectral_Filter_Width/2;
            Wavelength_Ceiling=Ground_Station.Detector.Wavelength+Ground_Station.Detector.Spectral_Filter_Width/2;
            Radiant_Power=GetRadiantEmission(Background_Source,Wavelength_Floor,Wavelength_Ceiling);

            %% get reflective link loss
            Sat_Ref_Link_Model=Satellite_Reflection_Link_Model(Satellite.N_Steps);
            Sat_Ref_Link_Model=Compute_Link_Loss(Sat_Ref_Link_Model,Satellite,Ground_Station,Background_Source);
            [~,~,Total_Loss]=SetTotalLoss(Sat_Ref_Link_Model);

            %% use this to compute reflected power
            Reflected_Power=Radiant_Power.*Total_Loss;

            %% and photon count
            Reflected_Count_Rate=Reflected_Power*(Ground_Station.Detector.Wavelength*10^-9)/(h*c);

        end

        function PlotLOS(Background_Source,Satellite_Altitude)
            %% plot the location and LOS of a background source

            % plot ground station
            geoplot(Background_Source.Latitude,Background_Source.Longitude,'r*','MarkerSize',8);
            hold on
            %plot the ground station's elevation window
            Headings=1:359;
            WindowLat=zeros(1,359);
            WindowLon=zeros(1,359);
            ArcDistance=ComputeLOSWindow(Satellite_Altitude,Background_Source.Elevation_Limit);
            for Heading=Headings
                [CurrentWindowLat,CurrentWindowLon]=MoveAlongSurface(Background_Source.Latitude,Background_Source.Longitude,ArcDistance,Heading);
                WindowLat(Heading)=CurrentWindowLat;
                WindowLon(Heading)=CurrentWindowLon;
            end
            geoplot(WindowLat,WindowLon,'r--')
            AddToLegend([Background_Source.Location_Name,' orbit LOS'],Background_Source.Location_Name);
        end

        function Background_Source=SetElevationLimit(Background_Source,Elevation_Limit)
            %%SETELEVATIONLIMIT
            Background_Source.Elevation_Limit=Elevation_Limit;
        end

    end
end