classdef bdrf_ambrals_file
    properties
        File {mustBeFile}
    end
    methods
        function ambrals_file = bdrf_ambrals_file(file)
            arguments
                file {mustBeFile}
            end
            ambrals_file.File = file;
        end
    end
end
