classdef data_files_path
    properties (SetAccess = protected)
        Path
    end
    methods
        function fp = data_files_path(path)
            arguments
                path {mustBeFolder}
            end
            fp.Path = path;
        end
    end
end
