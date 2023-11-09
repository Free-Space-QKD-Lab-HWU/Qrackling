classdef aerosol_haze
    properties (SetAccess = protected)
        Label
    end

    methods
        function haze = aerosol_haze(model)
            arguments
                model {mustBeMember(model, {'Rural', 'Maritime', 'Urban', 'Tropospheric'})}
            end
            haze.Label = model;
        end
    end

end
