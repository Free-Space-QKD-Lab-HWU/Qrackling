classdef bdrf_rpv_file
    properties
        File {mustBeFile}
    end
    methods
        function rpv_file = bdrf_rpv_file(file)
            arguments
                file {mustBeFile}
            end
            rpv_file.File = file;
        end
    end
end
