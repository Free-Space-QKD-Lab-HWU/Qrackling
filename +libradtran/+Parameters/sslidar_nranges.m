classdef sslidar_nranges
    properties (SetAccess = protected)
        Value
    end
    methods
        function s = sslidar_nranges(value)
            arguments
                value {mustBeNumeric}
            end
            s.Value = value;
        end
    end
end
