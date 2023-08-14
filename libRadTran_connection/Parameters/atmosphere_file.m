classdef atmosphere_file

    properties
        Label
    end

    methods
        function atm_file = atmosphere_file(options)
            arguments
                options.Default {mustBeMember(options.Default, { ...
                    'tropics', 'midlatitude_summer', 'midlatitude_winter', ...
                    'subarctic_summer', 'subarctic_winter', 'US-standard' ...
                })}
                options.File {mustBeFile}
            end

            fields = fieldnames(options);
            assert(numel(fields) == 1, ...
                'Either option "Default" or option "File" must be set');

            if contains(fields, "Default")
                atm_file.Label = options.Default;
            end

            if contains(fields, "File")
                atm_file.Label = options.File;
            end

        end
    end
end

