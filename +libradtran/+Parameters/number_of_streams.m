classdef number_of_streams
    properties (SetAccess = protected)
        Value
    end
    methods
        function num = number_of_streams(value)
            arguments
                value {mustBeNumeric}
            end
            num.Value = value;
        end
    end
end
