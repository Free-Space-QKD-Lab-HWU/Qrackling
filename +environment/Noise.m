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

        function total = Total(NoiseArray)
            %% return the total of an array of noise objects

            %prepare memory for total
            total = NoiseArray(1).values;
            if isscalar(NoiseArray)
                return
            end

            %iterate over remaining entries
            for current_noise = NoiseArray(2:end)
                total = total + current_noise.values;
            end
        end
    end
end
