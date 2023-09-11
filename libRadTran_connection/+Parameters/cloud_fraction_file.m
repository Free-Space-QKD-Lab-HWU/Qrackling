classdef cloud_fraction_file
    properties (SetAccess = protected)
        File {mustBeFile}
    end
    methods
        function cff = cloud_fraction_file(file)
            arguments
                file {mustBeFile}
            end
            cff.File = file;
        end
    end
end
