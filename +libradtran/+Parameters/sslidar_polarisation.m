classdef sslidar_polarisation
    properties (SetAccess = protected)
        Tag = libradtran.TagEnum.IsCondition
        State matlab.lang.OnOffSwitchState
    end
    methods
        function s = sslidar_polarisation(state)
            arguments
                state matlab.lang.OnOffSwitchState
            end
            s.State = state;
        end
    end
end
