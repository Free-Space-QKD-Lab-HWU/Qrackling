classdef umu
    properties (SetAccess = protected)
        Value
    end
    methods
        function u = umu(value)
            arguments
                value {mustBeNumeric}
            end
            u.Value = value;
        end
    end
end
