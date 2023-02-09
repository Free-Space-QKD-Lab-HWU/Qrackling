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

    end
end
