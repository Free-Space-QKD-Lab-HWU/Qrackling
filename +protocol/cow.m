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
        num_detectors = 2;
    end

    methods
        function protocol = cow()
        end

        % function [secret_key_rate, sifted_key_rate, qber] = QkdModel( ...
        %     proto, Source, Detector, prob_dark_counts, loss)
        function [secret_rate, sifted_rate, qber] = QkdModel(proto, ...
            Alice, Bob, total_loss, total_background_count_rate)

        %% written by Alfonso Tello Castillo - based on:
        % Chip-based quantum key distribution P. Sibson, C. Erven, M. Godfrey et al.
        % altered by Cameron Simmons
        % further altered by Peter Barrow

            MPN = Alice.Source.MPN_Signal;
            State_Prep_Error = Alice.Source.State_Prep_Error;
            rep_rate = Alice.Source.Repetition_Rate;
            decoy_prob = Alice.Source.Probability_Decoy;
            Dead_Time = Bob.Detector.Dead_Time;

            %error correction efficiency
            f = 1.2;
            % Total absolute loss
            T = total_loss;
            % average number of photons arriving at receiver per pulsee
            R = MPN .* T;
            % probability of pings at receiver
            prob_dark_counts = proto.BackgroundCountProbability(total_background_count_rate,Bob.Detector.Time_Gate_Width);
            P_click = R + prob_dark_counts;

            % frequency of pings at the receiver
            Rate_In = 0.5 * R * rep_rate + prob_dark_counts * rep_rate;
            sifted_rate = min(Rate_In, 1/Dead_Time);

            %% qber totalling
            %Bob.Detector = SetJitterPerformance(Bob.Detector, Rates_In);
            qber_Jitter = Bob.Detector.QBER_Jitter;
            qber_dark = 0.5 * prob_dark_counts ./ P_click;

            %each qber is a probability. These probabilities are independent
            %(coming from different Sources). Therefore qbers add in union, in other 
            % words, the probability of an errorless bit (Quantum No Bit Error Rate 
            % QNBER) is the product of the probabilities of no errors from each Source 
            qnber = (1 - qber_dark) * (1 - qber_Jitter) * (1 - State_Prep_Error);
            qber = 1 - qnber;

            %% Privacy amplification stage
            % Visibility = ones(size(Bob.Detector.Visibility));
            Visibility = Bob.Detector.Visibility;
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
    V_ = (2 .* V - 1).*exp(-mu) - 2.*sqrt(V.*(1 - V)).*sqrt(1 - exp(-2*mu));
end

function [entropy] = H(p)
    assert( all(p >= 0 & p <= 1), ...
        'input to binary entropy function must be a valid probability' );
    entropy = -( p .* log2(p) + (1 - p) .* log2(1 - p) );
end

