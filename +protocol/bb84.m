classdef bb84 < protocol.proto
    properties
        source_features   = {'g2',              'Mean_Photon_Number', 'State_Prep_Error'}
        detector_features = {'Dark_Count_Rate', 'Time_Gate_Width',    'Dead_Time'}
        efficiency = 0.5
    end

    methods
        function protocol = bb84()
        end

        function [secret_key_rate, sifted_key_rate, qber] = QkdModel( ...
            proto, Source, Detector, prob_dark_counts, loss)
        % Function to compute sifted key rate and QBER of the BB84 protocol with
        % single photon sources
        % -------------------------------------------------------------------
        %
        % This function is written by either Alfonso or Ugo and modified by Cameron
        % it is based on the paper: Security aspects of quantum key distribution with
        % sub-Poisson light, Physical review letters,Waks, Edo, Santori, Charles, 
        % Yamamoto, Yoshihisa
        %
        % ########################################
        % INPUTS:
        %
        % MPN = mean photon number of the source
        % g2 = second order autocorrelation function [g^2(0)] (for a single-photon 
        %   source this should be zero)
        % state_prep_error = convolution of errors due to state preparation (as a fraction)
        % rep_rate = Repetition rate [Hz]
        % det_eff = Detection efficiency of receivers' detectors
        % prob_dark_counts = Probability of dark counts of receivers' detetcors
        % loss = Transmission loss [dB]
        % prot_eff = Protocol efficiency
        % qber_jitter = QBER contribution due to detectors' timing jitters
        %
        % OUTPUTS:
        %
        % sifted_key_rate = secure key rate [bit/s]
        % qber = QBER of the transmission system [%]
        % ########################################

            MPN = Source.Mean_Photon_Number;
            g2 = Source.g2;
            state_prep_error = Source.State_Prep_Error;
            rep_rate = Source.Repetition_Rate;

            % detection efficiency
            eta = Detector.Detection_Efficiency;

            % transmission channel's loss
            loss = 10.^(-loss/10);

            % probability of dark counts (Bob's detetcion stage - convolution of all 
            % detectors used by Bob)
            prob_dark = prob_dark_counts;

            % probability of a single detection event 
            prob_click = MPN * eta * loss+ prob_dark;

            % probability that the source generated more than one photon
            prob_multi = 0.5 * MPN.^2 * eta.^2 * g2;

            % fraction of detection events originating from single photons
            beta = (prob_click - prob_multi) ./ prob_click;

            %convolution of state preparation errors
            %( imperfect polarisation optics, channel dechoerence, imperfect state 
            % preparation )
            mu = state_prep_error;

            % probability of a signal event (Bob's estimation based on Alice's 
            % original signal)
            prob_signal = MPN * loss;

            % QBER
            % qber due to polarisation compensation error is the sine of the mean error
            % angle (in degrees)

            %Detector = SetJitterPerformance(Detector, Rate_In);
            qber_jitter = Detector.QBER_Jitter;
            qber_polarisation_error = sind(Detector.Polarisation_Error);

            % add up qbers. since small, neglect overlapping probabilities
            qber = (mu * prob_signal + prob_dark * 0.5) ./ prob_click + qber_jitter ...
                    + qber_polarisation_error;
            % CS modified qber cannot exceed 0.5
            qber(qber > 0.5) = 0.5;

            % compression function (account's for Eve's attacks on the raw quantum key)
            tau = -log2(0.5 + 2*qber./beta - 2*(qber./beta).^2);
            % cs modified if qber./beta>1+ a bit, then tau is complex. In this case 
            % tau should return 0
            tau(~(imag(tau)==0))=0;

            % function characterising the performance of the error correction algorithm
            % [f(QBER) is always >= 1 where the equality holds for a lossless/perfect 
            % algorithm], this has been extrapolated from the paper
            f = 1.366 .* qber + 1.117;

            % binary entropy function, a.k.a. h(x)
            bin_ent = -qber.*log2(qber) - (1-qber).*log2(1-qber);

            % secret key rate
            sifted_key_rate = rep_rate .* proto.efficiency .* prob_click;
            secret_key_rate = sifted_key_rate .* (beta .* tau - f .* bin_ent);
            secret_key_rate(secret_key_rate < 0) = 0; 
            % cs modification: output sifted key rate of zero in place of nan when 
            % calculation returns zero
            % altered 1/dead time limit to allow vectorised operation
        end

    end
end

