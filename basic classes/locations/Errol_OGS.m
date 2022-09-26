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
            
            %mimic the behaviour of a switch statement, but with equalities and
            %inequalities in wavelength
            if Detector.Wavelength==780
                    Background_Light_Data_Location='orbit modelling resources\background count rate files\ErrolWithMoon780nm.mat';
                elseif Detector.Wavelength==850
                    Background_Light_Data_Location='orbit modelling resources\background count rate files\ErrolWithMoon850nm.mat';
                elseif Detector.Wavelength>745&&Detector.Wavelength<=815
                    Background_Light_Data_Location='orbit modelling resources\background count rate files\ErrolWithMoon780nm.mat';
                    warning('no background light data for Errol at receiver wavelength. 780nm used as approximation')
                elseif Detector.Wavelength>815&&Detector.Wavelength<885
                    Background_Light_Data_Location='orbit modelling resources\background count rate files\ErrolWithMoon850nm.mat';
                    warning('no background light data for Errol at receiver wavelength. 850nm used as approximation')
                else
                    warning('no background light data for Errol at receiver wavelength. no background light simulated')
                    Background_Light_Data_Location='none';
            end

            Errol_OGS=Errol_OGS@Ground_Station(Detector,...
                Telescope,...
                'LLA',[56.40555555,-3.18833333,10],... %coords
                'Background_Count_Rate_File_Location',Background_Light_Data_Location,... 
                'Name','Errol');%location name
                
        end

    end
end