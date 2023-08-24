classdef albedo
    properties (Access = protected)
        Value
    end

    methods
        function A = albedo(a)
            arguments
                a {mustBeNumeric, mustBeNonzero, mustBeLessThanOrEqual(a, 1)}
            end
            A.Value = a;
            disp(A.Value)
        end
    end
end
