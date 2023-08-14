classdef bdrf_cam_solar_wind?????
    properties (SetAccess = protected)
        Variable
        Value
    end
    methods
        function cam_solar_wind = bdrf_cam_solar_wind(var, val)
            arguments
                var {mustBeMember(var, {})}
            end
        end
    end
end
