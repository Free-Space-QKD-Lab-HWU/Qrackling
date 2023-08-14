classdef reptran_file
    properties (SetAccess = protected)
        File
    end
    methods
        function r = reptran_file(file)
            arguments
                file {mustBeFile}
            end
            r.File = file;
        end
    end
end
