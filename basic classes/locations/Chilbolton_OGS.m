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
                'LLA',[51.142680,-1.436580,86],... %COORDS
                'name','Chilbolton',...
                varargin{:});%location name

        end

    end
end