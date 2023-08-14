classdef wc_modify
    properties (SetAccess = protected)
        Variable
        Type
        Value
    end
    methods
        function wc = wc_modify(variable, type, value)
            arguments (Repeating)
                variable {mustBeMember(variable, {'gg', 'ssa', 'tau', 'tau550'})}
                type {mustBeMember(type, {'set', 'scale'})}
                value {mustBeNumeric}
            end
            assert( ...
                (numel(variable) == numel(type)) ...
                == (numel(variable) == numel(value)), ...
                'Must supply equal number of variable, type and value arguments');
            wc.Variable = variable;
            wc.Type = type;
            wc.Value = value;
        end
    end
end
