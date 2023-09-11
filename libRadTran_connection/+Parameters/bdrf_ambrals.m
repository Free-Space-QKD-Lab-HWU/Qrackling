classdef bdrf_ambrals
    properties (SetAccess = protected)
        Variable {mustBeMember(Variable, {'iso', 'vol', 'geo'})}
        Value {mustBeNumeric}
    end

    methods
        function ambrals = bdrf_ambrals(var, val)
            arguments
                var {mustBeMember(var, {'iso', 'vol', 'geo'})}
                val {mustBeNumeric}
            end
            ambrals.Variable = var;
            ambrals.Value = val;
        end
    end
end

