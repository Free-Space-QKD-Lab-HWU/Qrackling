classdef mc_spherical
    properties (SetAccess = protected)
        Label
    end
    methods
        function mc = mc_spherical(label)
            arguments
                label {mustBeMember(label, {'1D'})}
            end
        mc.Label = label;
        end
    end
end
