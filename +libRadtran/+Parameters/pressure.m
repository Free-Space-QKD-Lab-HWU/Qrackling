classdef pressure
    properties (SetAccess = protected)
        Value
    end
    methods
        function p = pressure(value)
            arguments
                value {mustBeNumeric}
            end
            p.Value = value;
        end
    end
end
