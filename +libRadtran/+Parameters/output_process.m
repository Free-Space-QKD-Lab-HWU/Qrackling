classdef output_process
    properties (SetAccess = protected)
        Label
    end
    methods
        function out = output_process(label)
            arguments
                label {mustBeMember(label, {'sum', 'integrate', 'per_nm', ...
                    'per_cm-1', 'per_band', 'none'})}
            end
            out.Label = label;
        end
    end
end
