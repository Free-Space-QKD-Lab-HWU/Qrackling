classdef output_quantity
    properties (SetAccess = protected)
        Label
    end
    methods
        function out = output_quantity(label)
            arguments
                label {mustBeMember(label, {'brightness', 'reflectivity', ...
                    'transmittance'})}
            end
            out.Label = label;
        end
    end
end
