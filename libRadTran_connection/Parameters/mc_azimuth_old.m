classdef mc_azimuth_old
    properties
        Tag TagEnum = TagEnum.IsValue
        on {mustBeNumericOrLogical} = false
    end
    methods

        function mc_old = mc_azimuth_old(state)
            arguments
                state {mustBeNumericOrLogical}
            end
            mc_old.on = state;
    end
end
