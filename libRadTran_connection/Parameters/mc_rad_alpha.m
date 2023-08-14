classdef mc_rad_alpha
    properties (SetAccess = protected)
        Tag = TagEnum.IsCondition
        State matlab.lang.OnOffSwitchState
    end
    methods
        function mc = mc_rad_alpha(state)
            arguments
                state matlab.lang.OnOffSwitchState
            end
            mc.State = state;
        end
    end
end
