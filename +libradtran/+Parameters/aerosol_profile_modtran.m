classdef aerosol_profile_modtran
    properties (SetAccess = protected)
        Tag = libradtran.TagEnum.IsValue
        on matlab.lang.OnOffSwitchState
    end

    methods
        function profile = aerosol_profile_modtran(state)
            arguments
                state matlab.lang.OnOffSwitchState = 'off'
            end
            profile.on = state;
        end
    end
end
