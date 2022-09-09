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


% From thesis "(2005) Xiongfeng Ma - Security of Quantum Key Distribution with Realistic Devices",
% although these equations are fairly known

function [SKR_decoyBB84, QBER] = decoyBB84_model(MPN, State_p, state_prep_error, rep_rate,...
    det_eff, prob_dark_counts, loss, prot_eff, qber_jitter, dead_time, polarisation_error)
        % Probability of having a detection
        pD        = (MPN.*State_p)'*10.^(-loss/10).*det_eff + prob_dark_counts;

        QBER_cod        = state_prep_error;
        QBER_noise      = 0.5*prob_dark_counts./pD;
        QBER_jitter     = qber_jitter;
        QBER_polarisation_error=sind(polarisation_error);                    %QBER due to polarisation misalignment (in degrees)
        
        % To avoid that due to QBER_cod and QBER_jitter (fixed) the QBER
        % can go higher than 50%, which doesn't make sense
        QBER = min(QBER_cod + QBER_noise + QBER_jitter + QBER_polarisation_error, 0.5);

        % Estimation of the Secret Key Rate
        pM_weak = photonDetc(MPN(2)*State_p(2), 2, 10.^(-loss/10).*det_eff, prob_dark_counts)';
        pS_weak = pD(2,:) - pM_weak - prob_dark_counts*exp(-MPN(2)*State_p(2));
        QBERs = (QBER(2,:).*pD(2,:) - 0.5*prob_dark_counts*exp(-MPN(2)*State_p(2)))./pS_weak;

        pS_signal = photonDetc(MPN(1)*State_p(1), 1, 10.^(-loss/10).*det_eff, prob_dark_counts);

        f = 1.2;
        R = prot_eff*(-pD(1,:)*f.*H(QBER(1,:)) + pS_signal.*(1 - H(QBERs)));
        R_sifted = rep_rate*R;
        SKR_decoyBB84 = min(R_sifted, 1/dead_time);
        SKR_decoyBB84(isnan(R_sifted)) = NaN;

        %% modification cjs
        %SKR cannot be negative. negative results should be replaced by
        %zero
        SKR_decoyBB84(SKR_decoyBB84<0)=0;
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
        prob = (1 - (1-t').^n).*(mu.^n)./factorial(n)*exp(-mu);
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