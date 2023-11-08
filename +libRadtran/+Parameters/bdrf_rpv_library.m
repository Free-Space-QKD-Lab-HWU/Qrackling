classdef bdrf_rpv_library
    properties (SetAccess = protected)
        Library
    end
    methods
        function rpv_lib = bdrf_rpv_library(options)
            arguments
                options.Library_Path {mustBeFolder}
                options.Default = false
            end

            fields = fieldnames(options);
            assert(numel(fields) == 1, ...
                'Either option "Default" or option "Library_Path" must be set');

            if contains(fields, "Library_Path")
                rpv_lib.Library = options.Library_Path;
                return
            end

            if contains(fields, "Default")
                rpv_lib.Library = options.Default;
                return
            end

        end
    end
end
