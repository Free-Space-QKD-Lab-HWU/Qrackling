classdef wavelength
    properties (SetAccess = protected)
        Start
        Stop
    end
    methods
        function wvl = wavelength(start, stop)
            arguments
                start {mustBeNumeric}
                stop {mustBeNumeric}
            end
            wvl.Start = start;
            wvl.Stop = stop;
        end
    end
end
