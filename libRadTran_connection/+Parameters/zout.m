classdef zout
    properties (SetAccess = protected)
        Value
    end
    methods
        function z = zout(value)
            arguments
                value {mustBeNumeric}
            end
            z.Value = sort(value);
        end
    end
end
