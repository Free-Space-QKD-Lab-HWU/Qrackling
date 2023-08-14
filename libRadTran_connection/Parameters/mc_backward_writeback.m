classdef mc_backward_writeback
    properties
        Tag TagEnum = TagEnum.IsValue
        on {mustBeNumericOrLogical} = false
    end
    methods
        function mc = mc_backward_writeback(state)
            arguments
                state {mustBeNumericOrLogical}
            end
            mc.on = state;
        end
    end
end
