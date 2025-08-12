classdef BB84 < protocol.Proto
% BB84
%
% Implements the BB84 quantum key distribution protocol using prepare-and-measure
% techniques. This class models the protocol's behavior including key rate and QBER
% calculations.
%
% Syntax:
% Output = protocol.Bb84(Input1, Input2, …)
%
% This implementation is based on the paper:
% "Security aspects of quantum key distribution with sub-Poisson light",
% Physical Review Letters, Waks et al.

    properties (SetAccess = protected)
        method = 'prepare_and_measure'

        source_features = protocol.SourceRequirements.features( ...
            "g2", "MPN_Signal", "Probability_Signal", "State_Prep_Error")

        detector_features = protocol.DetectorRequirements.features( ...
            "Dark_Count_Rate", "Time_Gate_Width", "Dead_Time")

        efficiency = 0.5
        num_detectors = 4
        name = 'BB84'

        num_transmitters = 1
        num_receivers = 1
    end

    methods
        function p = BB84()
        end

        function [secret_rate, sifted_rate, qber] = qkdModel(proto, ...
                Alice, Bob, total_loss, total_background_count_rate)
        % qkdModel
        %
        % Computes the sifted key rate and QBER for the BB84 protocol using
        % single-photon sources.
        %
        % Syntax:
        % [secret_rate, sifted_rate, qber] = protocol.bb84.qkdModel(proto, Alice, Bob, ...)
        %
        % Inputs:
        % Alice, Bob - Transmitter and receiver objects
        % total_loss - (1x1) double, total transmission loss [dB]
        % total_background_count_rate - (1x1) double, background count rate
        %
        % Outputs:
        % secret_rate - (1x1) double, secure key rate [bit/s]
        % sifted_rate - (1x1) double, sifted key rate [bit/s]
        % qber - (1x1) double, quantum bit error rate [%]

            %% Extract source parameters
            mpn = Alice.source.mpn_signal;
            g2 = Alice.source.g2;
            state_prep_error = Alice.source.state_prep_error;
            rep_rate = Alice.source.repetition_rate;

            %% Estimate background count probability
            prob_dark = proto.backgroundCountProbability( ...
                total_background_count_rate, Bob.detector.time_gate_width);

            %% Estimate detection probability
            prob_click = mpn * total_loss + prob_dark;

            %% Multi-photon probability
            prob_multi = 0.5 * mpn.^2 * g2;

            %% Single-photon fraction
            beta = (prob_click - prob_multi) ./ prob_click;

            %% State preparation error
            mu = state_prep_error;

            %% Signal probability
            prob_signal = mpn .* total_loss;

            %% QBER components
            qber_jitter = Bob.detector.qber_jitter;
            qber_polarisation_error = sind(Bob.detector.polarisation_error);

            %% Total QBER
            qber = (mu * prob_signal + prob_dark .* 0.5) ...
                ./ prob_click + qber_jitter + qber_polarisation_error;
            qber(qber > 0.5) = 0.5;

            %% Privacy amplification factor
            tau = -log2(0.5 + 2*qber./beta - 2*(qber./beta).^2);
            tau(~(imag(tau) == 0)) = 0;

            %% Error correction efficiency
            f = 1.366 .* qber + 1.117;

            %% Binary entropy
            bin_ent = -qber .* log2(qber) - (1 - qber) .* log2(1 - qber);

            %% Sifted key rate
            sifted_rate = rep_rate .* proto.efficiency .* prob_click;

            %% Secret key rate
            secret_rate = sifted_rate .* (beta .* tau - f .* bin_ent);
            secret_rate(secret_rate < 0) = 0;
        end
    end
end