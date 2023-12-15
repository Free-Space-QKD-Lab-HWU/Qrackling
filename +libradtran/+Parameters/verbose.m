classdef verbose
    properties (SetAccess = protected)
        Tag = libradtran.TagEnum.IsCondition
        State matlab.lang.OnOffSwitchState
    end
    methods
        function v = verbose(state)
            arguments
                state matlab.lang.OnOffSwitchState
            end
            v.State = state;
        end
    end
end
