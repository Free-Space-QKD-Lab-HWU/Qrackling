classdef reverse_atmosphere
    properties (SetAccess = protected)
        Tag = TagEnum.IsCondition
        State matlab.lang.OnOffSwitchState
    end
    methods
        function atm = reverse_atmosphere(state)
            arguments
                state matlab.lang.OnOffSwitchState
            end
            atm.State = state;
        end
    end
end
