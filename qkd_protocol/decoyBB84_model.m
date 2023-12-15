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

function [SKR_decoyBB84, QBER, Sifted_Key_Rate] = decoyBB84_model( ...
    Source, prob_dark_counts, loss, prot_eff, Detector)

    %% get variables from source object
    MPN = Source.Mean_Photon_Number;
    State_p = Source.State_Probabilities;
    rep_rate = Source.Repetition_Rate;
    state_prep_error = Source.State_Prep_Error;

    %% get variables from detector object
    det_eff = Detector.Detection_Efficiency;
    QBER_jitter = Detector.QBER_Jitter;
    %QBER due to polarisation misalignment (in degrees)
    QBER_polarisation_error = sind(Detector.Polarisation_Error);


    Detection_Probability = (MPN .* State_p)' * 10.^(-(loss) / 10) .* det_eff + prob_dark_counts;

    QBER_cod = state_prep_error;
    QBER_noise = 0.5 * prob_dark_counts ./ Detection_Probability;
    %QBER_jitter = qber_jitter;
    %Detector = SetJitterPerformance(Detector, sum(pD) * rep_rate);

    % To avoid that due to QBER_cod and QBER_jitter (fixed) the QBER
    % can go higher than 50%, which doesn't make sense
    QBER = min(QBER_cod + QBER_noise ...
               + QBER_jitter + QBER_polarisation_error, ...
               0.5);

    % Estimation of the Secret Key Rate
    pM_weak = photonDetc(MPN(2) * State_p(2), 2, 10.^(-loss/10) .* det_eff, prob_dark_counts)';
    pS_weak = Detection_Probability(2,:) - pM_weak - prob_dark_counts * exp(-MPN(2) * State_p(2));
    QBERs = (QBER(2,:) .* Detection_Probability(2,:) ...
             - 0.5 * prob_dark_counts * exp(-MPN(2) * State_p(2))) ./ pS_weak;

    pS_signal = photonDetc(MPN(1) * State_p(1), 1, ...
                           10.^(-loss / 10) .* det_eff, prob_dark_counts);

    f = 1.2;

    %% this is the key generation rate
    Ideal_Secret_Key_Rate = prot_eff * ( -Detection_Probability(1,:) * f .* H(QBER(1,:) ) ...
                    + pS_signal .* ( 1 - H(QBERs) ) );

    Sifted_Key_Rate = pS_signal*prot_eff*rep_rate;

    %SKR_decoyBB84 = min(R_sifted, 1/dead_time);
    %disp([num2str(R), ' ', num2str(SKR_decoyBB84), ' ', num2str(test)]);
    %SKR_decoyBB84 = R_sifted;

    %SKR_decoyBB84 = dead_time_corrected_count_rate(rep_rate * Ideal_Secret_Key_Rate, tau1, tau2, 1);
    SKR_decoyBB84 = min(rep_rate * Ideal_Secret_Key_Rate, 1 / Detector.Dead_Time);
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

