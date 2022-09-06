classdef HWU_OGS < Ground_Station
    %HWU_OGS example OGS instance which represents the heriot watt
    %university campus buildings

    properties
%all properties inherited from Ground_Station
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

            HWU_OGS=HWU_OGS@Ground_Station(Detector,...
                Telescope,...
                'LLA',[55.911420,-3.322424,84],... %COORDS
                'Background_Count_Rate_File_Location',Background_Light_Data_Location,... 
                'Name','HWU');%location name
                
        end

    end
end