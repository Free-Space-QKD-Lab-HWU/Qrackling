classdef mc_minphotons
    properties
        Value
    end
    methods
        function mc = mc_minphotons(value)
            arguments
                value {mustBeNumeric}
            end
            mc.Value = value;
        end
    end
end
