classdef cloudcover
    properties
        Variable
        Value
    end
    methods
        function c = cloudcover(var, val)
            arguments
                var {mustBeMember(var, {'ic', 'wc'})}
                val {mustBeNumeric}
            end
            c.Variable = var;
            c.Value = val;
        end
    end
end
