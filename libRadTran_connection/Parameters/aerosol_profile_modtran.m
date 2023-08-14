classdef aerosol_profile_modtran
    properties
        Tag TagEnum = TagEnum.IsValue
        on {mustBeNumericOrLogical} = false
    end

    methods
        function profile = aerosol_profile_modtran(state)
            arguments
                state {mustBeNumericOrLogical}
            end
            profile.on = state;
        end
    end
end
