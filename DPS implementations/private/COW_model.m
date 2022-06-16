
function [SKR_COW_2008, SKR_COW_2020, QBER] = COW_model(MPN, extinction_ratio, rep_rate,...
    det_eff, prob_dark_counts, DCR, loss, qber_jitter, dead_time, decoy_prob, tB, V)

    f = 1.2;
    % For the 2020 analysis
    [K] = COW_zeroE_Attack(decoy_prob, MPN, det_eff, loss);

    % QBER
    p_noise     = prob_dark_counts;
    
    t   = 10.^(-loss/10);
    T   = t*tB*det_eff;
    R   = MPN.*T;
    Rs	= (R + p_noise*(1 - R)).*(1 - decoy_prob);

    R_sifted = 0.5*rep_rate*MPN*T + DCR;
    R_sifted = min(R_sifted, 1/dead_time);

    % QBER
    QBER_dark       =  0.5*(1 - R)*p_noise*(1 - decoy_prob)./Rs;
    QBER_jitter     =  qber_jitter;
    QBER_encoding   =  10^(-extinction_ratio/10);
    QBER    = min(QBER_dark + QBER_jitter + QBER_encoding, 0.5);
    
    % Privacy amplification stage
    Xcow = QBER + (1 - QBER).*H((1 + eps(MPN, V))/2);
    
    % SKR
    SKR_COW_2008 = R_sifted.*(1 - f*H(QBER) - Xcow);
    SKR_COW_2020 = R_sifted.*K.*(1 - f*H(QBER) - Xcow);

end

%% Utils functions
function [V_] = eps(mu,V)
    V_ = (2*V - 1)*exp(-mu) - 2*sqrt(V*(1 - V))*sqrt(1 - exp(-2*mu));
end

function [entropy] = H(x)
    if (x > 0 & x < 1)
        entropy = (-x.*log2(x) - (1 - x).*log2(1 - x));
    else
        entropy = 0;
    end
end

% From here, check references: 
function [K] = COW_zeroE_Attack(f, mu, eta_D, losses)
    % Calcultaion of the maximum trasnmittance of the channel for which a secure 
    % communication can happen
    [q_ss, ~, p_c] = USD(f, mu);

    Mmax = 10;
    [G_zeroV] = G_zero(f, q_ss, p_c, Mmax);

    % Upper bounds
    % As in reference, the best posible condition for Bob are set
    t_B = 1;
    p_d = 0;

    eta = 10.^(-losses/10);
    mu_max = zeros(1,length(eta));
    for eta_x = 1:length(eta)
        mu = 0;
        G = 1;
        G_zeroV = 0;
        while G > G_zeroV
            mu = mu + 1e-6;
                [q_ss, ~, p_c] = USD(f, mu);
                [G_zeroV] = G_zero(f, q_ss, p_c, Mmax);
            G = 1 - (1 - p_d)*((1 - f)*exp(-mu*t_B*eta_D*eta(eta_x)) + f*exp(-2*mu*t_B*eta_D*eta(eta_x)));
        end
        mu_max(eta_x) = mu;
    end
    K = (1 - f)*eta.*mu_max;
end

function [G_zero] = G_zero(f, q_ss, p_c, Mmax)
    x = 0;
    for k = 2:Mmax - 1
        x = x + p_c^k*(1-p_c)*p_click(f, q_ss, p_c, k);
    end
     x = x + p_c^Mmax*p_click(f, q_ss, p_c, Mmax);
    
    G_zero = (1 - p_c)/(1 - p_c^(Mmax + 1))*x;
end

function [p] = p_click(f, q_ss, p_c, k)
    p_1c    = ((1 - f)*q_ss)/(2*p_c);
    p       = (1/p_1c)*(-1 + (k + 1)*p_1c + ((1 - 2*p_1c)^k)*(1 + (k-1)*p_1c));
end

function [q_ss, q_sd, p_c] = USD(f, mu)
    % check that we are in the allowed region
    gamma = f/(2*(1-f));
    if (sqrt(gamma) <= exp(-mu/2))
        %disp('f and mu are set in the correct region for this simulation.');
        q_ss = 1 - exp(-mu);
        q_sd = 0;
    else
        %disp('f and mu are not set in the correct region for this simulation, check ref in comments.');
        q_ss = NaN;
        q_sd = NaN;
    end
    p_c = (1-f)*q_ss + f*q_sd;
end