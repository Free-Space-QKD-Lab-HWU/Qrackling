classdef output_file
    properties (SetAccess = protected)
        File
    end
    methods
        function out = output_file(file)
            arguments
                file {mustBeFile}
            end
            out.File = file;
        end
    end
end
