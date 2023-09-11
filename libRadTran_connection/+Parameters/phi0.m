classdef phi0
    properties (SetAccess = protected)
        Value
    end
    methods
        function p = phi0(value)
            arguments
                value {mustBeNumeric}
            end
            p.Value = num2str(value);
        end
    end
end
