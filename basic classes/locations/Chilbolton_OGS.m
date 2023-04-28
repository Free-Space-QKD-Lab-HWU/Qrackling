classdef Chilbolton_OGS < Ground_Station
    %CHILBOLTON_OGS example OGS instance which represents the proposed
    %Chilbolton site

    properties
%all properties inherited from Ground_Station
    end

    methods
        function Chilbolton_OGS = Chilbolton_OGS(Telescope,varargin)
            %Chilbolton_OGS Construct an instance of a OGS at chilbolton site at the
            %input wavelength

            Chilbolton_OGS=Chilbolton_OGS@Ground_Station(...
                Telescope,...
                varargin{:},...
                LLA=[51.142680,-1.436580,86],... %COORDS
                Name = 'Chilbolton',...
                Sky_Brightness_Store_Location = 'none') %data on background light

        end

    end
end