classdef aerosol_season
    enumeration
        Spring_Summer (1),
        Fall_Winter (2)
    end

    properties
        Label
    end

    methods
        function season = aerosol_season(model)
            season.Label = model;
        end
    end

end
