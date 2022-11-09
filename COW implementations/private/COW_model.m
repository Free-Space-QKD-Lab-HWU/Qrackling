%% written by Alfonso Tello Castillo- based on:
% Chip-based quantum key distribution
% P. Sibson, C. Erven, M. Godfrey et al.

%altered by Cameron Simmons
% further altered by Peter Barrow
function [SKR_COW_2008, QBER, R_In, R_Det] = COW_model(MPN, ...
                                                       State_Prep_Error, ...
                                                       rep_rate, ...
                                                       prob_dark_counts, ...
                                                       loss, ...
                                                       QBER_Jitter, ...
                                                       dead_time, ...
                                                       decoy_prob, ...
                                                       V, ...
                                                       Detector)

    %error correction efficiency
    f = 1.2;
    % Total absolute loss
    T = 10.^(-loss/10);
    % average number of photons arriving at receiver per pulsee
    R = MPN.*T;
    % probability of pings at receiver
    P_click = R + prob_dark_counts;
    
    % frequency of pings at the receiver
    Rates_In = 0.5 * R * rep_rate + prob_dark_counts * rep_rate;
    %R_sifted = min(R_sifted, 1/dead_time);
    R_sifted = dead_time_corrected_count_rate(Rates_In, dead_time, 1);
    Rates_Det = R_sifted

    %% QBER totalling
    Detector = SetJitterPerformance(Detector, Rates_In);
    QBER_Jitter = Detector.QBER_Jitter;
    QBER_dark = 0.5 * prob_dark_counts ./ P_click;
    
    %each QBER is a probability. These probabilities are independent
    %(coming from different sources). Therefore QBERs add in union, in other 
    % words, the probability of an errorless bit (Quantum No Bit Error Rate 
    % QNBER) is the product of the probabilities of no errors from each source 
    QNBER = (1 - QBER_dark) * (1 - QBER_Jitter) * (1 - State_Prep_Error);
    QBER = 1 - QNBER;
    
    %% Privacy amplification stage
    Xcow = QBER + (1 - QBER).*H((1 + eps(MPN, V))/2);                      
    
    % Secure key rate
    SKR_COW_2008 = R_sifted.*(1 - f*H(QBER) - Xcow).*(1-decoy_prob);
    % SKR cannot be negative
    SKR_COW_2008(SKR_COW_2008<0)=0;
end

% Utils functions
function [V_] = eps(mu,V)
    V_ = (2*V - 1)*exp(-mu) - 2*sqrt(V*(1 - V))*sqrt(1 - exp(-2*mu));
end

function [entropy] = H(p)
    assert( all(p >= 0 & p <= 1), ...
        'input to binary entropy function must be a valid probability' );

    entropy = -( p .* log2(p) + (1 - p) .* log2(1 - p) );
end
