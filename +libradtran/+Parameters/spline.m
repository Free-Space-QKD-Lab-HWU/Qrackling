classdef spline
    properties (SetAccess = protected)
        Lambda_0
        Lambda_1
        Lambda_2
    end
    methods
        function s = spline(lambda_0, lambda_1, lambda_2)
            arguments
                lambda_0 {mustBeNumeric}
                lambda_1 {mustBeNumeric}
                lambda_2 {mustBeNumeric}
            end
            s.Lambda_0 = lambda_0;
            s.Lambda_1 = lambda_1;
            s.Lambda_2 = lambda_2;
        end
    end
end
