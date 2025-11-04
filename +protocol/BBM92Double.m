classdef BBM92Double < protocol.Proto
% BBM92Double
%
% Implements the BBM92 protocol with two receivers using entangled photon pairs.
% This version models asymmetric loss and background noise at both receiver ends.
%
% Syntax:
% Output = protocol.Bbm92Double(Input1, Input2, …)
%
% Based on:
% Ma, X., Fung, C-H. F., et al. (2007), Quantum Key Distribution with Entangled Photon Sources.

    properties (SetAccess = protected)
        method = 'entanglement'

        source_features = protocol.SourceRequirements.features( ...
            "MPN_Signal", "Local_Loss", "State_Prep_Error")

        detector_features = protocol.DetectorRequirements.features( ...
            "Dark_Count_Rate")

        efficiency = 0.5
        num_detectors = 4
        name = 'Double Receiver BBM92'

        num_transmitters = 1
        num_receivers = 2
    end

    methods
        function [secret_key_rate, sifted_key_rate, qber] = qkdModel(Protocol, ...
                alice, bobs, total_loss, total_erroneous_count_rate)
        % qkdModel
        %
        % Computes the sifted and secure key rates for BBM92 with two receivers.
        %
        % Syntax:
        % [secret_key_rate, sifted_key_rate, qber] = protocol.BBM92Double.qkdModel(...)
        %
        % Inputs:
        % alice - Transmitter node with source
        % bobs - Array of two receiver nodes with detectors
        % total_loss - (2xN) double, channel loss to each receiver
        % total_erroneous_count_rate - (1x2xN) double, background count rates
        %
        % Outputs:
        % secret_key_rate - (1xN) double, secure key rate [bit/s]
        % sifted_key_rate - (1xN) double, sifted key rate [bit/s]
        % qber - (1xN) double, quantum bit error rate [%]

            arguments
                Protocol
                alice { ...
                    nodes.mustBeReceiverOrTransmitter(alice), ...
                    nodes.mustHaveSource(alice) }
                bobs { ...
                    nodes.mustBeReceiverOrTransmitter(bobs), ...
                    nodes.mustHaveDetector(bobs) }
                total_loss
                total_erroneous_count_rate
            end

            %% Validate transmitter/receiver configuration
            Protocol.mustHaveCorrectTransmittersAndReceivers(alice, bobs)

            %% Extract channel losses
            loss_bob_1 = total_loss(1, :);
            loss_bob_2 = total_loss(2, :);

            %% Background count probabilities
            background_probability_bob_1 = Protocol.backgroundCountProbability( ...
                total_erroneous_count_rate(1, 1, :), bobs(1).detector.time_gate_width);

            background_probability_bob_2 = Protocol.backgroundCountProbability( ...
                total_erroneous_count_rate(1, 2, :), bobs(2).detector.time_gate_width);

            %% Transmission efficiencies
            transmission_bob_1 = Protocol.receiverLoss(bobs(1)) .* loss_bob_1;
            transmission_bob_2 = Protocol.receiverLoss(bobs(2)) .* loss_bob_2;

            %% Photon pair generation
            pairs_per_pulse = alice.source.mpn_signal;

            %% Overall gain
            gain = Protocol.gainOverall(transmission_bob_1, transmission_bob_2, ...
                background_probability_bob_1, background_probability_bob_2, ...
                pairs_per_pulse);

            %% QBER
            qber = Protocol.qberNet(transmission_bob_1, transmission_bob_2, ...
                gain, pairs_per_pulse, Protocol.efficiency, ...
                alice.source.state_prep_error);

            %% Secure key rate
            reconciliation_factor = Protocol.efficiency;
            skr = Protocol.secureKeyRate(reconciliation_factor, gain, qber, qber);
            skr(skr < 0) = 0;

            sifted_key_rate = alice.source.repetition_rate/2 .* gain;
            secret_key_rate = alice.source.repetition_rate/2 .* skr;
        end
    end

    methods (Static)
        function y = yield(transmission, background_counts, n_pairs)
            arguments
                transmission (1, :) {mustBeNumeric, mustBeInRange(transmission, 0, 1)}
                background_counts (1, :) {mustBeNumeric}
                n_pairs {mustBeNumeric, mustBeGreaterThanOrEqual(n_pairs, 0)}
            end
            y = (1 - (1 - background_counts) .* (1 - transmission)) .^ n_pairs;
        end

        function y = yieldConditional(transmission_alice, transmission_bob, ...
                background_counts_alice, background_counts_bob, n_pairs)
            arguments
                transmission_alice (1, :) {mustBeNumeric, mustBeInRange(transmission_alice, 0, 1)}
                transmission_bob (1, :) {mustBeNumeric, mustBeInRange(transmission_bob, 0, 1)}
                background_counts_alice (1, :) {mustBeNumeric}
                background_counts_bob (1, :) {mustBeNumeric}
                n_pairs {mustBeNumeric, mustBePositive}
            end
            y = ...
                protocol.BBM92.yield(background_counts_alice, transmission_alice, n_pairs) ...
                .* protocol.BBM92.yield(background_counts_bob, transmission_bob, n_pairs);
        end

        function p = emissionProbability(n_pairs, pairs_per_pump_pulse)
            arguments
                n_pairs {mustBeNumeric, mustBePositive, mustBeReal}
                pairs_per_pump_pulse {mustBeNumeric, mustBeReal, ...
                    mustBeGreaterThanOrEqual(pairs_per_pump_pulse, 0)}
            end

            lambda = pairs_per_pump_pulse/2;

            p = ((n_pairs + 1) .* (lambda .^ n_pairs)) ...
                ./ ((1 + lambda) .^ (n_pairs + 2));
        end

        function g = gain(transmission_alice, transmission_bob, ...
                background_counts_alice, background_counts_bob, ...
                n_pairs, pairs_per_pump_pulse)
            arguments
                transmission_alice (1, :) {mustBeNumeric, mustBeInRange(transmission_alice, 0, 1)}
                transmission_bob (1, :) {mustBeNumeric, mustBeInRange(transmission_bob, 0, 1)}
                background_counts_alice (1, :) {mustBeNumeric}
                background_counts_bob (1, :) {mustBeNumeric}
                n_pairs {mustBeNumeric, mustBePositive}
                pairs_per_pump_pulse {mustBeNumeric, mustBeReal, ...
                    mustBeGreaterThanOrEqual(pairs_per_pump_pulse, 0)}
            end
            y = protocol.BBM92.yieldConditional(transmission_alice, transmission_bob, ...
                background_counts_alice, background_counts_bob, n_pairs);

            p = protocol.BBM92.emissionProbability(n_pairs, pairs_per_pump_pulse);

            g = y .* p;
        end

        function g = gainOverall(transmission_alice, transmission_bob, ...
                background_count_probability_alice, background_count_probability_bob, ...
                pairs_per_pump_pulse)
            arguments
                transmission_alice (1, :) {mustBeNumeric, mustBeInRange(transmission_alice, 0, 1)}
                transmission_bob (1, :) {mustBeNumeric, mustBeInRange(transmission_bob, 0, 1)}
                background_count_probability_alice (1, :) {mustBeNumeric}
                background_count_probability_bob (1, :) {mustBeNumeric}
                pairs_per_pump_pulse {mustBeNumeric, mustBeReal, ...
                    mustBeGreaterThanOrEqual(pairs_per_pump_pulse, 0)}
            end
            lambda = pairs_per_pump_pulse/2;

            contrib_alice = (1 - background_count_probability_alice) ...
                ./ ((1 + transmission_alice .* lambda) .^ 2);

            contrib_bob = (1 - background_count_probability_bob) ...
                ./ ((1 + transmission_bob .* lambda) .^ 2);

            a = (1 - background_count_probability_alice) .* (1 - background_count_probability_bob);
            b = 1 + transmission_alice .* lambda ...
                + transmission_bob .* lambda ...
                - transmission_alice .* transmission_bob .* lambda;

            contrib_joint = a ./ (b .^ 2);

            g = 1 - contrib_alice - contrib_bob + contrib_joint;
        end

        function qber = qberNet(transmission_alice, transmission_bob, ...
                overall_gain, pairs_per_pump_pulse, ...
                error_random, error_detector)
            arguments
                transmission_alice (1, :) {mustBeNumeric, mustBeInRange(transmission_alice, 0, 1)}
                transmission_bob (1, :) {mustBeNumeric, mustBeInRange(transmission_bob, 0, 1)}
                overall_gain {mustBeNumeric}
                pairs_per_pump_pulse {mustBeNumeric, mustBePositive, mustBeReal}
                error_random {mustBeNumeric, mustBePositive, mustBeReal}
                error_detector {mustBeNumeric, mustBePositive, mustBeReal}
            end

            lambda = pairs_per_pump_pulse/2;

            numer = 2 .* (error_random - error_detector) ...
                .* transmission_alice .* transmission_bob ...
                .* lambda .* (1 + lambda);

            alice = 1 + transmission_alice .* lambda;
            bob = 1 + transmission_bob .* lambda;
            joint = 1 + transmission_alice .* lambda ...
                + transmission_bob .* lambda ...
                - transmission_alice .* transmission_bob .* lambda;

            denom = alice .* bob .* joint;

            qber = ((error_random .* overall_gain) - (numer ./ denom)) ./ overall_gain;
            qber(qber > 0.5) = 0.5;
        end

        function r = secureKeyRate(basis_reconciliation_factor, ...
                overall_gain, error_bit, error_phase, error_correction_efficiency)
            arguments
                basis_reconciliation_factor {mustBeNumeric, ...
                    mustBeInRange(basis_reconciliation_factor, 0, 1)}
                overall_gain {mustBeNumeric}
                error_bit {mustBeNumeric, mustBeInRange(error_bit, 0, 1)}
                error_phase {mustBeNumeric, mustBeInRange(error_phase, 0, 1)}
                error_correction_efficiency {mustBeNumeric, mustBeReal} = 1.22
            end

            h_bit = utilities.binaryEntropy(error_bit);
            h_phase = utilities.binaryEntropy(error_phase);

            r = basis_reconciliation_factor .* overall_gain ...
                .* (1 - error_correction_efficiency .* h_bit - h_phase);
        end
    end
end