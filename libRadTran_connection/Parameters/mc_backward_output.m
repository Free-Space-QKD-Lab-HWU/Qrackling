classdef mc_backward_output
    properties (SetAccess = protected)
        Label = ''
    end
    methods
        function outputs = mc_backward_output(label, options)
            arguments (Repeating)
                label {mustBeMember(label, {'edir', 'edn',  'eup', 'exp', ...
                    'exn', 'eyp', 'eyn', 'act'})}
            end
            arguments
                options.Absorption {mustBeMember(options.Absorption, { ...
                    'W_per_m2_and_dz', 'W_per_m3', 'K_per_day'})}
                options.Emission {mustBeMember(options.Emission, { ...
                    'W_per_m2_and_dz', 'W_per_m3', 'K_per_day'})}
                options.Heating {mustBeMember(options.Heating, { ...
                    'W_per_m2_and_dz', 'W_per_m3', 'K_per_day'})}
            end
            outputs.Label = strjoin(unique(cellstr(label)), " ");
            if numel(fieldnames(options)) > 0
                for f = fieldnames(options)
                    switch f{1}
                        case "Absorption"
                            outputs.Label = strjoin([outputs.Label, 'abs', options.(f{1})]);
                        case "Emission"
                            outputs.Label = strjoin([outputs.Label, 'emis', options.(f{1})]);
                        case "Heating"
                            outputs.Label = strjoin([outputs.Label, 'heat', options.(f{1})]);
                    end
                end
            end
        end

        % function outputs = Absorption(outputs, absorption)
        %     arguments
        %         outputs mc_backward_output
        %         absorption {mustBeMember(absorption, { ...
        %             'W_per_m2_and_dz', 'W_per_m3', 'K_per_day'})}
        %     end
        %     outputs.Label = strjoin([outputs.Label, 'abs', absorption], ' ');
        % end

        % function outputs = Emission(outputs, emission)
        %     arguments
        %         outputs mc_backward_output
        %         emission {mustBeMember(emission, { ...
        %             'W_per_m2_and_dz', 'W_per_m3', 'K_per_day'})}
        %     end
        %     outputs.Label = strjoin([outputs.Label, 'emis', emission], ' ');
        % end

        % function outputs = Heating(outputs, heating)
        %     arguments
        %         outputs mc_backward_output
        %         heating {mustBeMember(heating, { ...
        %             'W_per_m2_and_dz', 'W_per_m3', 'K_per_day'})}
        %     end
        %     outputs.Label = strjoin([outputs.Label, 'emis', heating], ' ');
        % end

    end
end
