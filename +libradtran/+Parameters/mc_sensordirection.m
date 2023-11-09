classdef mc_sensordirection
    properties (SetAccess = protected)
        X
        Y
        Z
    end
    methods
        function mc = mc_sensordirection(x, y, z)
            arguments
                x {mustBeNumeric}
                y {mustBeNumeric}
                z {mustBeNumeric}
            end
            mc.X = x;
            mc.Y = y;
            mc.Z = z;
        end
    end
end
