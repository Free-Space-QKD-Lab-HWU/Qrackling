classdef cow < protocol.proto
    properties
        source_features   = {'Mean_Photon_Number', 'State_Prep_Error', 'State_Probabilities'}
        detector_features = {'Dark_Count_Rate',    'Time_Gate_Width',  'Visibility'}
        efficiency = 1,
    end

    methods
        function protocol = cow()
        end

        function [secret_key_rate, sifted_key_rate, qber] = QkdModel( ...
            proto, Source, Detector, prob_dark_counts, loss)

        %% written by Alfonso Tello Castillo- based on:
        % Chip-based quantum key distribution
        % P. Sibson, C. Erven, M. Godfrey et al.
        %altered by Cameron Simmons
        % further altered by Peter Barrow

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
            sifted_key_rate = min(Rate_In, 1/Dead_Time);

            %% qber totalling
            %Detector = SetJitterPerformance(Detector, Rates_In);
            qber_Jitter = Detector.qber_Jitter;
            qber_dark = 0.5 * prob_dark_counts ./ P_click;

            %each qber is a probability. These probabilities are independent
            %(coming from different sources). Therefore qbers add in union, in other 
            % words, the probability of an errorless bit (Quantum No Bit Error Rate 
            % QNBER) is the product of the probabilities of no errors from each source 
            qnber = (1 - qber_dark) * (1 - qber_Jitter) * (1 - State_Prep_Error);
            qber = 1 - qnber;

            %% Privacy amplification stage
            Xcow = qber + (1 - qber).*H((1 + eps(MPN, Detector.Visibility))/2);

            % Secure key rate
            secret_key_rate = sifted_key_rate.*(1 - f*H(qber) - Xcow).*(1-decoy_prob)*proto.efficiency;
            % SKR cannot be negative
            secret_key_rate(secret_key_rate<0)=0;
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

    end
end
