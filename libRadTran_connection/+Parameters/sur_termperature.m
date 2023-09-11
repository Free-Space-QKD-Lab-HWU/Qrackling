classdef sur_termperature
    properties (SetAccess = protected)
        Value
    end
    methods
        function temp = sur_termperature(value)
            arguments
                value {mustBeNumeric}
            end
            temp.Value = value;
        end
    end
end
