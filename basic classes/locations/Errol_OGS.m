classdef Errol_OGS < Ground_Station
    %ERROL_850_OGS example OGS instance which represents the proposed errol
    %site

    properties
%all properties inherited from Ground_Station
    end

    methods
        function Errol_OGS = Errol_OGS(Telescope,varargin)
            %Errol_OGS Construct an instance of a OGS at HWU site at the
            %input wavelength

            Errol_OGS = Errol_OGS@Ground_Station(...
                Telescope, ...
                varargin{:},... %any other inputs
                LLA = [56.40555555, -3.18833333, 10], ... %coords
                Name = 'Errol') %location name
        end

    end
end
