classdef sslidar
    properties (SetAccess = protected)
        Variable
        Value
    end
    methods
        function s = sslidar(variable, value)
            arguments
                variable {mustBeMember(variable, {'area', 'E0', 'eff', ...
                    'position', 'range'})}
                value {mustBeNumeric}
            end
            s.Variable = variable;
            s.Value = value;
        end
    end
end
