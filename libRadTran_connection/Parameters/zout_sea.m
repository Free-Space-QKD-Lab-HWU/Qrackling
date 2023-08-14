classdef zout_sea
    properties (SetAccess = protected)
        Value
    end
    methods
        function z = zout_sea(value)
            arguments
                value {mustBeNumeric}
            end
            z.Value = sort(value);
        end
    end
end
