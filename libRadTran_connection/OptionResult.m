classdef OptionResult
    properties(SetAccess=protected)
        Option = {};
        Labels = {};
        Enumerate {mustBeNumericOrLogical} = false;
        HasValue {mustBeNumericOrLogical} = false;
    end

    properties
        Result;
    end

    methods
        function OptionResult = OptionResult(Options, varargin)
            p = inputParser;
            addRequired(p, 'Options');
            addParameter(p, 'Enumerate', false);
            addParameter(p, 'Labels', {});
            addParameter(p, 'HasValue', false);
            parse(p, Options, varargin{:});

            OptionResult.Option = Options;
            %OptionResult.Result = {};
            OptionResult.Enumerate = p.Results.Enumerate;
            OptionResult.Labels = Options;

            if ~isempty(p.Results.Labels)
                OptionResult.Labels = p.Results.Labels;
            end
            OptionResult.HasValue = p.Results.HasValue;
        end
    end
end
