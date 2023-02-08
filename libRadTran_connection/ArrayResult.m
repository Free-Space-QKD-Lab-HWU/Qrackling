classdef ArrayResult
    properties(SetAccess=protected)
        N = 0;
        Labels = {};
    end

    methods
        function ArrayResult = ArrayResult(varargin)
            p = inputParser;
            addParameter(p, 'N', 0);
            addParameter(p, 'Labels', {});
            parse(p, varargin{:});

            assert(p.Results.N > 0 | numel(p.Results.Labels) > 0, ...
                'Either N or Labels must be set');

            N = p.Results.N;
            if N == 0
                N = numel(p.Results.Labels);
            end

            ArrayResult.N = N;
            ArrayResult.Labels = p.Results.Labels;
        end
    end
end
