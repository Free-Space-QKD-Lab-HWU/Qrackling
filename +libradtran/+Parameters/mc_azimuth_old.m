classdef mc_azimuth_old
    properties
        Tag TagEnum = TagEnum.IsValue
        state matlab.lang.OnOffSwitchState
    end
    methods

        function mc_old = mc_azimuth_old(state)
            arguments
                state matlab.lang.OnOffSwitchState = "off"
            end
            mc_old.state = state;
        end
    end
end
