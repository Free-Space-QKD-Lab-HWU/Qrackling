classdef sza_file
    properties (SetAccess = protected)
        File
    end
    methods
        function s = sza_file(file)
            arguments
                file {mustBeFile}
            end
            s.File = file;
        end
    end
end
