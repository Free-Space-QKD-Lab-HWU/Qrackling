classdef no_scattering
    properties (SetAccess = protected)
        Label
    end
    methods
        function scattering = no_scattering(label)
            arguments (Repeating)
                label {mustBeMember(label, {'mol', 'aer', 'wc', 'ic', 'profile'})}
            end
            scattering.Label = split(cellstr(label));
        end
    end
end
