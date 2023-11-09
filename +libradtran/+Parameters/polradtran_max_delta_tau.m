classdef polradtran_max_delta_tau
    properties (SetAccess = protected)
        Value
    end
    methods
        function pol = polradtran_max_delta_tau(value)
            arguments
                value {mustBeNumeric}
            end
            pol.Value = value;
        end
    end
end
