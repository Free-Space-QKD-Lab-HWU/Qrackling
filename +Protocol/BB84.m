classdef BB84 < Protocol.protocolInterface
    methods (Hidden)

        function sourceRequirements(obj, source)
            arguments
                obj BB84
                source Source
            end
            [~] = obj;
            assert(source.Hasg2());
            assert(source.HasMeanPhotonNumber());
            assert(source.HasStatePrepError());
        end

        function detectorRequirements(obj, detector)
            arguments
                obj BB84
                detector Detector
            end
            [~] = obj;
            assert(detector.HasDarkCountRate());
            assert(detector.HasTimeGateWidth());
            assert(detector.HasDeadTime());
            assert(detector.HasPolarisationError());
        end

        function [sifted_key_rate, secure_key_rate, qber] = protocolImplementation(...
            obj, source, ...
            detector_alice, detector_bob, ...
            loss_alice, loss_bob, ...
            dark_counts_alice, dark_counts_bob)

            arguments
                obj BB84
                source Source
                detector_alice Detector
                detector_bob Detector
                loss_alice {mustBeNumeric}
                loss_bob {mustBeNumeric}
                dark_counts_alice {mustBeNumeric}
                dark_counts_bob {mustBeNumeric}
            end

            MPN = source.Mean_Photon_Number;
            g2 = source.g2;
            state_prep_error = source.State_Prep_Error;
            rep_rate = source.Repetition_Rate;

            % detection efficiency
            eta = detector.Detection_Efficiency;

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
            qber_jitter = detector.QBER_Jitter;
            qber_polarisation_error = sind(detector.Polarisation_Error);

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
            sifted_key_rate = rep_rate .* prot_eff .* prob_click;
            secret_key_rate = sifted_key_rate .* (beta .* tau - f .* bin_ent);
            secret_key_rate(secret_key_rate < 0) = 0; 
            % cs modification: output sifted key rate of zero in place of nan when 
            % calculation returns zero
            % altered 1/dead time limit to allow vectorised operation

            end

        end
end


