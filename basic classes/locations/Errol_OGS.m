classdef Errol_OGS < Ground_Station
    %ERROL_850_OGS example OGS instance which represents the proposed errol
    %site

    properties
%all properties inherited from Ground_Station
    end

    methods
        function Errol_OGS = Errol_OGS(Detector,Telescope)
            %Errol_OGS Construct an instance of a OGS at HWU site at the
            %input wavelength

            %wavelength can be 780 or 850 only as these are what we have
            %data for 
            switch Detector.Wavelength
                case 780
                    Background_Light_Data_Location='orbit modelling resources\background count rate files\ErrolWithMoon780nm.mat';
                case 850
                    Background_Light_Data_Location='orbit modelling resources\background count rate files\ErrolWithMoon850nm.mat';
                otherwise
                    error('no background light data for Errol at receiver wavelength')
            end

            Errol_OGS=Errol_OGS@Ground_Station(Detector,...
                Telescope,...
                [56.40555555,-3.18833333,10],... %coords
                'Background_Count_Rate_File_Location',Background_Light_Data_Location,... 
                'Location_Name','Errol');%location name
                
        end

    end
end