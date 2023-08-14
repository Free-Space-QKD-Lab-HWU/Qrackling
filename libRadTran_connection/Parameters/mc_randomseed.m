classdef mc_randomseed
    properties (SetAccess = protected)
        Value
    end
    methods
        function mc = mc_randomseed(value)
            arguments
                value {mustBeNumeric}
            end
        end
    end
end
