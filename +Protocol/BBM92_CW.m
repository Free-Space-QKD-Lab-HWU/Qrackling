classdef BBM92_CW < Protocol.protocolInterface
    methods (Hidden)
        function sourceRequirements(obj, source)
            arguments
                obj
                source Source
            end
            [~] = obj;
            assert(source.HasMeanPhotonNumber());
            assert(source.HasCoincidenceWindow());
            assert(source.HasStatePrepError());
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

            % From: Neumann, S. P., Scheidl, T., et al. (2021), Model for ...
            % Optimizing Quantum Key Distribution with Continuous-Wave ...
            % Pumped Entangled-Photon Sources, 10.1103/PhysRevA.104.022406.

            arguments
                obj
                source Source {mustBeNonempty}
                detector_alice Detector {mustBeNonempty}
                detector_bob Detector {mustBeNonempty}
                loss_alice {mustBeNumeric} = []
                loss_bob {mustBeNumeric} = []
                background_counts_alice {mustBeNumeric} = []
                background_counts_bob {mustBeNumeric} = []
                sifting_rate {mustBeNumeric} = []
                error_correction_efficiency {mustBeNumeric} = []
            end

            if isempty(sifting_rate)
                sifting_rate = 0.5;
            end

            if isempty(error_correction_efficiency)
                error_correction_efficiency = 1.1;
            end

            %disp(source);
            %disp(detector_alice);
            %disp(detector_bob);
            disp(loss_alice);
            disp(loss_bob);
            disp(background_counts_alice);
            disp(background_counts_bob);
            disp(sifting_rate);
            disp(error_correction_efficiency);

            [~] = obj;
            timing_imprecision = 1;
            bit_error = 0;
            phase_error = 0;

            efficiency_alice = detector_alice.Detection_Efficiency .* loss_alice;
            efficiency_bob = detector_bob.Detection_Efficiency .* loss_bob;

            % HACK: Brightness for a downconversion source might require a little bit
            % more information than just mean photon number and repetition rate, for 
            % now this will do.
            brightness = source.Mean_Photon_Number * source.Repetition_Rate;

            singles_alice = brightness .* efficiency_alice;
            singles_bob = brightness .* efficiency_bob;
            coincidences = brightness .* efficiency_alice .* efficiency_bob;

            singles_alice_measured = singles_alice ...
                + detector_alice.Dark_Count_Rate ...
                + background_counts_alice;

            singles_bob_measured = singles_bob ...
                + detector_bob.Dark_Count_Rate ...
                + background_counts_bob;

            AccidentalProbability = @(singles) 1 - exp( ...
                -1 .* (singles .* source.Coincidence_Window));

            accidental_probability = ...
                AccidentalProbability(singles_alice_measured) ...
                .* AccidentalProbability(singles_bob_measured);

            coincidences_accidental = ...
                accidental_probability ./ source.Coincidence_Window;

            windowing_loss = erf(...
                sqrt(log(2)) ...
                .* (source.Coincidence_Window ./ timing_imprecision));

            coincidences_measured = (windowing_loss .* coincidences) ...
                + coincidences_accidental;

            coincidences_erroneous = ...
                (windowing_loss .* coincidences .* source.State_Prep_Error) ...
                + (sifting_rate .* coincidences_accidental);

            qber = coincidences_erroneous ./ coincidences_measured;

            % FIX: Ideally we need to separate bit-flip and phase error for correct
            % calculation of secret key rate, this raises the question of whether eq17
            % or eq19 from the source paper is more suitable

            postprocessed_rate = sifting_rate .* coincidences_measured;

            bit_entropy = Protocol.utils.BinaryEntropy(bit_error);
            phase_entropy = Protocol.utils.BinaryEntropy(phase_error);

            secure_rate = postprocessed_rate .* (1 ...
                - (error_correction_efficiency .* bit_entropy) ...
                - phase_entropy);

            sifted_rate = coincidences_measured;

        end

    end
end
