classdef mc_escape
    properties
        State matlab.lang.OnOffSwitchState
    end
    methods
        function mc = mc_escape(state)
            arguments
                state matlab.lang.OnOffSwitchState
            end
            mc.State = state;
        end
    end
end
