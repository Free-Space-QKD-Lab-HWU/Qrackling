classdef mc_rad_alpha
    properties (SetAccess = protected)
        Value
    end
    methods
        function mc = mc_rad_alpha(value)
            arguments
                value {mustBeNumeric}
            end
            mc.Value = value;
        end
    end
end
