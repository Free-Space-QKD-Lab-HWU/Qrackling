classdef aerosol_season
    enumeration
        Spring_Summer ('Spring-summer profile'),
        Fall_Winter ('Fall-winter profile')
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
