classdef polradtran
    properties (SetAccess = protected)
        aziorder
        nstokes
        src_code
    end
    methods
        function pol = polradtran(options)
            arguments
                options.aziorder {mustBeNumeric}
                options.nstokes {mustBeNumeric, mustBeInteger, ...
                    mustBeInRange(options.nstokes, 1, 3)}
                options.src_code {mustBeNumeric, mustBeInteger, ...
                    mustBeInRange(options.src_code, 0, 3)}
            end
            for f = fieldnames(options)'
                pol.(f{1}) = options.(f{1});
            end
        end
    end
end
