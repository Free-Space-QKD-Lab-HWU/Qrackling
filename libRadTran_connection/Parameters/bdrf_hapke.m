classdef bdrf_hapke
    properties (SetAccess = protected)
        Variable
        Value
    end
    methods
        function hapke = bdrf_hapke(var, val)
            arguments
                var {mustBeMember(var, {'w', 'B0', 'h'})}
                val {mustBeNumeric}
            end
            hapke.Variable = var;
            hapke.Value = val;
        end
    end
end
