classdef aerosol_default
    properties
        Tag = libradtran.TagEnum.IsCondition
        Value matlab.lang.OnOffSwitchState
    end

    methods
        function default = aerosol_default(state)
            arguments
                state matlab.lang.OnOffSwitchState = matlab.lang.OnOffSwitchState.off
            end
            default.Value = state;
        end
    end
end
