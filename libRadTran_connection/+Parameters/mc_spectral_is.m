classdef mc_spectral_is
    properties (SetAccess = protected)
        Value
    end
    methods
        function mc = mc_spectral_is(value)
            arguments
                value {mustBeNumeric}
            end
            mc.Value = value;
        end
    end
end
