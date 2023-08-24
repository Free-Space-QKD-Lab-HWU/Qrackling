classdef z_interpolate
    properties (SetAccess = protected)
        Tag = TagEnum.IsCondition
        State matlab.lang.OnOffSwitchState
    end
    methods
        function z = z_interpolate(state)
            arguments
                state matlab.lang.OnOffSwitchState
            end
            z.State = state;
        end
    end
end
