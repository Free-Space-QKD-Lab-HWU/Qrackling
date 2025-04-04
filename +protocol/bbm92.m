classdef bbm92 < protocol.proto
    properties (SetAccess=protected)
        method = 'entanglement'
        source_features = protocol.sourceRequirements.features( ...
            "MPN_Signal", "Local_Loss", "State_Prep_Error")
        detector_features = protocol.detectorRequirements.features("Dark_Count_Rate")
        efficiency = 0.5
        num_detectors = 4;
    end

    methods
        function [secret_key_rate, sifted_key_rate, qber] = QkdModel(Protocol, ...
            alice, bob, total_loss, total_erroneous_count_rate)
            % From: Ma, X., Fung, C-H. F., et al. (2007), Quantum Key
            % Distribution with Entangled Photon Sources.

            arguments
                Protocol
                alice { ...
                    nodes.mustBeReceiverOrTransmitter(alice), ...
                    nodes.mustHaveSource(alice) }
                bob { ...
                    nodes.mustBeReceiverOrTransmitter(bob), ...
                    nodes.mustHaveDetector(bob) }
                total_loss {mustBeNumeric}
                total_erroneous_count_rate {mustBeNumeric}
            end

            % for consistency we want loss and background counts to be in rows
            RowOrColumn = @(arr) sum((size(arr) == min(size(arr))) .* [1, 2]);
            if RowOrColumn(total_loss) == 2
                % got columns so transpose
                total_loss = total_loss';
            end
            if RowOrColumn(total_erroneous_count_rate) == 2
                % got columns so transpose
                total_erroneous_count_rate = total_erroneous_count_rate';
            end

            % now we want to detect if the source is at alice or in the middle
            if ~any(size(total_loss) == 2) % only one set of loss values

                assert(isscalar(bob), "Can only support a single receiver, when alice has the source");

                % if we got here then we know that alice has the source
                loss_alice = alice.Source.Local_Loss;
                loss_bob = total_loss;

                % alice only has to worry about detector dark counts
                background_probability_alice = ones(size(total_loss)) ...
                    .* Protocol.BackgroundCountProbability( ...
                        alice.Detector.Dark_Count_Rate * Protocol.num_detectors, ...
                        alice.Detector.Time_Gate_Width);

                % bob has a receiver so can couple to external noise sources
                background_probability_bob = Protocol.BackgroundCountProbability( ...
                    total_erroneous_count_rate + ...
                    bob.Detector.Dark_Count_Rate * Protocol.num_detectors, ...
                    bob.Detector.Time_Gate_Width);

            else % source in middle (double down/up link)
                % assume ordering is alice then bob
                loss_alice = total_loss(1, :);
                loss_bob = total_loss(2, :);

                if ~any(size(total_erroneous_count_rate) == 2)
                    % assume same environment at both alice and bob
                    background_probability_alice = Protocol.BackgroundCountProbability( ...
                        total_erroneous_count_rate + ...
                        Protocol.ReceiverDarkCountRate(alice), ...
                        alice.Detector.Time_Gate_Width);
                    background_probability_bob = Protocol.BackgroundCountProbability( ...
                        total_erroneous_count_rate + ...
                        Protocol.ReceiverDarkCountRate(bob), ...
                        bob.Detector.Time_Gate_Width);

                elseif numel(bob) == 2
                    % got a pair of receivers so use their specific values
                    background_probability_alice = Protocol.BackgroundCountProbability( ...
                        total_erroneous_count_rate(1, :) + ...
                        Protocol.ReceiverDarkCountRate(bob{1}), ...
                        bob{1}.Detector.Time_Gate_Width);
                    background_probability_bob = Protocol.BackgroundCountProbability( ...
                        total_erroneous_count_rate(2, :) + ...
                        Protocol.ReceiverDarkCountRate(bob{2}), ...
                        bob{2}.Detector.Time_Gate_Width);

                else
                    % we have different conditions at alice and bob locations
                    background_probability_alice = Protocol.BackgroundCountProbability( ...
                        total_erroneous_count_rate(1, :) + ...
                        Protocol.ReceiverDarkCountRate(alice), ...
                        alice.Detector.Time_Gate_Width);
                    background_probability_bob = Protocol.BackgroundCountProbability( ...
                        total_erroneous_count_rate(2, :) + ...
                        Protocol.ReceiverDarkCountRate(bob), ...
                        bob.Detector.Time_Gate_Width);
                end
            end


            if ~any(size(total_loss) == 2) % only one set of loss values
                transmission_alice = Protocol.ReceiverLoss(alice) .* loss_alice;
                transmission_bob = Protocol.ReceiverLoss(bob) .* loss_bob;
            else % source in middle (double down/up link)
                if numel(bob) == 2
                    transmission_alice = Protocol.ReceiverLoss(bob{1}) .* loss_alice;
                    transmission_bob = Protocol.ReceiverLoss(bob{2}) .* loss_bob;
                else
                    transmission_alice = Protocol.ReceiverLoss(bob) .* loss_alice;
                    transmission_bob = Protocol.ReceiverLoss(bob) .* loss_bob;
                end
            end

            pairs_per_pulse = alice.Source.MPN_Signal / 2;
            gain = Protocol.gain_overall(transmission_alice, transmission_bob, ...
                background_probability_alice, background_probability_bob, pairs_per_pulse);

            qber = Protocol.QBER_net(transmission_alice, transmission_bob, gain, ...
                pairs_per_pulse, Protocol.efficiency, alice.Source.State_Prep_Error);

            reconciliation_factor = Protocol.efficiency;
            skr = Protocol.secure_key_rate(reconciliation_factor, gain, qber, qber);
            %modification: cameron simmons SKR cannot be negative
            skr(skr<0)=0;

            sifted_key_rate = alice.Source.Repetition_Rate .* gain;
            secret_key_rate = alice.Source.Repetition_Rate .* skr;
        end
    end

    methods(Static)

        %% eq7- define the yield of different pair number states
        function y = yield(transmission, background_counts, n_pairs)
            arguments
                transmission (1, :) {mustBeNumeric, mustBeInRange(transmission, 0, 1)}
                background_counts (1, :) {mustBeNumeric}
                n_pairs {mustBeNumeric, mustBeGreaterThanOrEqual(n_pairs, 0)}
            end
            % sub-part of eq7
            y = (1 - (1 - background_counts) .* (1 - transmission)) .^ n_pairs;
        end

        function y = yield_conditional(transmission_alice, transmission_bob, ...
            background_counts_alice, background_counts_bob, n_pairs)
            arguments
                transmission_alice (1, :) {mustBeNumeric, mustBeInRange(transmission_alice, 0, 1)}
                transmission_bob (1, :) {mustBeNumeric, mustBeInRange(transmission_bob, 0, 1)}
                background_counts_alice (1, :) {mustBeNumeric}
                background_counts_bob (1, :) {mustBeNumeric}
                n_pairs {mustBeNumeric, mustBePositive}
            end
            % full yimplements eq7
            y = ...
                protocol.bbm92.yield(background_counts_alice, transmission_alice, n_pairs) ...
                .* protocol.bbm92.yield(background_counts_bob, transmission_bob, n_pairs);
        end

        %% eq 5
        function p = emission_probability(n_pairs, pairs_per_pump_pulse)
            arguments
                n_pairs {mustBeNumeric, mustBePositive, mustBeReal}
                pairs_per_pump_pulse {mustBeNumeric, mustBeReal, ...
                    mustBeGreaterThanOrEqual(pairs_per_pump_pulse, 0)}
            end

            p = ...
                ((n_pairs + 1) .* (pairs_per_pump_pulse .^ n_pairs)) ...
                ./ ((1 + pairs_per_pump_pulse) .^ (n_pairs + 2));
        end

        %% eq8
        function g = gain(transmission_alice, transmission_bob, background_counts_alice, ...
            background_counts_bob, n_pairs, pairs_per_pump_pulse)
            arguments
                transmission_alice (1, :) {mustBeNumeric, mustBeInRange(transmission_alice, 0, 1)}
                transmission_bob (1, :) {mustBeNumeric, mustBeInRange(transmission_bob, 0, 1)}
                background_counts_alice (1, :) {mustBeNumeric}
                background_counts_bob (1, :) {mustBeNumeric}
                n_pairs {mustBeNumeric, mustBePositive}
                pairs_per_pump_pulse {mustBeNumeric, mustBeReal, ...
                    mustBeGreaterThanOrEqual(pairs_per_pump_pulse, 0)}
            end

            y = protocol.bbm92.yield_conditional(transmission_alice, transmission_bob, ...
                background_counts_alice, background_counts_bob, n_pairs);

            p = protocol.bbm92.emission_probability(n_pairs, pairs_per_pump_pulse);

            g = y .* p;
        end

        %% eq9
        function g = gain_overall(transmission_alice, transmission_bob, ...
            background_counts_alice, background_counts_bob, pairs_per_pump_pulse)
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

        %% eq10
        function qber = QBER_net(transmission_alice, transmission_bob, ...
            overall_gain, ...
            pairs_per_pump_pulse, error_random, error_detector)
            arguments
                transmission_alice (1, :) {mustBeNumeric, mustBeInRange(transmission_alice, 0, 1)}
                transmission_bob (1, :) {mustBeNumeric, mustBeInRange(transmission_bob, 0, 1)}
                overall_gain {mustBeNumeric}
                pairs_per_pump_pulse {mustBeNumeric, mustBePositive, mustBeReal}
                error_random {mustBeNumeric, mustBePositive, mustBeReal}
                error_detector {mustBeNumeric, mustBePositive, mustBeReal}
            end

            numer = 2 ...
                .* (error_random - error_detector) ...
                .* transmission_alice ...
                .* transmission_bob ...
                .* pairs_per_pump_pulse ...
                .* (1 + pairs_per_pump_pulse);

            alice = 1 + (transmission_alice .* pairs_per_pump_pulse);
            bob = 1 + (transmission_bob .* pairs_per_pump_pulse);
            joint = 1 ...
                    + (transmission_alice .* pairs_per_pump_pulse) ...
                    + (transmission_bob .* pairs_per_pump_pulse) ...
                    - (transmission_alice .* transmission_bob .* pairs_per_pump_pulse);

            denom = alice .* bob .* joint;
            qber = ((error_random .* overall_gain) - (numer ./ denom));
            qber = qber ./ overall_gain;
            qber(qber > 0.5) = 0.5;
        end

        %% eq11
        function r = secure_key_rate(basis_reconciliation_factor, ...
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

            r = basis_reconciliation_factor .* overall_gain .* ...
                (1 - (error_correction_efficiency .* h_bit) - h_phase);
        end
    end

end
