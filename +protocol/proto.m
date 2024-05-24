classdef proto

    properties (Abstract, SetAccess = protected)
        method {mustBeMember(method, {'prepare_and_measure', 'entanglement'})}
        source_features protocol.sourceRequirements
        detector_features protocol.detectorRequirements
        efficiency
        num_detectors {mustBeNumeric,mustBeNonnegative}
    end

    methods (Abstract)
        [secret_key_rate, sifted_key_rate, qber] = QkdModel(protocol, ...
            alice, bob, total_loss, background_counts_rate);
    end


    methods

        function [secret_rate, sifted_rate, qber] = Calculate(proto, ...
            alice, bob, total_loss, loss_unit, background_counts)
            arguments
                proto
                % alice {mustBeA(alice, ["nodes.Satellite", "nodes.Ground_Station"])}
                % bob {mustBeA(bob, ["nodes.Satellite", "nodes.Ground_Station"])}
                alice { ...
                    nodes.mustBeReceiverOrTransmitter(alice), ...
                    nodes.mustHaveSource(alice) }
                bob { ...
                    nodes.mustBeReceiverOrTransmitter(bob), ...
                    nodes.mustHaveDetector(bob) }
                total_loss (:, :) {mustBeNumeric}
                loss_unit {mustBeMember(loss_unit, ["probability", "dB"])}
                background_counts (:, :, :) {mustBeNumeric}
            end

            RowOrColumn = @(arr) sum((size(arr) == min(size(arr))) .* [1, 2]);

            if min(size(total_loss)) == 2
                % got different losses for two different channels
                [secret_rate, sifted_rate, qber] = proto.QkdModel( ...
                    alice, bob, total_loss, background_counts);
                return
            end

            [secret_rate, sifted_rate, qber] = proto.QkdModel( ...
                alice, bob, ...
                units.Loss(loss_unit, "", total_loss).As("probability"), ...
                background_counts + bob.Detector.Dark_Count_Rate*proto.num_detectors);

        end

        function prob = BackgroundCountProbability(proto, ...
            background_count_rate, time_gate_width)
            arguments
                proto
                background_count_rate {mustBeNumeric}
                time_gate_width {mustBeNumeric}
            end

            [~] = proto;

            prob = 1 - exp(-background_count_rate .* time_gate_width);
        end

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
