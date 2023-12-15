classdef mc_maxscatters
    properties
        State matlab.lang.OnOffSwitchState
    end
    methods
        function mc = mc_maxscatters(state)
            arguments
                state matlab.lang.OnOffSwitchState
            end
            mc.State = state;
        end
    end
end
