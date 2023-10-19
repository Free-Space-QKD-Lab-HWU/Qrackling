classdef BBM92_Pulsed < Protocol.protocolInterface
    methods (Hidden)
        function sourceRequirements(obj, source)
            arguments
                obj
                source Source
            end
            [~] = obj;
            assert(source.HasMeanPhotonNumber());
        end

        function detectorRequirements(obj, detector)
            arguments
                obj
                detector Detector
            end
            [~] = obj;
            assert(detector.HasDarkCountRate());
        end

        function [sifted_rate, secure_rate, qber] = protocolImplementation( ...
            obj, source, ...
            detector_alice, detector_bob, ...
            loss_alice, loss_bob, ...
            background_counts_alice, background_counts_bob, ...
            sifting_rate, error_correction_efficiency)

            % From: Ma, X., Fung, C-H. F., et al. (2007), Quantum Key ...
            % Distribution with Entangled Photon Sources, ...
            % 10.1103/PhysRevA.76.012307.

            arguments
                obj
                source Source {mustBeNonempty}
                detector_alice Detector {mustBeNonempty}
                detector_bob Detector {mustBeNonempty}
                loss_alice {mustBeNumeric}
                loss_bob {mustBeNumeric}
                background_counts_alice {mustBeNumeric}
                background_counts_bob {mustBeNumeric}
                sifting_rate {mustBeNumeric} = 0.5
                error_correction_efficiency {mustBeNumeric} = 1.1
            end

            lambda = source.Mean_Photon_Number ./ 2;

            mpn_alice = loss_alice .* lambda;
            mpn_bob = loss_bob .* lambda;
            mpn_combined = loss_alice .* loss_bob .* lambda;

            invers_prob_alice = 1 - background_probability_alice;
            invers_prob_bob = 1 - background_probability_bob;

            a = invers_prob_alice / ((1 + mpn_alice) .^ 2);
            b = invers_prob_bob / ((1 + mpn_bob) .^ 2);
            c = (invers_prob_alice .* invers_prob_bob) ...
                ./ ((1 + mpn_alice + mpn_bob - mpn_combined) .^ 2);

            gain = 1 - a - b + c;

            error_random = 0.5; % background count error rate
            error_detection = 1; % photon arrives at the wrong detector

            a = 2 .* (error_random - error_detection) .* mpn_combined .* (1 + lambda);
            b = (1 + mpn_alice) .* (1 + mpn_bob) .* ...
                (1 + mpn_alice + mpn_bob - mpn_combined);

            % TODO: is this correct, from the paper they have QBER (E_lambda) and then 
            % derive E_lambda Q_lambda (qber * gain). So should the gain be removed?
            qber_gain = (error_random .* gain) - (a ./ b);
            qber = qber_gain ./ gain;

            reconciliation_factor = 0.5;
            error_correction_efficiency = 1; % f(x)

            error_bit = 1;
            error_phase = 1;

            secret_key_rate = reconciliation_factor .* gain .* (...
                1 - (error_correction_efficiency .* Protocol.utils.BinaryEntropy(error_bit)) ...
                - Protocol.utils.BinaryEntropy(error_phase));

        end
    end
end
