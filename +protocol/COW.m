classdef COW < protocol.Proto

    % COW
    %
    % Implements the Coherent One-Way (COW) quantum key distribution protocol.
    % Based on chip-based QKD with decoy states and jitter-aware error modeling.
    %

    properties (SetAccess = protected)
        method = 'prepare_and_measure';
        source_features = protocol.SourceRequirements.features( ...
            "MPN_Signal", ...
            "Probability_Signal", ...
            "Probability_Decoy", ...
            "State_Prep_Error");
        detector_features = protocol.DetectorRequirements.features( ...
            'Dark_Count_Rate', 'Time_Gate_Width', 'Visibility');
        efficiency = 1;
        num_detectors = 2;
        name = 'COW';

        num_transmitters = 1;
        num_receivers = 1;
    end

    methods

        function protocol = COW()
            % Cow
            %
            % Constructor for the Cow protocol class.
            %
            % Syntax:
            % protocol = protocol.Cow()

            % No initialization required
        end

        function [secret_rate, sifted_rate, qber] = qkdModel(proto, ...
                alice, bob, total_loss, total_background_count_rate)
            % qkdModel
            %
            % Computes the secret key rate, sifted key rate, and QBER for the
            % Coherent One-Way (COW) protocol.
            %
            % Syntax:
            % [secret_rate, sifted_rate, qber] = protocol.Cow.qkdModel(...)
            %
            % Inputs:
            % proto - (1x1) Cow object
            % alice - (1x1) node with source
            % bob - (1x1) node with detector
            % total_loss - (1xN) numeric, total channel loss
            % total_background_count_rate - (1xN) numeric, external noise rate
            %
            % Outputs:
            % secret_rate - (1xN) numeric, final secure key rate
            % sifted_rate - (1xN) numeric, sifted key rate
            % qber - (1xN) numeric, quantum bit error rate

            mpn = alice.source.mpn_signal;
            state_prep_error = alice.source.state_prep_error;
            rep_rate = alice.source.repetition_rate;
            decoy_prob = alice.source.probability_decoy;
            dead_time = bob.detector.dead_time;

            f = 1.2;

            T = total_loss;
            R = mpn .* T;

            prob_dark_counts = proto.backgroundCountProbability( ...
                total_background_count_rate, bob.detector.time_gate_width);
            p_click = R + prob_dark_counts;

            rate_in = 0.5 * R * rep_rate + prob_dark_counts * rep_rate;
            sifted_rate = min(rate_in, 1 / dead_time);

            qber_jitter = bob.detector.qber_jitter;
            qber_dark = 0.5 * prob_dark_counts ./ p_click;

            qnber = (1 - qber_dark) .* (1 - qber_jitter) .* (1 - state_prep_error);
            qber = 1 - qnber;

            visibility = bob.detector.visibility;
            Xcow = qber + (1 - qber) .* H((1 + eps(mpn, visibility)) ./ 2);

            secret_rate = sifted_rate .* (1 - f * H(qber) - Xcow) .* ...
                (1 - decoy_prob) * proto.efficiency;
            secret_rate(secret_rate < 0) = 0;
        end

    end

end

function V_ = eps(mu, V)
    % eps
    %
    % Computes the epsilon parameter for visibility-based error modeling.
    %
    % Syntax:
    % V_ = eps(mu, V)
    %
    % Inputs:
    % mu - (1xN) numeric, mean photon number
    % V - (1xN) numeric, visibility
    %
    % Outputs:
    % V_ - (1xN) numeric, epsilon correction term

    V_ = (2 .* V - 1) .* exp(-mu) - ...
         2 .* sqrt(V .* (1 - V)) .* sqrt(1 - exp(-2 * mu));
end

function entropy = H(p)
    % H
    %
    % Computes the binary entropy of a probability value.
    %
    % Syntax:
    % entropy = H(p)
    %
    % Inputs:
    % p - (1xN) numeric, probability values in [0, 1]
    %
    % Outputs:
    % entropy - (1xN) numeric, binary entropy

    assert(all(p >= 0 & p <= 1), ...
        'Input to binary entropy function must be a valid probability');

    entropy = -(p .* log2(p) + (1 - p) .* log2(1 - p));
end