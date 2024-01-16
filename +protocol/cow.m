classdef cow < protocol.proto
    properties (SetAccess = protected)
        method = 'prepare_and_measure'
        source_features = protocol.sourceRequirements.features( ...
            "MPN_Signal", ...
            "Probability_Signal", ...
            "Probability_Decoy", ...
            "State_Prep_Error")
        detector_features = protocol.detectorRequirements.features('Dark_Count_Rate', 'Time_Gate_Width',  'Visibility')
        efficiency = 1,
    end

    methods
        function protocol = cow()
        end

        % function [secret_key_rate, sifted_key_rate, qber] = QkdModel( ...
        %     proto, Source, Detector, prob_dark_counts, loss)
        function [secret_rate, sifted_rate, qber] = QkdModel(proto, Alice, Bob)

        %% written by Alfonso Tello Castillo - based on:
        % Chip-based quantum key distribution P. Sibson, C. Erven, M. Godfrey et al.
        %altered by Cameron Simmons
        % further altered by Peter Barrow

            MPN = Alice.source.MPN_Signal;
            State_Prep_Error = Alice.source.State_Prep_Error;
            rep_rate = Alice.source.Repetition_Rate;
            %decoy_prob = Alice.source.State_Probabilities(2);
            decoy_prob = Alice.source.Probability_Decoy;
            Dead_Time = Bob.detector.Dead_Time;

            %error correction efficiency
            f = 1.2;
            % Total absolute loss
            loss = Bob.channel_efficiency;
            T = 10.^(-loss/10);
            % average number of photons arriving at receiver per pulsee
            R = MPN .* T;
            % probability of pings at receiver
            prob_dark_counts = Bob.dark_count_probability;
            P_click = R + prob_dark_counts;

            % frequency of pings at the receiver
            Rate_In = 0.5 * R * rep_rate + prob_dark_counts * rep_rate;
            sifted_rate = min(Rate_In, 1/Dead_Time);

            %% qber totalling
            %Bob.detector = SetJitterPerformance(Bob.detector, Rates_In);
            qber_Jitter = Bob.detector.QBER_Jitter;
            qber_dark = 0.5 * prob_dark_counts ./ P_click;

            %each qber is a probability. These probabilities are independent
            %(coming from different sources). Therefore qbers add in union, in other 
            % words, the probability of an errorless bit (Quantum No Bit Error Rate 
            % QNBER) is the product of the probabilities of no errors from each source 
            qnber = (1 - qber_dark) * (1 - qber_Jitter) * (1 - State_Prep_Error);
            qber = 1 - qnber;

            %% Privacy amplification stage
            Visibility = ones(size(Bob.detector.Visibility));
            Visibility = Bob.detector.Visibility;
            Xcow = qber + (1 - qber).*H((1 + eps(MPN, Visibility))./2);

            % Secure key rate
            secret_rate = sifted_rate.*(1 - f*H(qber) - Xcow).*(1-decoy_prob)*proto.efficiency;
            % SKR cannot be negative
            secret_rate(secret_rate<0)=0;
        end
    end

end

% Utils functions
function [V_] = eps(mu,V)
    size(mu)
    size(V)
    V_ = (2 .* V - 1).*exp(-mu) - 2.*sqrt(V.*(1 - V)).*sqrt(1 - exp(-2*mu));
end

function [entropy] = H(p)
    assert( all(p >= 0 & p <= 1), ...
        'input to binary entropy function must be a valid probability' );
    entropy = -( p .* log2(p) + (1 - p) .* log2(1 - p) );
end

