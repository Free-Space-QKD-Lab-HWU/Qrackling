classdef mc_photons_file
    properties (SetAccess = protected)
        File
    end
    methods
        function mc = mc_photons_file(file)
            arguments
                file {mustBeFile}
            end
            mc.File = file;
        end
    end
end
