classdef proto
    properties (Abstract)
        source_features {mustBeMember(source_features, { ...
            'Wavelength',         'Repetition_Rate',  'Efficiency', ...
            'Mean_Photon_Number', 'State_Prep_Error', 'g2',         ...
            'State_Probabilities', 'Coincidence_Window' ...
            })}

        detector_features {mustBeMember(detector_features, { ...
            'Wavelength', 'QBER_Jitter', 'Time_Gate_Width', ...
            'Dead_Time', 'Dark_Count_Rate', 'Visibility', ...
            })}
        efficiency
    end

    methods (Abstract)
        [secret_key_rate, sifted_key_rate, qber] = QkdModel( ...
            protocol, source, detector, dark_count_prob, channel_loss);
    end


    methods


        function [secret_key_rate, qber, sifted_key_rate] = EvaluateQKDLink( ...
            proto, source, detector, Link_Loss_dB, Background_Count_Rate)
            % EVALUATEQKDLINK enact the link performance simulation for the
            % particular protocol

            arguments
                 proto protocol.proto
                 source components.Source
                 detector components.Detector
                 Link_Loss_dB
                 Background_Count_Rate
            end

            %check compatibility
            [~] = proto.CompatibleComponent(source);
            [~] = proto.CompatibleComponent(detector);

            %get inputs to evaluation function (probability of dark counts in a
            %pulse)
            dark_count_probability = 1 - exp(-Background_Count_Rate * detector.Time_Gate_Width);

            %run protocol's evaluation function
            %all evaluation functions must conform to this format
            [secret_key_rate, sifted_key_rate, qber] = proto.QkdModel( ...
                    source, detector, dark_count_probability, Link_Loss_dB);
        end

        function result = CompatibleComponent(protocol, component)
            % Determine whether a supplied source or detector meets the
            % requirements defined in the concrete implementation of
            % source_features and detector_features
            arguments
                protocol protocol.proto
                component {mustBeA(component, ["components.Detector", "components.Source"])}
            end

            component_name = inputname(2);
            props = properties(component);

            switch class(component)
            case "components.Detector"
                mask = ismember(props, protocol.detector_features);
            case "components.Source"
                mask = ismember(props, protocol.source_features);
            otherwise
                error([component_name, ': Not a components.Detector or components.Source']);
            end

            msg = @(p_name) [ ...
                'Field: [ ', p_name, ' ] of [ ', component_name, ...
                ' ] is required. ', p_name, ' must be nonempty and not nan' ...
            ];
            result = true;
            for p = props(mask)'
                prop_name = p{1};
                value = component.(prop_name);
                if all(isempty(value)) || all(isnan(value))
                    error(msg(prop_name));
                    result = false;
                    return
                end
            end
        end

    end
end
