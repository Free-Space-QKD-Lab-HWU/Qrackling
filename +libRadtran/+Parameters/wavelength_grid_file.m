classdef wavelength_grid_file
    properties (SetAccess = protected)
        File
    end
    methods
        function wvl = wavelength_grid_file(file)
            arguments
                file {mustBeFile}
            end
            wvl.File = file;
        end
    end
end
