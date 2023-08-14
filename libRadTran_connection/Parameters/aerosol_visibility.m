classdef aerosol_visibility
    properties (Access = protected)
        Value {mustBeNumeric}
    end
    methods
        function visibility = aerosol_visibility(Vis)
            visibility.Value = Vis;
        end
    end
end
