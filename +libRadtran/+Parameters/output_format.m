classdef output_format
    properties (SetAccess = protected)
        Label
    end
    methods
        function out = output_format(label)
            arguments
                label {mustBeMember(label, {'ascii', 'flexstor'})}
            end
            out.Label = label;
        end
    end
end
