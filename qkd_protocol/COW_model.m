%% written by Alfonso Tello Castillo- based on:
% Chip-based quantum key distribution
% P. Sibson, C. Erven, M. Godfrey et al.

%altered by Cameron Simmons
% further altered by Peter Barrow

% function [SKR_COW_2008, QBER, Sifted_Key_Rate] = COW_model(MPN, ...
%                                                        State_Prep_Error, ...
%                                                        rep_rate, ...
%                                                        prob_dark_counts, ...
%                                                        loss, ...
%                                                        decoy_prob, ...
%                                                        Detector)

function [SKR_COW_2008, QBER, Sifted_Key_Rate] = COW_model( ...
        Source, prob_dark_counts, loss, protocol_efficiency, Detector)

    MPN = Source.Mean_Photon_Number;
    State_Prep_Error = Source.State_Prep_Error;
    rep_rate = Source.Repetition_Rate;
    decoy_prob = Source.State_Probabilities(2);
    Dead_Time = Detector.Dead_Time;
    
    %error correction efficiency
    f = 1.2;
    % Total absolute loss
    T = 10.^(-loss/10);
    % average number of photons arriving at receiver per pulsee
    R = MPN.*T;
    % probability of pings at receiver
    P_click = R + prob_dark_counts;

    % frequency of pings at the receiver
    Rate_In = 0.5 * R * rep_rate + prob_dark_counts * rep_rate;
    Sifted_Key_Rate = min(Rate_In, 1/Dead_Time);
    

    %% QBER totalling
    %Detector = SetJitterPerformance(Detector, Rates_In);
    QBER_Jitter = Detector.QBER_Jitter;
    QBER_dark = 0.5 * prob_dark_counts ./ P_click;

    %each QBER is a probability. These probabilities are independent
    %(coming from different sources). Therefore QBERs add in union, in other 
    % words, the probability of an errorless bit (Quantum No Bit Error Rate 
    % QNBER) is the product of the probabilities of no errors from each source 
    QNBER = (1 - QBER_dark) * (1 - QBER_Jitter) * (1 - State_Prep_Error);
    QBER = 1 - QNBER;

    %% Privacy amplification stage
    Xcow = QBER + (1 - QBER).*H((1 + eps(MPN, Detector.Visibility))/2);

    % Secure key rate
    SKR_COW_2008 = R_sifted.*(1 - f*H(QBER) - Xcow).*(1-decoy_prob)*protocol_efficiency;
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
