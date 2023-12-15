classdef phi
    properties (SetAccess = protected)
        Value
    end
    methods
        function p = phi(value)
            arguments
                value {mustBeNumeric}
            end
            p.Value = num2str(value);
        end
    end
end
