classdef aerosol_vulcan
    enumeration
        Background (1)
        Moderate_volcanic_aerosols (2)
        High_volcanic_aerosols (3)
        Extreme_volcanic_aerosols (4)
    end

    properties
        Value
    end

    methods
        function vulcan = aerosol_vulcan(Level)
            vulcan.Value = Level;
        end
    end
end
