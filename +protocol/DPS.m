classdef DPS < protocol.Proto

    % Dps
    %
    % Implements the Differential Phase Shift (DPS) quantum key distribution
    % protocol. Based on visibility, dark counts, and phase encoding errors.
    %
    % Syntax:
    % protocol = protocol.Dps()

    properties (SetAccess = protected)
        method = 'prepare_and_measure';
        source_features = protocol.SourceRequirements.features( ...
            'MPN_Signal', 'State_Prep_Error', 'Probability_Signal');
        detector_features = protocol.DetectorRequirements.features( ...
            'Dark_Count_Rate', 'Time_Gate_Width', 'Dead_Time', 'QBER_Jitter');
        efficiency = 1;
        num_detectors = 2;
        name = 'DPS';

        num_transmitters = 1;
        num_receivers = 1;
    end

    methods

        function protocol = DPS()
            % DPS
            %
            % Constructor for the DPS protocol class.
            %
            % Syntax:
            % protocol = protocol.DPS()

            % No initialization required
        end

        function [secret_rate, sifted_rate, qber] = qkdModel(proto, ...
                alice, bob, total_loss, total_background_count_rate)
            % qkdModel
            %
            % Computes the secret key rate, sifted key rate, and QBER for the
            % DPS protocol using visibility and phase encoding analysis.
            %
            % Syntax:
            % [secret_rate, sifted_rate, qber] = protocol.Dps.qkdModel(...)
            %
            % Inputs:
            % proto - (1x1) Dps object
            % alice - (1x1) node with source
            % bob - (1x1) node with detector
            % total_loss - (1xN) numeric, total channel loss
            % total_background_count_rate - (1xN) numeric, external noise rate
            %
            % Outputs:
            % secret_rate - (1xN) numeric, final secure key rate
            % sifted_rate - (1xN) numeric, sifted key rate
            % qber - (1xN) numeric, quantum bit error rate

            [~] = proto;

            rep_rate = alice.source.repetition_rate;
            eta = proto.receiverLoss(bob);
            V = bob.detector.visibility;
            mu = alice.source.mpn_signal;

            % Estimate dark count probability
            prob_dark_counts = proto.backgroundCountProbability( ...
                total_background_count_rate, bob.detector.time_gate_width);

            f = 1.2;  % Error correction efficiency

            % Total transmission efficiency
            T = total_loss .* eta;

            % Probability of a detection event
            sifted_prob = (mu .* T + prob_dark_counts);
            sifted_rate = rep_rate .* sifted_prob;

            % QBER contributions
            qber_visibility = (1 - V) / 2;
            qber_dark = 0.5 .* prob_dark_counts ./ sifted_prob;
            qber_encoding = alice.source.state_prep_error;

            % QBERs add in inverse: compute probability of no errors
            qber = proto.combineQBER(qber_dark,qber_encoding,qber_visibility);

            % Privacy amplification compression factor
            % tau = (1 - 2*mu)*log2(1 - qber.^2 - (1 - 6*qber).^2/2); % 2007 formula
            tau = qber + (1 - qber) .* h((1 + eps(mu, V)) ./ 2);      % 2008 formula
            % tau = h((3 + sqrt(5))*qber);                            % 2009 formula

            % Secret key rate (2008 and 2009 analysis)
            secret_rate = sifted_rate .* (1 - f .* h(qber) - real(tau));

            % Ensure SKR is non-negative and real
            secret_rate(secret_rate < 0 & imag(secret_rate) == 0) = 0;
            secret_rate = real(secret_rate);
        end

    end

end

function [V_] = eps(mu,V)
    V_ = (2*V - 1).*exp(-mu) - 2*sqrt(V.*(1 - V))*sqrt(1 - exp(-2*mu));
end

function y = h(x)
    %the binary entropy function
    y = -(x.*log2(x) + (1-x).*log2(1-x));
end