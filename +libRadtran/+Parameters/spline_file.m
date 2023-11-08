classdef spline_file
    properties (SetAccess = protected)
        File
    end
    methods
        function s = spline_file(file)
            arguments
                file {mustBeFile}
            end
            s.File = file;
        end
    end
end
