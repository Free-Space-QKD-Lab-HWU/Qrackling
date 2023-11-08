classdef albedo
    properties (SetAccess = protected)
        Value
    end

    methods
        function A = albedo(a)
            arguments
                a {mustBeNumeric, mustBeNonzero, mustBeLessThanOrEqual(a, 1)}
            end
            A.Value = num2str(a);
        end
    end
end
