classdef mc_nca
    properties (SetAccess = protected)
        Tag = libradtran.TagEnum.IsCondition
        State matlab.lang.OnOffSwitchState
    end
    methods
        function mc = mc_nca(state)
            arguments
                state matlab.lang.OnOffSwitchState
            end
            mc.State = state;
        end
    end
end
