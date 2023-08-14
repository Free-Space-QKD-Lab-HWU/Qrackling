classdef surface_type_map
    properties (SetAccess = protected)
        File
    end
    methods
        function surf = surface_type_map(file)
            arguments
                file {mustBeFile}
            end
            surf.File = file;
        end
    end
end
