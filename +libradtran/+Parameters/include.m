classdef include
    properties (SetAccess = protected)
        File
    end
    methods
        function inc = include(file)
            arguments
                file {mustBeFile}
            end
            inc.File = file;
        end
    end
end
