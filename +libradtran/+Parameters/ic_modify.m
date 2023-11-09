classdef ic_modify
    properties (SetAccess = protected)
        Variable
        Type
        Value
    end
    methods
        function ec = ec_modify(variable, type, value)
            arguments (Repeating)
                variable {mustBeMember(variable, {'gg', 'ssa', 'tau', 'tau550'})}
                type {mustBeMember(type, {'set', 'scale'})}
                value {mustBeNumeric}
            end
            assert( ...
                (numel(variable) == numel(type)) ...
                == (numel(variable) == numel(value)), ...
                'Must supply equal number of variable, type and value arguments');
            ec.Variable = variable;
            ec.Type = type;
            ec.Value = value;
        end
    end
end
