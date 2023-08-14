classdef refractive_index_pv
    properties (SetAccess = protected)
        Value
    end
    methods
        function n = refractive_index_pv(value)
            arguments
                value {mustBeNumeric}
            end
            n.Value = value;
        end
    end
end
