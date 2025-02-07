classdef Noise
    properties (SetAccess = protected)
        label
        values
    end
    methods
        function noise = Noise(label, values)
            arguments
                label {mustBeText}
                values {mustBeNumeric}
            end
            noise.label = label;
            noise.values = values;
        end
    end
end
