classdef mc_backward_increment
    properties (SetAccess = protected)
        Step_X
        Step_Y
    end
    methods
        function mc = mc_backward_increment(X, Y)
            arguments
                X {mustBeNumeric}
                Y {mustBeNumeric}
            end
            mc.Step_X = X;
            mc.Step_Y = Y;
        end
    end
end
