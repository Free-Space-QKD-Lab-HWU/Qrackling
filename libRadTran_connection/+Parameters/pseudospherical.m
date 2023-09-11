classdef pseudospherical
    properties (SetAccess = protected)
        Tag = TagEnum.IsCondition
        State matlab.lang.OnOffSwitchState
    end
    methods
        function p = pseudospherical(state)
            arguments
                state matlab.lang.OnOffSwitchState
            end
            p.State = state;
        end
    end
end
