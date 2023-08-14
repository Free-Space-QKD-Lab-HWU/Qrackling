classdef atm_z_grid
    properties (SetAccess = protected)
        Levels {mustBeNonnegative, mustBeNonNan, mustBeNumeric, mustBeVector}
    end
    methods
        function grid = atm_z_grid(altitudes)
            grid.Levels = altitudes;
        end
    end
end
