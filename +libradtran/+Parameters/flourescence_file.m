classdef flourescence_file
    properties (SetAccess = protected)
        File
    end
    methods
        function f = flourescence_file(file)
            arguments
                file {mustBeFile}
            end
            f.File = file;
        end
    end
end
