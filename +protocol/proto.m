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
            transmitter, receiver, total_loss, total_erroneous_counts);
    end


    methods

        function [secret_rate, sifted_rate, qber] = Calculate(proto, ...
            transmitter, receiver, total_loss, loss_unit, background_count_rate)
            arguments
                proto
                transmitter {utilities.mustBeSubclassOf(transmitter,'nodes.Optical_Node'),...
                             nodes.mustHaveSource(transmitter) }
                receiver {utilities.mustBeSubclassOf(receiver,'nodes.Optical_Node'),...
                          nodes.mustHaveDetector(receiver) }
                total_loss (:, :) {mustBeNumeric}
                loss_unit {mustBeMember(loss_unit, ["probability", "dB"])}
                background_count_rate (:, :, :) {mustBeNumeric}
            end

            % RowOrColumn = @(arr) sum((size(arr) == min(size(arr))) .* [1, 2]);

            n_transmitter = numel(transmitter);
            if n_transmitter > 1
                transmitter_sources = cellfun(@(a) proto.compatiblecomponent(a.source, a.Name), transmitter);
            else
                transmitter_sources = proto.CompatibleComponent(transmitter.Source, transmitter.Name);
            end
            assert(all(transmitter_sources), "Detector not compatible with protocol")
    
            n_receiver = numel(receiver);
            if n_receiver > 1
                receiver_detectors = cellfun(@(b) proto.CompatibleComponent(b.Detector, b.Name), receiver);
            else
                receiver_detectors = proto.CompatibleComponent(receiver.Detector, receiver.Name);
            end
            assert(all(receiver_detectors), "Detector not compatible with protocol")

            if string(proto.method) == "entanglement"
                n_transmitter = numel(transmitter);
                if n_transmitter > 1
                    transmitter_detectors = cellfun(@(a) proto.CompatibleComponent(a.Detector, a.Name), transmitter);
                else
                    transmitter_detectors = proto.CompatibleComponent(transmitter.Detector, transmitter.Name);
                end

                if sum(transmitter_detectors) + sum(receiver_detectors) < 2
                    error("Not enough compatible detectors for protocol")
                end

            end

            if min(size(total_loss)) == 2
                % got different losses for two different channels
                [secret_rate, sifted_rate, qber] = proto.QkdModel( ...
                    transmitter, receiver, total_loss, background_count_rate);
                return
            end

            receiver_dcr = proto.ReceiverDarkCountRate(receiver);

            [secret_rate, sifted_rate, qber] = proto.QkdModel( ...
                transmitter, receiver, ...
                units.Loss(total_loss), ...
                background_count_rate + receiver_dcr);

        end

        % TODO: Rename this function or incorporate channel loss
        % TODO: Example for configuring multiple detectors
        % TODO: integrate an optional "tuning factor" so a single detector can be used with different efficiency
        function loss = ReceiverLoss(proto, rx)
            arguments
                proto protocol.proto
                rx {utilities.mustBeSubclassOf(rx,'nodes.Optical_Node'),...
                    nodes.mustHaveDetector(rx) }
            end

            if proto.num_detectors == 1
                loss = rx.Detector.Detection_Efficiency;
                return
            end

            if isscalar(rx)
                loss = rx.Detector.Detection_Efficiency;
                return
            end

            % now assume that counts are randomly and evenly distributed to all
            % detectors
            
            % See Eurasian-scale experimental satellite-based quantum key distribution
            % with detector efficiency mismatch analysis
            % (https://doi.org/10.1364/OE.511772). equation 1
            % Sum over detection efficiencies after scaling to number of detectors

            loss = sum(rx.Detector.Detection_Efficiency ./ proto.num_detectors); 


        end

        function dcr = ReceiverDarkCountRate(proto, receiver)
            arguments
                proto protocol.proto
                receiver {nodes.mustHaveDetector(receiver)}
            end

            if isscalar(receiver.Detector)
                dcr = receiver.Detector.Dark_Count_Rate .* proto.num_detectors;
                return
            end

            assert(numel(receiver.Detector) == proto.num_detectors, [
                'Receiver must have either a single detector object for ', ...
                'all detections modes or specific detector objects for ', ...
                'each mode']);
            dcr = sum(receiver.Detector.Dark_Count_Rate);

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

        function result = CompatibleComponent(protocol, component, label)
            % Determine whether a supplied source or detector meets the
            % requirements defined in the concrete implementation of
            % source_features and detector_features
            arguments
                protocol protocol.proto
                component {mustBeA(component, ["components.Detector", "components.Source"])}
                label {mustBeTextScalar}
            end

            component_name = label;
            props = properties(component);

            switch class(component)
            case "components.Detector"
                mask = ismember(props, protocol.detector_features);
                component_name = string(component_name) +  ".Detector";
            case "components.Source"
                mask = ismember(props, protocol.source_features);
                component_name = string(component_name) +  ".Source";
            otherwise
                error([component_name, ': Not a components.Detector or components.Source']);
            end

            msg = @(p_name) [ ...
                newline, ...
                'Field: [ ', p_name, ' ] of [ ', char(component_name), ...
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
