classdef sza
    properties (SetAccess = protected)
        Value
    end
    methods
        function s = sza(value)
            arguments
                value {mustBeNumeric}
            end
            s.Value = value;
        end
    end
end
