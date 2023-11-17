classdef bdrf_ambrals_hotspot
    properties (SetAccess = protected)
        Tag = libradtran.TagEnum.IsValue
        on {mustBeNumericOrLogical}
    end
    methods
        function hotspot = bdrf_ambrals_hotspot(state)
            arguments
                state {mustBeNumericOrLogical}
            end
            hotspot.on = state;
    end
    end
end
