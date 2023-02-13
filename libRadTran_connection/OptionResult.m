classdef OptionResult
    properties(SetAccess=protected)
        Option = {};
        Labels = {};
        Enumerate {mustBeNumericOrLogical} = false;
        HasValue {mustBeNumericOrLogical} = false;
    end

    properties
        Result;
        Value;
    end

    methods
        % this should have a setResult function that returns a new Variable 
        % with a TagEnum that isnt IsOptionResult that can be used for scripting
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

        function variable = SetValue(OptionResult, option)

            if isnumeric(option)
                choice = OptionResult.Option{option};
            elseif sum(contains(OptionResult.Option, option)) > 0
                choice = option;
            else
                error('Chosen option not present in Options');
            end

            variable = Variable(TagEnum.IsCondition, Parent=OptionResult.Parent);
            variable = variable.setName(option.Name);

            if OptionResult.Enumerate == true
                if ~isnumeric(choice)
                    enumed = find(cellfun(@(o) strcmp(o, choice), OptionResult.Option) == true);
                    OptionResult.Result = enumed;
                    variable.Value = enumed;
                    return
                end
                OptionResult.Result = choice;
                variable.Value = choice;
                return
            else
                if isnumeric(choice)
                    enumed = find(cellfun(@(o) strcmp(o, choice), OptionResult.Option) == true);
                    OptionResult.Result = OptionResult.Option{enumed};
                    variable.Value = enumed;
                    return
                end
                OptionResult.Result = choice;
                variable.Value = choice;
                return
            end

        end


    end
end
