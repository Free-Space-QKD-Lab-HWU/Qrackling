classdef Noise
    % Noise
    %
    % A class describing sources of extra photons or detections from
    % outside the channel.
    %
    % Syntax:
    % noise_obj = Noise(label, values)
    %
    % Provide a label and numeric values representing the noise contribution.

    %% Properties
    properties
        % A descriptive label for this noise source
        label {mustBeText}

        % Numeric array of noise values
        values {mustBeNumeric}
    end

    %% Public methods
    methods
        function noise = Noise(label, values)
            % Noise
            %
            % Construct a Noise object.
            %
            % Syntax:
            % noise = Noise(label, values)
            %
            % Inputs:
            % label  - text
            % values - numeric array
            %
            % Outputs:
            % noise – (1x1) Noise

            arguments
                label {mustBeText} = ''
                values {mustBeNumeric} = []
            end

            noise.label = label;
            noise.values = values;
        end

        function total = total(noise_array)
            % total
            %
            % Return the total (sum) of an array of Noise objects' values.
            %
            % Syntax:
            % total = total(noise_array)
            %
            % Inputs:
            % noise_array - array of Noise objects (non-empty)
            %
            % Outputs:
            % total – numeric array, sum across noise_array(:).values

            arguments
                noise_array Noise
            end

            % Prepare initial total from the first element
            total = noise_array(1).values;
            if isscalar(noise_array)
                return
            end

            % Iterate over remaining entries
            for current_noise = noise_array(2:end)
                total = total + current_noise.values;
            end
        end
    end
end