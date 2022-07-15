%% written by Alfonso Tello Castillo- based on:
% Chip-based quantum key distribution
% P. Sibson, C. Erven, M. Godfrey et al.

%altered by Cameron Simmons
function [SKR_COW_2008, QBER] = COW_model(MPN, State_Prep_Error, rep_rate, prob_dark_counts, loss, QBER_Jitter, dead_time, decoy_prob, V)



    f = 1.2;                                                               %error correction efficiency
    T   = 10.^(-loss/10);                                                  %Total absolute loss
    R   = MPN.*T;                                                          %average number of photons arriving at receiver per pulsee

    R_sifted = 0.5*rep_rate*R + prob_dark_counts*rep_rate;                 % rate of pings at receiver
    R_sifted = min(R_sifted, 1/dead_time);

    %% QBER totalling
    QBER_dark       =  0.5*prob_dark_counts;
    
    %each QBER is a probability. These probabilities are independent
    %(coming from different sources). Therefore QBERs add in union

    %in other words, the probability of an errorless bit (Quantum No Bit Error Rate QNBER) is the product of the probabilities of no errors from each source 
    QNBER=(1-QBER_dark)*(1-QBER_Jitter)*(1-State_Prep_Error);
    QBER=1-QNBER;
    
    %% Privacy amplification stage
    Xcow = QBER + (1 - QBER).*H((1 + eps(MPN, V))/2);                      
    
    %% Secure key rate
    SKR_COW_2008 = R_sifted.*(1 - f*H(QBER) - Xcow).*(1-decoy_prob);       %secure key rate
    SKR_COW_2008(SKR_COW_2008<0)=0;                                        %SKR cannot be negative
end

%% Utils functions
function [V_] = eps(mu,V)
    V_ = (2*V - 1)*exp(-mu) - 2*sqrt(V*(1 - V))*sqrt(1 - exp(-2*mu));
end

function [entropy] = H(x)
    if (x >= 0 & x <= 1)
        entropy = (-x.*log2(x) - (1 - x).*log2(1 - x));
    else
        error('input to binary entropy function must be a valid probability');
    end
end