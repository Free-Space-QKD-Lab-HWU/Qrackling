classdef no_absorption
    properties (SetAccess = protected)
        Label
    end
    methods
        function absorption = no_absorption(label)
            arguments (Repeating)
                label {mustBeMember(label, {'mol', 'aer', 'wc', 'ic', 'profile'})}
            end
            absorption.Label = split(cellstr(label));
        end
    end
end
