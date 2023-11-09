classdef interpret_as_level
    properties
        Label
    end
    methods
        function interpret = interpret_as_level(label)
            arguments
                label {mustBeMember(label, {'wc', 'ic'})}
            end
            interpret.Label = label;
        end
    end
end
