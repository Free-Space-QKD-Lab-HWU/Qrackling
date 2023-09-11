classdef deltam
    properties (SetAccess = protected)
        State matlab.lang.OnOffSwitchState
    end
    methods
        function d = deltam(state)
            arguments
                state matlab.lang.OnOffSwitchState;
            end
            d.State = state;
        end
    end
end
