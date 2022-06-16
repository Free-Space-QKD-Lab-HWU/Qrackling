classdef Chilbolton_OGS < Ground_Station
    %Chilbolton_OGS example OGS instance which represents the proposed
    %Chilbolton site

    properties
%all properties inherited from BB84Ground_Station
    end

    methods
        function Chilbolton_OGS = Chilbolton_OGS(Detector,Telescope)
            %Chilbolton_OGS Construct an instance of a OGS at HWU site at the
            %input wavelength

            %wavelength can be 780 or 850 only as these are what we have
            %data for 
            switch Detector.Wavelength
                case 780
                    Background_Light_Data_Location='orbit modelling resources\background count rate files\ChilboltonWithHeadlights780nm.mat';
                case 850
                    Background_Light_Data_Location='orbit modelling resources\background count rate files\ChilboltonWithHeadlights780nm.mat';
                    warning('no 850nm data available from Chilbolton, using 780nm count rates instead');
                otherwise
                    error('no background light data for Chilbolton at that wavelength')
            end

            Chilbolton_OGS=Chilbolton_OGS@Ground_Station(Background_Light_Data_Location,... 
                Detector,...
                Telescope,...
                'Chilbolton',...%location name
                [51.142680,-1.436580,86]); %no LLA provided
        end

    end
end