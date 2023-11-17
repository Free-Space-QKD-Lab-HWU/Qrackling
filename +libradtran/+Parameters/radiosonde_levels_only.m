classdef radiosonde_levels_only
    properties
        Tag = libradtran.TagEnum.IsCondition
        State matlab.lang.OnOffSwitchState
    end
    methods
        function radio = radiosonde_levels_only(state)
            arguments
                state matlab.lang.OnOffSwitchState
            end
            radio.State = state;
        end
    end
end
