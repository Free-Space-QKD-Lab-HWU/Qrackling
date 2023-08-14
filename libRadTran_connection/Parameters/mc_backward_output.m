classdef mc_backward_output
    properties (SetAccess = protected)
        Label = ''
    end
    methods
        function outputs = mc_backward_output(label)
            arguments (Repeating)
                label {mustBeMember(label, {'edir', 'edn',  'eup', 'exp', ...
                    'exn', 'eyp', 'eyn', 'act'})}
            end
            outputs.Label = strjoin(unique(cellstr(label)), " ");
        end

        function outputs = Absorption(outputs, absorption)
            arguments
                outputs mc_backward_output
                absorption {mustBeMember(absorption, { ...
                    'W_per_m2_and_dz', 'W_per_m3', 'K_per_day'})}
            end
            outputs.Label = strjoin([outputs.Label, 'abs', absorption], ' ');
        end

        function outputs = Emission(outputs, emission)
            arguments
                outputs mc_backward_output
                emission {mustBeMember(emission, { ...
                    'W_per_m2_and_dz', 'W_per_m3', 'K_per_day'})}
            end
            outputs.Label = strjoin([outputs.Label, 'emis', emission], ' ');
        end

        function outputs = Heating(outputs, heating)
            arguments
                outputs mc_backward_output
                heating {mustBeMember(heating, { ...
                    'W_per_m2_and_dz', 'W_per_m3', 'K_per_day'})}
            end
            outputs.Label = strjoin([outputs.Label, 'emis', heating], ' ');
        end

    end
end
