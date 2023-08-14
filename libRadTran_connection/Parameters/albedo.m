classdef albedo
    properties (Access = protected)
        Value {mustBeNumeric, mustBeNonzero, mustBeLessThanOrEqual(Value, 1)}
    end

    methods
        function A = albedo(a)
            arguments
                a {mustBeNumeric, mustBeNonzero, mustBeLessThanOrEqual(a, 1)}
            end
            A.Value = a;
        end
    end
end
