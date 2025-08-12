classdef Proto

    % Proto
    %
    % Abstract base class for quantum key distribution protocols.
    % Defines required interface and shared utilities for protocol subclasses.
    %
    % Syntax:
    % protocol = protocol.Proto()

    properties (Abstract, SetAccess = protected)
        method {mustBeMember(method, {'prepare_and_measure', 'entanglement'})}
        source_features protocol.SourceRequirements
        detector_features protocol.DetectorRequirements
        efficiency
        num_detectors {mustBeNumeric, mustBeNonnegative}
        name {mustBeText}
        num_transmitters
        num_receivers
    end

    methods (Abstract)

            qkdModel()

    end

    methods

        function [secret_rate, sifted_rate, qber] = calculate(proto, ...
                transmitter, receiver, total_loss, background_count_rate)
            % calculate
            %
            % Validates components and runs the protocol model.
            %
            % Syntax:
            % [secret_rate, sifted_rate, qber] = proto.calculate(...)
            %
            % Inputs:
            % transmitter, receiver - node objects
            % total_loss - numeric matrix
            % background_count_rate - numeric matrix
            %
            % Outputs:
            % secret_rate, sifted_rate, qber - numeric vectors

            arguments
                proto
                transmitter {utilities.mustBeSubclassOf(transmitter, 'nodes.QKDTransmitter')}
                receiver {utilities.mustBeSubclassOf(receiver, 'nodes.QKDReceiver')}
                total_loss (:, :)
                background_count_rate (:, :, :)
            end

            % Check transmitter compatibility
            if numel(transmitter) > 1
                transmitter_sources = cellfun(@(a) proto.compatibleComponent(a.source, a.name), transmitter);
            else
                transmitter_sources = proto.compatibleComponent(transmitter.source, transmitter.name);
            end
            assert(all(transmitter_sources), "Transmitter not compatible with protocol");

            % Check receiver compatibility
            if numel(receiver) > 1
                receiver_detectors = arrayfun(@(b) proto.compatibleComponent(b.detector, b.name), receiver);
            else
                receiver_detectors = proto.compatibleComponent(receiver.detector, receiver.name);
            end
            assert(all(receiver_detectors), "Detector not compatible with protocol");

            % Additional check for entanglement protocols
            if string(proto.method) == "entanglement"
                if numel(transmitter) > 1
                    transmitter_detectors = cellfun(@(a) proto.compatibleComponent(a.detector, a.name), transmitter);
                else
                    transmitter_detectors = proto.compatibleComponent(transmitter.detector, transmitter.name);
                end
                if sum(transmitter_detectors) + sum(receiver_detectors) < 2
                    error("Not enough compatible detectors for protocol");
                end
            end

            % Reshape data for point-to-point links
            if numel(transmitter) == 1 && numel(receiver) == 1
                total_loss = squeeze(total_loss)';
                background_count_rate = squeeze(background_count_rate)';
            end

            % Run model
            [secret_rate, sifted_rate, qber] = proto.qkdModel( ...
                transmitter, receiver, total_loss, background_count_rate);
        end

        function loss = receiverLoss(proto, rx)
            % receiverLoss
            %
            % Computes effective detection efficiency for receiver node.
            %
            % Syntax:
            % loss = proto.receiverLoss(rx)

            arguments
                proto protocol.Proto
                rx {utilities.mustBeSubclassOf(rx, 'nodes.QKDReceiver'), ...
                    nodes.mustHaveDetector(rx)}
            end

            if proto.num_detectors == 1 || isscalar(rx)
                loss = rx.detector.detection_efficiency;
                return;
            end

            % Multi-detector case: average efficiency
            loss = sum(rx.detector.detection_efficiency ./ proto.num_detectors);
        end

        function dcrs = receiverDarkCountRate(proto, receivers)
            % receiverDarkCountRate
            %
            % Computes total dark count rate for each receiver.
            %
            % Syntax:
            % dcrs = proto.receiverDarkCountRate(receivers)

            arguments
                proto protocol.Proto
                receivers {nodes.mustHaveDetector(receivers)}
            end

            dcrs = zeros(size(receivers));
            for i = 1:numel(receivers)
                receiver = receivers(i);
                if isscalar(receiver.Detector)
                    current_dcr = receiver.detector.dark_count_rate .* proto.num_detectors;
                else
                    assert(numel(receiver.detector) == proto.num_detectors, ...
                        'Receiver must have either a single detector or one per mode');
                    current_dcr = sum(receiver.detector.dark_count_rate);
                end
                dcrs(i) = current_dcr;
            end
        end

        function prob = backgroundCountProbability(proto, ...
                background_count_rate, time_gate_width)
            % backgroundCountProbability
            %
            % Computes probability of background counts during time gate.
            %
            % Syntax:
            % prob = proto.backgroundCountProbability(rate, width)

            arguments
                proto
                background_count_rate {mustBeNumeric}
                time_gate_width {mustBeNumeric}
            end

            prob = 1 - exp(-background_count_rate .* time_gate_width);
        end

        function result = compatibleComponent(protocol, component, label)
            % compatibleComponent
            %
            % Checks whether a source or detector meets protocol requirements.
            %
            % Syntax:
            % result = protocol.compatibleComponent(component, label)

            arguments
                protocol protocol.Proto
                component {mustBeA(component, ["components.Detector", "components.Source"])}
                label {mustBeTextScalar}
            end

            component_name = label;
            props = properties(component);

            switch class(component)
                case "components.Detector"
                    mask = ismember(props, protocol.detector_features);
                    component_name = string(component_name) + ".Detector";
                case "components.Source"
                    mask = ismember(props, protocol.source_features);
                    component_name = string(component_name) + ".Source";
                otherwise
                    error([component_name, ': Not a components.Detector or components.Source']);
            end

            msg = @(p_name) newline + ...
                'Field: [ ' + p_name + ' ] of [ ' + char(component_name) + ...
                ' ] is required. Must be nonempty and not NaN';

            result = true;
            for p = props(mask)'
                prop_name = p{1};
                value = component.(prop_name);
                if all(isempty(value)) || all(isnan(value))
                    error(msg(prop_name));
                    result = false;
                    return;
                end
            end
        end

        function x = eq(a, b)
            % eq
            %
            % Checks whether two protocol objects are of the same subclass.
            %
            % Syntax:
            % x = eq(a, b)

            arguments
                a {utilities.mustBeSubclassOf(a, 'protocol.Proto')}
                b {utilities.mustBeSubclassOf(b, 'protocol.Proto')}
            end

            x = isequal(class(a), class(b));
        end

        function mustHaveCorrectTransmittersAndReceivers(proto, transmitters, receivers)
            % mustHaveCorrectTransmittersAndReceivers
            %
            % Validates that the number of transmitters and receivers matches protocol.
            %
            % Syntax:
            % proto.mustHaveCorrectTransmittersAndReceivers(transmitters, receivers)

            if isequal(proto.num_transmitters, 'n')
                assert(numel(transmitters) > 0, ...
                    'This protocol requires non-zero transmitters');
            else
                assert(numel(transmitters) == proto.num_transmitters, ...
                    '%s requires exactly %i transmitters, %i provided', ...
                    proto.name, proto.num_transmitters, numel(transmitters));
            end

            if isequal(proto.num_receivers, 'n')
                assert(numel(receivers) > 0, ...
                    'This protocol requires non-zero receivers');
            else
                assert(numel(receivers) == proto.num_receivers, ...
                    '%s requires exactly %i receivers, %i provided', ...
                    proto.name, proto.num_receivers, numel(receivers));
            end
        end

    end

end