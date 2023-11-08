classdef isotropic_source_toa
    properties (SetAccess = protected)
        Tag TagEnum = TagEnum.IsCondition
        state matlab.lang.OnOffSwitchState
    end
    methods
        function iso = isotropic_source_toa(state)
            arguments
                state matlab.lang.OnOffSwitchState
            end
            iso.state = state;
        end
    end
end
