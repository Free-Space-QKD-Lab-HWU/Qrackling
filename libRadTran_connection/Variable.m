classdef Variable
    properties(SetAccess=protected)
        Tag TagEnum;
        Parent = '';
        Name = '';
    end

    properties
        Value;
    end

    methods

        % want a function in here that allows returning a new Variable if the 
        % tag is TagEnum.OptionResult, with the choice set and the correct new
        % tag set (probably Isvalue or IsCondition depending on if its numeric
        % or a string).

        function Variable = Variable(Tag, varargin)
            p = inputParser;
            addRequired(p, 'Tag');
            addParameter(p, 'Value', {});
            addParameter(p, 'Parent', '');
            parse(p, Tag, varargin{:});

            assert(isa(p.Results.Tag, 'TagEnum'), 'Must be a "TagEnum"');
            Variable.Tag = p.Results.Tag;
            Variable.Value = p.Results.Value;
            Variable.Parent = p.Results.Parent;
        end

        function Variable = setParent(Variable, Parent)
            Variable.Parent = Parent;
        end

        function Variable = setName(Variable, Name)
            Variable.Name = Name;
        end

        function opts = Options(Variable)
            if ~isa(Variable.Value, 'OptionResult')
                error('No options for this variable');
            end
            opts = Variable.Value.Option;
        end

        function V = OptionResultToVariable(Variable, choice)
            if ~isa(Variable.Value, 'OptionResult')
                V = Variable;
                return
            end
            V = Variable.Value.ToVariable(choice);
            if isempty(V.Name)
                V = V.setName(Variable.Name);
            end
            V = V.setParent(Variable.Parent);
        end

    end
end
