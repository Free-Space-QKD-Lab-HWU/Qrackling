function [sifted_key_rate, qber] = ekart92_model(rep_rate, det_eff, prob_dark_counts, loss, prot_eff, ...
    qber_jitter, dead_time)

% Function to compute sifted key rate and QBER of the E92 protocol
% -------------------------------------------------------------------
%
% ekart92_model(rep_rate, det_eff, prob_dark_counts, loss, prot_eff)
%
% ########################################
% INPUTS:
% 
% rep_rate = Repetition rate [Hz]
% det_eff = Detection efficiency of receivers' detectors
% prob_dark_counts = Probability of dark counts of receivers' detetcors
% loss = Transmission loss (dB)
% prot_eff = Protocol efficiency
% 
% OUTPUTS:
% 
% sifted_key_rate = secure key rate [bit/s]
% qber = QBER of the transmission system [%]
% ########################################


% Intermidiate step to compute key variables
% ###################################################
P_d = 0;
eta_d = 1;

A_d = eta_d + (1-eta_d).*P_d;
q1 = (1-P_d) .* A_d;
q2 = (1-A_d) .* P_d;
q3 = P_d .* A_d;

% sift probability , a.k.a. probability of 
% successful entangled cross-correlations
sift_prob = (q1 + q2 + q3).^2;
% ###################################################




% Using notation from the paper where the model is presented
% ###################################################
% prob of dark counts
P_e = prob_dark_counts;
% detection efficiency
if det_eff > 1
    eta_e = det_eff / 100;
else
    eta_e = det_eff;
end

lambda = 10.^(-loss./10);
A_e = eta_e.*lambda + P_e.*(1-eta_e.*lambda);
B_e = 1 - (1-P_e).*(1-eta_e.*lambda).^2;
s1 = 1/8 .* ((A_e + P_e -2.*A_e.*P_e).^2 + P_e.*(1 - P_e).*(B_e + P_e - 2.*B_e.*P_e));

% success probability, a.k.a. probability of
% successfully establishing a connection between parties
% (the 4 might have to do with the 4-fold coincidences of the protocol)
P_succ = 4.*s1;
% ###################################################




% Evaluation of QBER
% ###################################################
a_e = 1/8 .* (P_e.^2.*(1-A_e).^2 + A_e.^2.*(1-P_e).^2);
b_e = 1/8 .* (2.*A_e.*P_e.*(1-A_e).*(1-P_e));
c_e = 1/8 .* P_e.*(1-P_e) .* (P_e.*(1-B_e) + B_e.*(1-P_e));
omega1 = c_e ./ (a_e + b_e);

t_d = (q1 - q2).^2 ./ sift_prob;
t_e = (1-2.*omega1) ./ (1+2.*omega1);

% QBER
qber = 1/2 .* (1-t_d.*t_e);
qber = qber + qber_jitter;
% QBER threshold is defined as the value for which the binary entropy
% equals 1/2
q_thr = 0.1104;
% ###################################################





% ###################################################

% binary entropy function, a.k.a. h_2(x)
bin_ent = @(x) -x.*log2(x) - (1-x).*log2(1-x);

% Adjusted binary entropy associated with the QBER
R_2 = 1 - 2.*bin_ent(qber);

% ###################################################


% Final sifted key rate
sifted_key_rate = sift_prob .* P_succ .* R_2 .* prot_eff .* rep_rate;
sifted_key_rate = min(sifted_key_rate, 1/dead_time);

% Marking the values where the sifted key rate is negative as Nan
% (when the QBER is above q_thr the R_2 variable becomes negative
% hence the sifted key rate becomes negative)
sifted_key_rate(sifted_key_rate < 0) = nan;

end