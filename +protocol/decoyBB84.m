classdef decoyBB84 < protocol.proto
    properties (SetAccess = protected)
        method = 'prepare_and_measure'
        source_features = protocol.sourceRequirements.features( ...
            "MPN_Signal", "Probability_Signal", ...
            "MPN_Decoy",  "Probability_Decoy",  ...
            "State_Prep_Error")
        detector_features = protocol.detectorRequirements.features("Dark_Count_Rate", "Time_Gate_Width", "Dead_Time")
        efficiency = 0.5,
    end

    methods
        function protocol = decoyBB84()
        end

        function [SKR_decoyBB84, Sifted_Key_Rate, QBER] = QkdModel(proto, ...
            alice, bob, total_loss, prob_dark_counts) %FIX: need gate width otherwise
                %alice, bob, total_loss, total_background_count_rate)

        %% Function -- BB84Decoy_model
        % Author    -- Alfonso Tello Castillo
        % Date      -- July 2020
        % Function to compute sifted key rate and QBER of the BB84 decoy state protocol
        % -------------------------------------------------------------------
        %
        % BB84Decoy_model(MPN, State_p, state_prep_error, rep_rate,...
        %   det_eff, prob_dark_counts, loss, prot_eff, qber_jitter, dead_time)
        %
        % ########################################
        % INPUTS:
        % 
        % MPN = mean photon number per state (must be row vector)
        % State_p = probability of each state (must be row vector)
        % state_prep_error = convolution of errors due to state preparation (as a fraction)
        % rep_rate = Repetition rate [Hz]
        % det_eff = Detection efficiency of receivers' detectors
        % prob_dark_counts = Probability of dark counts of receivers' detetcors
        % loss = Transmission loss [dB]
        % prot_eff = Protocol efficiency
        % qber_jitter = QBER contribution due to detectors' timing jitters
        % dead_time = Dead time of the detector
        % 
        % OUTPUTS:
        % 
        % SKR_decoyBB84 = secure key rate [bit/s]
        % qber = QBER of the transmission system [%]
        % ########################################
        % From thesis "(2005) Xiongfeng Ma - Security of Quantum Key Distribution with 
        % Realistic Devices", although these equations are fairly known

            rep_rate = alice.Source.Repetition_Rate;
            state_prep_error = alice.Source.State_Prep_Error;

            %loss = bob.channel_efficiency;
            loss = total_loss .* bob.Detector.Detection_Efficiency;
            %prob_dark_counts = proto.BackgroundCountProbability(total_background_count_rate);

            %% get variables from Detector object
            %det_eff = bob.Detector.Detection_Efficiency;
            QBER_jitter = bob.Detector.QBER_Jitter;
            %QBER due to polarisation misalignment (in degrees)
            QBER_polarisation_error = sind(bob.Detector.Polarisation_Error);

            %Detection_Probability = (MPN .* State_p)' * loss + prob_dark_counts;
            mpn = [alice.Source.MPN_Signal, alice.Source.MPN_Decoy, alice.Source.MPN_Vacuum];
            state_probability = [ ...
                alice.Source.Probability_Signal, ...
                alice.Source.Probability_Decoy, ...
                alice.Source.Probability_Vacuum];

            emission = mpn .* state_probability;
            detection_probabilities = emission' .* loss + prob_dark_counts;

            QBER_cod = state_prep_error;
            QBER_noise = 0.5 * prob_dark_counts ./ detection_probabilities;
            %QBER_jitter = qber_jitter;
            %bob.Detector = SetJitterPerformance(bob.Detector, sum(pD) * rep_rate);

            % To avoid that due to QBER_cod and QBER_jitter (fixed) the QBER
            % can go higher than 50%, which doesn't make sense
            QBER = min(...
                QBER_cod + QBER_noise + QBER_jitter + QBER_polarisation_error, ...
                0.5);

            % Estimation of the Secret Key Rate
            pM_weak = photonDetc(emission(2), 2, loss, prob_dark_counts)';
            pS_weak = detection_probabilities(2,:) - pM_weak - prob_dark_counts * exp(-emission(2));

            QBERs = (QBER(2,:) .* detection_probabilities(2,:) ...
                - 0.5 * prob_dark_counts * exp(-emission(2))) ./ pS_weak;

            pS_signal = photonDetc(emission(1), 1, loss, prob_dark_counts);

            f = 1.2;

            %% this is the key generation rate
            Ideal_Secret_Key_Rate = proto.efficiency * ( -detection_probabilities(1,:) * f .* H(QBER(1,:) ) + pS_signal .* ( 1 - H(QBERs) ) );

            Sifted_Key_Rate = pS_signal * proto.efficiency * rep_rate;

            %SKR_decoyBB84 = min(R_sifted, 1/dead_time);
            %disp([num2str(R), ' ', num2str(SKR_decoyBB84), ' ', num2str(test)]);
            %SKR_decoyBB84 = R_sifted;

            SKR_decoyBB84 = min(rep_rate * Ideal_Secret_Key_Rate, 1 / bob.Detector.Dead_Time);
            %SKR_decoyBB84 = R;
            %disp(SKR_decoyBB84);
            %SKR_decoyBB84(isnan(R_sifted)) = NaN;
            SKR_decoyBB84(isnan(SKR_decoyBB84)) = NaN;
            %% modification cjs
            %do not allow negative SKR
            SKR_decoyBB84(SKR_decoyBB84<0)=0;

            %% modification cjs
            %SKR cannot be negative. negative results should be replaced by
            %zero
            %SKR_decoyBB84(SKR_decoyBB84 < 0)=0;
            %disp(sum(SKR_decoyBB84));
            %output only signal state QBER
            QBER=QBER(1,:);
        end

    end
end

function [prob] = photonDetc(mu, n, t, p_dark)
    % if n == 1, probability of single photon detection
    if n == 1
        prob = (1 - (1-t).^n)*(mu^n)/factorial(n)*exp(-mu) + p_dark*mu*exp(-mu);
    % if n > 1, probability of multiphoton detection
    else
        n = 2:5;
        prob = (1 - (1-t').^n).* (mu.^n)./factorial(n)*exp(-mu);
        prob = (sum(prob,2)' + p_dark*(1 - (1 + mu)*exp(-mu)))';
    end
end

function [entropy] = H(x)
    if (x > 0 & x < 1)
        entropy = (-x.*log2(x) - (1 - x).*log2(1 - x));
    else
        entropy = NaN;
    end
end
