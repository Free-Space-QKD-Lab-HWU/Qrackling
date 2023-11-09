classdef bdrf_rpv
    properties (SetAccess = protected)
        Variable
        Value
    end
    methods
        function rpv = bdrf_rpv(var, val)
            arguments
                var {mustBeMember(var, ...
                    {'k', 'rho0', 'theta', 'sigma', 't1', 't2', 'scale'})}
                val {mustBeNumeric}
            end
            rpv.Variable = var;
            rpv.Variable = val;
        end
    end
end
