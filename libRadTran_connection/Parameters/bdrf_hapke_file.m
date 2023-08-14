classdef bdrf_hapke_file
    properties
        File {mustBeFile}
    end
    methods
        function hapke_file = bdrf_hapke_file(file)
            arguments
                file {mustBeFile}
            end
            hapke_file.File = file;
        end
    end
end
