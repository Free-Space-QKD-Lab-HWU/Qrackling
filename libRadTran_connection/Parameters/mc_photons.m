classdef mc_photons
    properties (SetAccess = protected)
        Value
    end
    methods
        function mc = mc_photons(value)
            arguments
                value {mustBeNumeric}
            end
            mc.Value = value;
        end
    end
end
