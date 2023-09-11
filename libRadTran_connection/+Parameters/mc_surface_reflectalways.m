classdef mc_surface_reflectalways
    properties (SetAccess = protected)
        Tag = TagEnum.IsCondition
        State matlab.lang.OnOffSwitchState
    end
    methods
        function mc = mc_surface_reflectalways(state)
            arguments
                state matlab.lang.OnOffSwitchState
            end
            mc.State = state;
        end
    end
end
