classdef HWU_OGS < Ground_Station
    %York_OGS example OGS instance which represents the proposed
    %York site

    properties
%all properties inherited from BB84Ground_Station
    end

    methods
        function HWU_OGS = HWU_OGS(Detector,Telescope)
            %HWU_OGS Construct an instance of a OGS at HWU site at the
            %input wavelength

            %wavelength can be 780 or 850 only as these are what we have
            %data for 
            switch Detector.Wavelength
                case 780
                    Background_Light_Data_Location='orbit modelling resources\background count rate files\HWU780nm.mat';
                case 850
                    Background_Light_Data_Location='orbit modelling resources\background count rate files\HWU850nm.mat';
                otherwise
                    error('no background light data for HWU at that wavelength')
            end

            HWU_OGS=HWU_OGS@Ground_Station(Background_Light_Data_Location,... 
                Detector,...
                Telescope,...
                'HWU',...%location name
                [55.911420,-3.322424,84]); %no LLA provided
        end

    end
end