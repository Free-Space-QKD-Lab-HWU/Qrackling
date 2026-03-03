classdef E91 < protocol.Proto

    % E91
    %
    % Implements the Ekert 1991 (E91) quantum key distribution protocol.
    % Based on entangled photon pairs and Bell inequality correlations.
    %
    % Syntax:
    % protocol = protocol.E91()

    properties (SetAccess = protected)
        method = 'prepare_and_measure';
        source_features = protocol.SourceRequirements.features( ...
            "Mean_Photon_Number", "State_Prep_Error", "g2");
        detector_features = protocol.DetectorRequirements.features( ...
            "Dark_Count_Rate", "Time_Gate_Width");
        efficiency = 1;
        name = 'E91';
        num_detectors = 2;

        num_transmitters = 1;
        num_receivers = 1;
    end

    methods

        function protocol = E91()
            % E91
            %
            % Constructor for the E91 protocol class.
            %
            % Syntax:
            % protocol = protocol.E91()

            % No initialization required
        end

        function [secret_rate, sifted_rate, qber] = qkdModel(proto, ...
                alice, bob, total_loss, total_background_count_rate)
            % qkdModel
            %
            % Computes the secret key rate, sifted key rate, and QBER for the
            % E91 protocol using entangled photon correlations.
            %
            % Syntax:
            % [secret_rate, sifted_rate, qber] = protocol.E91.qkdModel(...)
            %
            % Inputs:
            % proto - (1x1) E91 object
            % alice - (1x1) node with source
            % bob - (1x1) node with detector
            % total_loss - (1xN) numeric, total channel loss
            % total_background_count_rate - (1xN) numeric, external noise rate
            %
            % Outputs:
            % secret_rate - (1xN) numeric, final secure key rate
            % sifted_rate - (1xN) numeric, sifted key rate
            % qber - (1xN) numeric, quantum bit error rate

            rep_rate = alice.Source.Repetition_Rate;

            % Intermediate step to compute key variables
            P_d = 0;           % Probability of double detection
            eta_d = 1;         % Ideal detection efficiency

            A_d = eta_d + (1 - eta_d) .* P_d;
            q1 = (1 - P_d) .* A_d;
            q2 = (1 - A_d) .* P_d;
            q3 = P_d .* A_d;

            % Sift probability: probability of successful entangled correlations
            sift_prob = (q1 + q2 + q3) .^ 2;

            % Probability of dark counts
            prob_dark_counts = proto.backgroundCountProbability(total_background_count_rate);
            P_e = prob_dark_counts;

            % Detection efficiency
            det_eff = proto.receiverLoss(bob.Detector.Detection_Efficiency);
            if det_eff > 1
                eta_e = det_eff / 100;
            else
                eta_e = det_eff;
            end

            % Transmission loss
            loss = total_loss;
            lambda = 10 .^ (-loss ./ 10);

            A_e = eta_e .* lambda + P_e .* (1 - eta_e .* lambda);
            B_e = 1 - (1 - P_e) .* (1 - eta_e .* lambda) .^ 2;

            % Success probability (4-fold coincidences)
            s1 = 1/8 .* ( ...
                (A_e + P_e - 2 .* A_e .* P_e) .^ 2 + ...
                P_e .* (1 - P_e) .* (B_e + P_e - 2 .* B_e .* P_e) );

            P_succ = 4 .* s1;

            % QBER evaluation
            a_e = 1/8 .* (P_e .^ 2 .* (1 - A_e) .^ 2 + A_e .^ 2 .* (1 - P_e) .^ 2);
            b_e = 1/8 .* (2 .* A_e .* P_e .* (1 - A_e) .* (1 - P_e));
            c_e = 1/8 .* P_e .* (1 - P_e) .* (P_e .* (1 - B_e) + B_e .* (1 - P_e));

            omega1 = c_e ./ (a_e + b_e);

            t_d = (q1 - q2) .^ 2 ./ sift_prob;
            t_e = (1 - 2 .* omega1) ./ (1 + 2 .* omega1);

            % Sifted rate
            sifted_rate = s1 .* rep_rate;

            % QBER including jitter
            qber_jitter = bob.Detector.QBER_Jitter;
            qber = 0.5 .* (1 - t_d .* t_e);
            qber = protocol.combineQBER(qber,qber_jitter);

            % QBER threshold where binary entropy equals 0.5
            q_thr = 0.1104;

            % Binary entropy function
            bin_ent = @(x) -x .* log2(x) - (1 - x) .* log2(1 - x);

            % Adjusted binary entropy associated with QBER
            R_2 = 1 - 2 .* bin_ent(qber);

            % Final secret key rate
            secret_rate = sift_prob .* P_succ .* R_2 .* proto.efficiency .* rep_rate;
            secret_rate = min(secret_rate, 1 / bob.Detector.Dead_Time);

            % Remove negative SKR values (due to high QBER)
            secret_rate(secret_rate < 0) = 0;
        end

    end

end