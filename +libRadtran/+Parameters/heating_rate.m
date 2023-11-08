classdef heating_rate
    properties
        Label
    end
    methods
        function h = heating_rate(label)
            arguments
                label {mustBeMember(label, {'layer_cd', 'local', 'layer_fd'})}
            end
            h.Label = label;
        end
    end
end
