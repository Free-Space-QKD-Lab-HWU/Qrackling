classdef thermal_bands_file
    properties (SetAccess = protected)
        File
    end
    methods
        function t = thermal_bands_file(file)
            arguments
                file {mustBeFile}
            end
            t.File = file;
        end
    end
end
