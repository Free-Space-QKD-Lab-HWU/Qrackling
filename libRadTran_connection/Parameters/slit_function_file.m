classdef slit_function_file
    properties (SetAccess = protected)
        File
    end
    methods
        function slit = slit_function_file(file)
            arguments
                file {mustBeFile}
            end
            slit.File = file;
        end
    end
end
