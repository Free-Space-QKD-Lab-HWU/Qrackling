classdef LPM_City < Background_Source
    %LPM_CITY     a class which implements a background source from
    %data taken from https://www.lightpollutionmap.info
    properties (SetAccess=public)
            MeanRadiance_W_per_cm2str;                                 %mean radiance of edinburgh in W/cm^2str
            CircleRadius_km;                                 %radius of a circle over which mean radiance was calculated (in km)
    end
    properties (SetAccess=private,Hidden=true)
            LightPollutionMapConversionFactor=10^4;                        %conversion from cm^-2 to m^-2

    end

    methods
        function City = LPM_City(MeanRadiance,CircleRadius_km,LLA,name)
            %LPM_CITY Construct an instance of this class
            %inputs are mean radiance, circle radius (in km), a LLA 1x3 row
            %vector and an optional name char

            %Background_Source properties
            LightPollutionMapConversionFactor=10^-5;                        %conversion from cm^-2 to m^-2 and from nW to W
            Emission_Wavelength_Range=[300,1000];                          %wavelength range over which LightPollutionMap emission is assumed measured

            CityPointance=MeanRadiance*pi*(CircleRadius_km*1000)^2*LightPollutionMapConversionFactor;    %pointance is the measure of power per steradian and is appropriate here
            City@Background_Source(LLA,CityPointance,Emission_Wavelength_Range,name);
            %city specific properties
            City.MeanRadiance_W_per_cm2str=MeanRadiance;
            City.CircleRadius_km=CircleRadius_km;
        end
    end
end