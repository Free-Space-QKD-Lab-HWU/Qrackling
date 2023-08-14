classdef thermal_bandwidth
    properties (SetAccess = protected)
        Value
    end
    methods
        function t = thermal_bandwidth(value)
            arguments
                value {mustBeNumeric}
            end
            t.Value = value;
        end
    end
end
