classdef pressure_out
    properties (SetAccess = protected)
        Value
    end
    methods
        function p = pressure_out(value)
            arguments
                value {mustBeNumeric}
            end
            p.Value = value;
        end
    end
end
