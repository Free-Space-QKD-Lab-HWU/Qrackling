classdef quiet
    properties (SetAccess = protected)
        Tag = libradtran.TagEnum.IsCondition
        State matlab.lang.OnOffSwitchState
    end
    methods
        function q = quiet(state)
            arguments
                state matlab.lang.OnOffSwitchState
            end
            q.State = state;
        end
    end
end
