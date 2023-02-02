classdef Variable
    properties(SetAccess=protected)
        Tag TagEnum;
    end

    properties
        Value;
    end

    methods
        function Variable = Variable(Tag, varargin)
            p = inputParser;
            addRequired(p, 'Tag');
            addParameter(p, 'Value', {});
            parse(p, Tag, varargin{:});

            assert(isa(p.Results.Tag, 'TagEnum'), 'Must be a "TagEnum"');
            Variable.Tag = p.Results.Tag;
            Variable.Value = p.Results.Value;
        end
    end
end
