classdef bdrf_cam_solar_wind
    properties (SetAccess = protected)
        state matlab.lang.OnOffSwitchState
    end
    methods
        function cam_solar_wind = bdrf_cam_solar_wind(state)
            arguments
                state matlab.lang.OnOffSwitchState
            end
            cam_solar_wind.state = state;
        end
    end
end
