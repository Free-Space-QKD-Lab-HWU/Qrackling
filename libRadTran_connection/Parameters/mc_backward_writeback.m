classdef mc_backward_writeback
    properties
        Tag TagEnum = TagEnum.IsValue
        state {mustBeNumericOrLogical} = false
    end
    methods
        function mc = mc_backward_writeback(state)
            arguments
                state {mustBeNumericOrLogical}
            end
            mc.state = state;
        end
    end
end
