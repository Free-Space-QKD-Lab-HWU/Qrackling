classdef York_OGS < Ground_Station
    %York_OGS example OGS instance which represents the proposed
    %York site

    properties
%all properties inherited from BB84Ground_Station
    end

    methods
        function York_OGS = York_OGS(Telescope,varargin)
            %Chilbolton_OGS Construct an instance of a OGS at HWU site at the
            %input wavelength

            %wavelength can be 780 or 850 only as these are what we have
            %data for 
            switch Detector.Wavelength
                case 780
                    Background_Light_Data_Location='orbit modelling resources\background count rate files\York780nm.mat';
                case 850
                    Background_Light_Data_Location='orbit modelling resources\background count rate files\York780nm.mat';
                otherwise
                    error('no background light data for York at that wavelength')
            end

            York_OGS=York_OGS@Ground_Station(...
                Telescope,...
                'LLA',[53.943333,-1.0580555,11],... %COORDS
                'Background_Count_Rate_File_Location',Background_Light_Data_Location,... 
                'Name','York',...
                varargin{:});%location name
        end

    end
end