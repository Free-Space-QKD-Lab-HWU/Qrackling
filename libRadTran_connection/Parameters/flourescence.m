classdef flourescence
    properties (SetAccess = protected)
        Value
    end
    methods
        function f = flourescence(val)
            arguments
                val {mustBeNumeric, mustBePositive}
            end
            f.Value = val;
        end
    end
end

