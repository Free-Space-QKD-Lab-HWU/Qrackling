classdef BBM92 < protocol.Proto

    % BBM92
    %
    % Implements the BBM92 quantum key distribution protocol using entangled
    % photon sources. Supports point-to-point configuration with one transmitter
    % and one receiver.
    %
    % Syntax:
    % Output = protocol.BBM92(Input1, Input2, …)

    properties (SetAccess = protected)
        method = 'entanglement';
        source_features = protocol.SourceRequirements.features( ...
            "MPN_Signal", "Local_Loss", "State_Prep_Error");
        detector_features = protocol.DetectorRequirements.features("Dark_Count_Rate");
        efficiency = 0.5;
        num_detectors = 4;
        name = 'Point-to-Point BBM92';

        num_transmitters = 1;
        num_receivers = 1;
    end

    methods

        function [secret_key_rate, sifted_key_rate, qber] = qkdModel(protocol, ...
                alice, bob, total_loss, total_erroneous_count_rate)
            % qkdModel
            %
            % Computes the secret key rate, sifted key rate, and quantum bit error
            % rate (QBER) for the BBM92 protocol using entangled photon sources.
            %
            % Syntax:
            % [secret_key_rate, sifted_key_rate, qber] = protocol.BBM92.qkdModel(...)
            %
            % Inputs:
            % protocol - (1x1) BBM92 object
            % alice - (1x1) node with source and detector
            % bob - (1x1) node with detector
            % total_loss - (1xN) numeric, total channel loss
            % total_erroneous_count_rate - (1xN) numeric, external noise rate
            %
            % Outputs:
            % secret_key_rate - (1xN) numeric, final secure key rate
            % sifted_key_rate - (1xN) numeric, sifted key rate
            % qber - (1xN) numeric, quantum bit error rate

            arguments
                protocol
                alice { ...
                    nodes.mustBeReceiverOrTransmitter(alice), ...
                    nodes.mustHaveSource(alice) }
                bob { ...
                    nodes.mustBeReceiverOrTransmitter(bob), ...
                    nodes.mustHaveDetector(bob) }
                total_loss {mustBeNumeric}
                total_erroneous_count_rate {mustBeNumeric}
            end

            assert(isscalar(bob), ...
                "Can only support a single receiver, when alice has the source");

            loss_alice = alice.source.local_loss;
            loss_bob = total_loss;

            background_probability_alice = ones(size(total_loss)) .* ...
                protocol.backgroundCountProbability( ...
                alice.detector.dark_count_rate * protocol.num_detectors, ...
                alice.detector.time_gate_width);

            background_probability_bob = protocol.backgroundCountProbability( ...
                total_erroneous_count_rate + ...
                bob.detector.dark_count_rate * protocol.num_detectors, ...
                bob.detector.time_gate_width);

            transmission_alice = protocol.receiverLoss(alice) .* loss_alice;
            transmission_bob = protocol.receiverLoss(bob) .* loss_bob;

            pairs_per_pulse = alice.source.mpn_signal / 2;

            gain = protocol.gainOverall(transmission_alice, transmission_bob, ...
                background_probability_alice, background_probability_bob, pairs_per_pulse);

            qber = protocol.qberNet(transmission_alice, transmission_bob, gain, ...
                pairs_per_pulse, protocol.efficiency, alice.source.state_prep_error);

            reconciliation_factor = protocol.efficiency;
            skr = protocol.secureKeyRate(reconciliation_factor, gain, qber, qber);

            skr(skr < 0) = 0;

            sifted_key_rate = alice.source.repetition_rate .* gain;
            secret_key_rate = alice.source.repetition_rate .* skr;
        end
    end

    methods (Static)

        function y = yield(transmission, background_counts, n_pairs)
            % yield
            %
            % Computes the yield for a given number of photon pairs and transmission
            % and background parameters.
            %
            % Syntax:
            % y = protocol.BBM92.yield(transmission, background_counts, n_pairs)
            %
            % Inputs:
            % transmission - (1xN) numeric, channel transmission
            % background_counts - (1xN) numeric, background count probabilities
            % n_pairs - (1x1) numeric, number of photon pairs
            %
            % Outputs:
            % y - (1xN) numeric, yield probability

            arguments
                transmission (1, :) {mustBeNumeric, mustBeInRange(transmission, 0, 1)}
                background_counts (1, :) {mustBeNumeric}
                n_pairs {mustBeNumeric, mustBeGreaterThanOrEqual(n_pairs, 0)}
            end

            y = (1 - (1 - background_counts) .* (1 - transmission)) .^ n_pairs;
        end

        function y = yieldConditional(transmission_alice, transmission_bob, ...
                background_counts_alice, background_counts_bob, n_pairs)
            % yieldConditional
            %
            % Computes the joint yield for Alice and Bob given transmission and
            % background parameters.
            %
            % Syntax:
            % y = protocol.BBM92.yieldConditional(...)
            %
            % Inputs:
            % transmission_alice, transmission_bob - (1xN) numeric
            % background_counts_alice, background_counts_bob - (1xN) numeric
            % n_pairs - (1x1) numeric
            %
            % Outputs:
            % y - (1xN) numeric, joint yield

            arguments
                transmission_alice (1, :) {mustBeNumeric, mustBeInRange(transmission_alice, 0, 1)}
                transmission_bob (1, :) {mustBeNumeric, mustBeInRange(transmission_bob, 0, 1)}
                background_counts_alice (1, :) {mustBeNumeric}
                background_counts_bob (1, :) {mustBeNumeric}
                n_pairs {mustBeNumeric, mustBePositive}
            end

            y = ...
                protocol.BBM92.yield(background_counts_alice, transmission_alice, n_pairs) .* ...
                protocol.BBM92.yield(background_counts_bob, transmission_bob, n_pairs);
        end

        function p = emissionProbability(n_pairs, pairs_per_pump_pulse)
            % emissionProbability
            %
            % Computes the probability of emitting a given number of photon pairs.
            %
            % Syntax:
            % p = protocol.BBM92.emissionProbability(n_pairs, pairs_per_pump_pulse)
            %
            % Inputs:
            % n_pairs - (1x1) numeric
            % pairs_per_pump_pulse - (1x1) numeric
            %
            % Outputs:
            % p - (1x1) numeric, emission probability

            arguments
                n_pairs {mustBeNumeric, mustBePositive, mustBeReal}
                pairs_per_pump_pulse {mustBeNumeric, mustBeReal, ...
                    mustBeGreaterThanOrEqual(pairs_per_pump_pulse, 0)}
            end

            p = ((n_pairs + 1) .* (pairs_per_pump_pulse .^ n_pairs)) ./ ...
                ((1 + pairs_per_pump_pulse) .^ (n_pairs + 2));
        end

        function g = gain(transmission_alice, transmission_bob, background_counts_alice, ...
                background_counts_bob, n_pairs, pairs_per_pump_pulse)
            % gain
            %
            % Computes the gain for a given number of photon pairs and transmission
            % and background parameters.
            %
            % Syntax:
            % g = protocol.BBM92.gain(...)
            %
            % Inputs:
            % transmission_alice, transmission_bob - (1xN) numeric
            % background_counts_alice, background_counts_bob - (1xN) numeric
            % n_pairs - (1x1) numeric
            % pairs_per_pump_pulse - (1x1) numeric
            %
            % Outputs:
            % g - (1xN) numeric, gain

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
                background_counts_alice, background_counts_bob, pairs_per_pump_pulse)
            % gainOverall
            %
            % Computes the overall gain by combining individual and joint contributions
            % from Alice and Bob, accounting for transmission and background noise.
            %
            % Syntax:
            % g = protocol.BBM92.gainOverall(...)
            %
            % Inputs:
            % transmission_alice, transmission_bob - (1xN) numeric
            % background_counts_alice, background_counts_bob - (1xN) numeric
            % pairs_per_pump_pulse - (1x1) numeric
            %
            % Outputs:
            % g - (1xN) numeric, overall gain

            arguments
                transmission_alice (1, :) {mustBeNumeric, mustBeInRange(transmission_alice, 0, 1)}
                transmission_bob (1, :) {mustBeNumeric, mustBeInRange(transmission_bob, 0, 1)}
                background_counts_alice (1, :) {mustBeNumeric}
                background_counts_bob (1, :) {mustBeNumeric}
                pairs_per_pump_pulse {mustBeNumeric, mustBeReal, ...
                    mustBeGreaterThanOrEqual(pairs_per_pump_pulse, 0)}
            end

            contrib_alice = (1 - background_counts_alice) ./ ...
                ((1 + (transmission_alice .* pairs_per_pump_pulse)) .^ 2);

            contrib_bob = (1 - background_counts_bob) ./ ...
                ((1 + (transmission_bob .* pairs_per_pump_pulse)) .^ 2);

            a = (1 - background_counts_alice) .* (1 - background_counts_bob);
            b = 1 ...
                + (transmission_alice .* pairs_per_pump_pulse) ...
                + (transmission_bob .* pairs_per_pump_pulse) ...
                - (transmission_alice .* transmission_bob .* pairs_per_pump_pulse);

            contrib_joint = a ./ (b .^ 2);

            g = 1 - contrib_alice - contrib_bob + contrib_joint;
        end

        function qber = qberNet(transmission_alice, transmission_bob, ...
                overall_gain, pairs_per_pump_pulse, error_random, error_detector)
            % qberNet
            %
            % Computes the quantum bit error rate (QBER) for the BBM92 protocol,
            % accounting for transmission, gain, and error sources.
            %
            % Syntax:
            % qber = protocol.BBM92.qberNet(...)
            %
            % Inputs:
            % transmission_alice, transmission_bob - (1xN) numeric
            % overall_gain - (1xN) numeric
            % pairs_per_pump_pulse - (1x1) numeric
            % error_random, error_detector - (1x1) numeric
            %
            % Outputs:
            % qber - (1xN) numeric, quantum bit error rate

            arguments
                transmission_alice (1, :) {mustBeNumeric, mustBeInRange(transmission_alice, 0, 1)}
                transmission_bob (1, :) {mustBeNumeric, mustBeInRange(transmission_bob, 0, 1)}
                overall_gain {mustBeNumeric}
                pairs_per_pump_pulse {mustBeNumeric, mustBePositive, mustBeReal}
                error_random {mustBeNumeric, mustBePositive, mustBeReal}
                error_detector {mustBeNumeric, mustBePositive, mustBeReal}
            end

            numer = 2 .* (error_random - error_detector) .* ...
                transmission_alice .* transmission_bob .* ...
                pairs_per_pump_pulse .* (1 + pairs_per_pump_pulse);

            alice_term = 1 + (transmission_alice .* pairs_per_pump_pulse);
            bob_term = 1 + (transmission_bob .* pairs_per_pump_pulse);
            joint_term = 1 + ...
                (transmission_alice .* pairs_per_pump_pulse) + ...
                (transmission_bob .* pairs_per_pump_pulse) - ...
                (transmission_alice .* transmission_bob .* pairs_per_pump_pulse);

            denom = alice_term .* bob_term .* joint_term;

            qber = ((error_random .* overall_gain) - (numer ./ denom)) ./ overall_gain;
            qber(qber > 0.5) = 0.5;
        end

        function r = secureKeyRate(basis_reconciliation_factor, ...
                overall_gain, error_bit, error_phase, error_correction_efficiency)
            % secureKeyRate
            %
            % Computes the final secure key rate using reconciliation efficiency,
            % gain, and error rates.
            %
            % Syntax:
            % r = protocol.BBM92.secureKeyRate(...)
            %
            % Inputs:
            % basis_reconciliation_factor - (1x1) numeric, reconciliation efficiency
            % overall_gain - (1xN) numeric
            % error_bit, error_phase - (1xN) numeric
            % error_correction_efficiency - (1x1) numeric, default 1.22
            %
            % Outputs:
            % r - (1xN) numeric, secure key rate

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

            r = basis_reconciliation_factor .* overall_gain .* ...
                (1 - (error_correction_efficiency .* h_bit) - h_phase);
        end

    end
end