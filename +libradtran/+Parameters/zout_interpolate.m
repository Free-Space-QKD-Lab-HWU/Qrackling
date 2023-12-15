classdef zout_interpolate
    properties (SetAccess = protected)
        Tag = libradtran.TagEnum.IsCondition
        State matlab.lang.OnOffSwitchState
    end
    methods
        function z = zout_interpolate(state)
            arguments
                state matlab.lang.OnOffSwitchState
            end
            z = state;
        end
    end
end
