classdef dps < protocol.proto
    properties (SetAccess = protected)
        method = 'prepare_and_measure'
        source_features = protocol.sourceRequirements.features( ...
            'MPN_Signal', 'State_Prep_Error', 'Probability_Signal')
        detector_features = protocol.detectorRequirements.features( ...
            'Dark_Count_Rate', 'Time_Gate_Width', 'Dead_Time', 'QBER_Jitter')
        efficiency = 1
        num_detectors = 2;
    end

    methods
        function protocol = dps()
        end

        function [secret_rate, sifted_rate, qber] = QkdModel(proto, ...
            Alice, Bob, total_loss, total_background_count_rate)

            [~] = proto;

            rep_rate = Alice.Source.Repetition_Rate;
            eta = Bob.Detector.Detection_Efficiency;
            V = Bob.Detector.Visibility;
            mu = Alice.Source.MPN_Signal;
            prob_dark_counts = proto.BackgroundCountProbability( ...
                total_background_count_rate, Bob.Detector.Time_Gate_Width);
            f=1.2; % error correction efficiency

            T = total_loss * eta;
            sifted_prob = (mu * T + prob_dark_counts);
            sifted_rate = rep_rate *sifted_prob;

            qber_Visibility = (1 - V)/2;
            qber_dark = 0.5 * prob_dark_counts./sifted_prob;
            qber_encoding = Alice.Source.State_Prep_Error;
            
            %qbers add in inverse, so...
            %compute probability of no errors
            qnber = (1-qber_dark) * (1-qber_encoding) * (1-qber_Visibility);
            %then reverse into qber
            qber = 1-qnber;
            
            % Privacy amplification compression factor
            % tau = (1 - 2*mu)*log2(1 - qber.^2 - (1 - 6*qber).^2/2); % 2007 formula
            tau = qber + (1 - qber).*h((1 + eps(mu, V))/2); % 2008 formula
            %tau = h((3 + sqrt(5))*qber); % 2009 formula

            % Secret key rate
            secret_rate = sifted_rate.*(1 -f*h(qber) - real(tau)); % 2008 and 2009 analysis
            %skr must be nonnegative and real
            secret_rate(secret_rate<0&imag(secret_rate)==0)=0;
            %make skr real for plotting
            secret_rate=real(secret_rate);
        end

    end
end

function [V_] = eps(mu,V)
    V_ = (2*V - 1).*exp(-mu) - 2*sqrt(V.*(1 - V))*sqrt(1 - exp(-2*mu));
end

function y = h(x)
    %the binary entropy function
    y = -(x.*log2(x) + (1-x).*log2(1-x));
end
