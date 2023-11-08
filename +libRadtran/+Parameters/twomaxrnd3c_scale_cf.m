classdef twomaxrnd3c_scale_cf
    properties (SetAccess = protected)
        Value
    end
    methods
        function t = twomaxrnd3c_scale_cf(value)
            arguments
                value {mustBeNumeric}
            end
            t.Value = value;
        end
    end
end
