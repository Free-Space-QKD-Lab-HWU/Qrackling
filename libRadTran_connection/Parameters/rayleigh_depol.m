classdef rayleigh_depol
    properties (SetAccess = protected)
        Value
    end
    methods
        function r = rayleigh_depol(value)
            arguments
                value {mustBeNumeric}
            end
            r.Value = value;
        end
    end
end
