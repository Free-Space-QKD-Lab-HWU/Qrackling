classdef mc_boxairmass
    properties
        Tag = libradtran.TagEnum.IsValue
        state {mustBeNumericOrLogical} = false
    end
    methods
        function mc = mc_boxairmass(state)
            arguments
                state {mustBeNumericOrLogical}
            end
            mc.state = state;
        end
    end
end
