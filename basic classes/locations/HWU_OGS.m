classdef HWU_OGS < Ground_Station
    %HWU_OGS example OGS instance which represents the heriot watt
    %university campus buildings

    properties
%all properties inherited from Ground_Station
    end

    methods
        function HWU_OGS = HWU_OGS(Telescope,varargin)
            %HWU_OGS Construct an instance of a OGS at HWU site at the
            %input wavelength

            HWU_OGS=HWU_OGS@Ground_Station(...
                Telescope,...
                varargin{:},...
                LLA=[55.911420,-3.322424,84],... %COORDS
                Name='HWU',...
                Sky_Brightness_Store_Location = ['orbit modelling resources',filesep,...
                                                 'background count rate files',filesep,...
                                                 'HWU_Experimental_Sky_Brightness_Store.mat']) %data on background light
        end

    end
end