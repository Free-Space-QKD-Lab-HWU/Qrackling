classdef aerosol_visibility
    properties (SetAccess = protected)
        Value
    end
    methods
        function visibility = aerosol_visibility(Vis)
            visibility.Value = Vis;
        end
    end
end
