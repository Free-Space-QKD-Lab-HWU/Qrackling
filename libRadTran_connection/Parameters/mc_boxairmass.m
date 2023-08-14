classdef mc_boxairmass
    properties
        Tag TagEnum = TagEnum.IsValue
        on {mustBeNumericOrLogical} = false
    end
    methods
        function mc = mc_boxairmass(varargin)
            arguments
                state {mustBeNumericOrLogical}
            end
            mc.on = state;
        end
    end
end
