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

            York_OGS=York_OGS@Ground_Station(...
                Telescope,...
                varargin{:},...
                LLA=[53.943333,-1.0580555,11],... %COORDS
                Name='York',...
                Sky_Brightness_Store_Location = ['orbit modelling resources',filesep,...
                                                 'background count rate files',filesep,...
                                                 'York_Experimental_Sky_Brightness_Store.mat']) %data on background light
        end

    end
end