classdef OptionResult
    properties(SetAccess=protected)
        Option = {};
        Labels = {};
        Tags = {};
        Enumerate {mustBeNumericOrLogical} = false;
        HasValue {mustBeNumericOrLogical} = false;
        UseLabel {mustBeNumericOrLogical} = false;
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
            addParameter(p, 'Tags', {});
            addParameter(p, 'UseLabel', false);
            parse(p, Options, varargin{:});

            OptionResult.Option = Options;
            %OptionResult.Result = {};
            OptionResult.Enumerate = p.Results.Enumerate;
            OptionResult.Labels = Options;
            OptionResult.UseLabel = p.Results.UseLabel;
            OptionResult.Tags = p.Results.Tags;

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

        function V = ToVariable(OptionResult, choice)
            % Unpleasant control flow but it works

            choiceInOptions = @(OR, C) cellfun(@(O) strcmp(O, C), OR.Option);
            choiceArray = choiceInOptions(OptionResult, choice);
            choiceIndex = find(choiceArray == true);

            if isempty(OptionResult.Tags)
                V = Variable(TagEnum.IsValue);
            else
                V = Variable(OptionResult.Tags{choiceIndex});
                if OptionResult.UseLabel == true
                    V = V.setName(choice);
                end
                return
            end

            if isnumeric(choice)
                if OptionResult.Enumerate == true
                    if numel(OptionResult.Option) <= choice
                        V.Value = choice;
                    else
                        error('Choice out of enumerated range');
                    end
                else
                    V.Value = OptionResult.Option{choice};
                end
            else
                if sum(choiceArray) > 0
                    choiceString = OptionResult.Option{choiceIndex};
                else
                    error([...
                        'Choice not contained in Options, available:', ...
                        newline, strjoin(OptionResult.Option, [newline, char(9)]) ...
                        ]);
                end
                if OptionResult.Enumerate == true
                    V.Value = choiceIndex;
                else
                    V.Value = OptionResult.Option{choiceIndex};
                end
            end

        end


    end
end
