classdef DecoyBB84 < protocol.Proto

    % DecoyBB84
    %
    % Implements the BB84 quantum key distribution protocol with decoy states.
    % Based on realistic device modeling and multiphoton detection analysis.
    %
    % Syntax:
    % Output = protocol.DecoyBB84(Input1, Input2, …)

    properties (SetAccess = protected)
        method = 'prepare_and_measure';
        source_features = protocol.SourceRequirements.features( ...
            "MPN_Signal", "Probability_Signal", ...
            "MPN_Decoy", "Probability_Decoy", ...
            "State_Prep_Error");
        detector_features = protocol.DetectorRequirements.features( ...
            "Dark_Count_Rate", "Time_Gate_Width", "Dead_Time");
        efficiency = 0.5;
        num_detectors = 4;
        name = 'Decoy BB84';

        num_transmitters = 1;
        num_receivers = 1;
    end

    methods

        function protocol = DecoyBB84()
            % DecoyBB84
            %
            % Constructor for the DecoyBB84 protocol class.
            %
            % Syntax:
            % protocol = protocol.DecoyBB84()

            % No initialization required
        end

        function [skr_decoy_bb84, sifted_key_rate, qber] = qkdModel(proto, ...
                alice, bob, total_loss, total_background_count_rate)
            % qkdModel
            %
            % Computes the secure key rate, sifted key rate, and QBER for the
            % BB84 protocol with decoy states.
            %
            % Syntax:
            % [skr_decoy_bb84, sifted_key_rate, qber] = protocol.DecoyBB84.qkdModel(...)
            %
            % Inputs:
            % proto - (1x1) DecoyBB84 object
            % alice - (1x1) node with source
            % bob - (1x1) node with detector
            % total_loss - (1xN) numeric, total channel loss
            % total_background_count_rate - (1xN) numeric, external noise rate
            %
            % Outputs:
            % skr_decoy_bb84 - (1xN) numeric, secure key rate
            % sifted_key_rate - (1xN) numeric, sifted key rate
            % qber - (1xN) numeric, quantum bit error rate

            % Get repetition rate and state preparation error
            rep_rate = alice.source.repetition_rate;
            state_prep_error = alice.source.state_prep_error;

            % Total transmission loss
            loss = total_loss;

            % Estimate probability of dark counts
            prob_dark_counts = proto.backgroundCountProbability( ...
                total_background_count_rate, bob.detector.time_gate_width);

            % QBER contributions from detector jitter and polarisation misalignment
            qber_jitter = bob.detector.qber_jitter;
            qber_polarisation_error = sind(bob.detector.polarisation_error);

            % Extract mean photon numbers and state probabilities
            mpn = [alice.source.mpn_signal, alice.source.mpn_decoy, alice.source.mpn_vacuum];
            state_probability = [ ...
                alice.source.probability_signal, ...
                alice.source.probability_decoy, ...
                alice.source.probability_vacuum];

            % Calculate expected emission per state
            emission = mpn .* state_probability;

            % Detection probability per state (signal, decoy, vacuum)
            detection_probabilities = (emission' .* loss) + prob_dark_counts;

            % QBER contributions
            qber_cod = state_prep_error;
            qber_noise = 0.5 * prob_dark_counts ./ detection_probabilities;

            % Total QBER, capped at 0.5
            qber = proto.combineQBER(qber_cod,qber_noise,qber_jitter,qber_polarisation_error);
            
            % Estimate multiphoton contribution for decoy state
            pM_weak = photonDetc(emission(2), 2, loss, prob_dark_counts)';

            % Estimate single-photon contribution for decoy state
            pS_weak = detection_probabilities(2,:) - pM_weak - ...
                prob_dark_counts * exp(-emission(2));

            % QBER for single-photon decoy state
            qber_s = (qber(2,:) .* detection_probabilities(2,:) ...
                - 0.5 * prob_dark_counts * exp(-emission(2))) ./ pS_weak;

            % Estimate single-photon contribution for signal state
            pS_signal = photonDetc(emission(1), 1, loss, prob_dark_counts);

            % Error correction efficiency
            f = 1.2;

            % Final secure key rate (Ma et al. 2005)
            ideal_secret_key_rate = proto.efficiency * ( ...
                -detection_probabilities(1,:) * f .* H(qber(1,:)) + ...
                pS_signal .* (1 - H(qber_s)) );

            % Sifted key rate
            sifted_key_rate = pS_signal * proto.efficiency * rep_rate;

            % Apply dead time constraint
            skr_decoy_bb84 = min(rep_rate * ideal_secret_key_rate, 1 / bob.detector.dead_time);

            % Ensure SKR is non-negative and defined
            skr_decoy_bb84(isnan(skr_decoy_bb84)) = NaN;
            skr_decoy_bb84(skr_decoy_bb84 < 0) = 0;

            % Output only signal state QBER
            qber = qber(1,:);
        end

    end

end

function prob = photonDetc(mu, n, t, p_dark)
    % photonDetc
    %
    % Computes the probability of photon detection for single or multiphoton states.
    %
    % Syntax:
    % prob = photonDetc(mu, n, t, p_dark)
    %
    % Inputs:
    % mu - (1x1) numeric, mean photon number
    % n - (scalar or vector) photon count
    % t - (1xN) numeric, transmission
    % p_dark - (1xN) numeric, dark count probability
    %
    % Outputs:
    % prob - (1xN) numeric, detection probability

    if n == 1
        % Single-photon detection probability
        prob = (1 - (1 - t).^n) * (mu^n) / factorial(n) * exp(-mu) + ...
               p_dark * mu * exp(-mu);
    else
        % Multiphoton detection probability (n = 2 to 5)
        n = 2:5;
        prob = (1 - (1 - t').^n) .* (mu.^n) ./ factorial(n) * exp(-mu);
        prob = (sum(prob, 2)' + p_dark .* (1 - (1 + mu) * exp(-mu)))';
    end
end

function entropy = H(x)
    % H
    %
    % Computes the binary entropy of a probability value.
    %
    % Syntax:
    % entropy = H(x)
    %
    % Inputs:
    % x - (1xN) numeric, probability values in [0, 1]
    %
    % Outputs:
    % entropy - (1xN) numeric, binary entropy

    if all(x > 0 & x < 1)
        entropy = -x .* log2(x) - (1 - x) .* log2(1 - x);
    else
        entropy = NaN;
    end
end