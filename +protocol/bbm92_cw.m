classdef bbm92_cw
    properties (SetAccess = protected)
        method = 'prepare_and_measure'
        source_features = protocol.sourceRequirements.features('Mean_Photon_Number', 'Coincidence_Window', 'State_Prep_Error')
        detector_features = protocol.detectorRequirements.features('Dark_Count_Rate')
        efficiency = 0.5
    end

    methods
        function [sift, secret, qber] = bbm92_cw(alice, bob, loss, bgr)
            arguments
                alice { ...
                    mustBeA(alice, ["nodes.Satellite", "nodes.Ground_Station"]), ...
                    nodes.mustHaveDetector(alice)}
                bob { ...
                    mustBeA(bob, ["nodes.Satellite", "nodes.Ground_Station"]), ...
                    nodes.mustHaveSource(bob)}
                loss nodes.LossResult
                bgr % background_counts
                end
            [~] = {alice, bob};
            % some rule about single up/down
            % other rule about double up OR double down
            % some rule about arb. topo.
        end

        function [sifted_rate, secret_rate, qber] = QkdModel( ...
            protocol, Alice, Bob, dark_count_prob, channel_loss)

            arguments
                protocol
                Alice { ...
                    mustBeA(Alice, ["protocol.Alice", "nodes.Satellite", "nodes.Ground_Station"]), ...
                    nodes.mustHaveSource(Alice)}
                Bob { ...
                    mustBeA(Bob, ["protocol.Bob", "nodes.Satellite", "nodes.Ground_Station"]), ...
                    nodes.mustHaveDetector(Bob)}
                dark_count_prob = []
                channel_loss = []
            end

            % if Alice is not a protocol.Alice, then cast it
            if ~isa(Alice, "protocol.Alice")
                Alice = Alice.Alice();
            end

            % if Bob is not a protocol.Bob, then cast it
            if ~isa(Bob, "protocol.Bob")
                Bob = Bob.Bob();
            end

            timing_imprecision = 1;
            bit_error = 0;
            phase_error = 0;

            efficiency_alice = Alice.detector.Detection_Efficiency .* Alice.channel_efficiency;
            efficiency_bob = Bob.detector.Detection_Efficiency .* Bob.channel_efficiency;

            % HACK: Brightness for a downconversion source might require a 
            % little bit more information than just mean photon number and 
            % repetition rate, for now this will do.
            brightness = Alice.source.Mean_Photon_Number * Alice.source.Repetition_Rate;

            singles_alice = brightness .* efficiency_alice;
            singles_bob = brightness .* efficiency_bob;
            coincidences = brightness .* efficiency_alice .* efficiency_bob;

            singles_alice_measured = singles_alice ...
                + Alice.detector.Dark_Count_Rate ...
                + Alice.background_count_rate;

            singles_bob_measured = singles_bob ...
                + Bob.detector.Dark_Count_Rate ...
                + Bob.background_count_rate;

            AccidentalProbability = @(singles) 1 - exp( ...
                -1 .* (singles .* Alice.source.Coincidence_Window));

            accidental_probability = ...
                AccidentalProbability(singles_alice_measured) ...
                .* AccidentalProbability(singles_bob_measured);

            coincidences_accidental = ...
                accidental_probability ./ Alice.source.Coincidence_Window;

            windowing_loss = erf(...
                sqrt(log(2)) ...
                .* (Alice.source.Coincidence_Window ./ timing_imprecision));

            coincidences_measured = (windowing_loss .* coincidences) ...
                + coincidences_accidental;

            coincidences_erroneous = ...
                (windowing_loss .* coincidences .* Alice.source.State_Prep_Error) ...
                + (sifting_rate .* coincidences_accidental);

            qber = coincidences_erroneous ./ coincidences_measured;

            % FIX: Ideally we need to separate bit-flip and phase error for 
            % correct calculation of secret key rate, this raises the question 
            % of whether eq17 or eq19 from the source paper is more suitable

            postprocessed_rate = sifting_rate .* coincidences_measured;

            bit_entropy = utilities.binaryEntropy(bit_error);
            phase_entropy = utilities.binaryEntropy(phase_error);

            secret_rate = postprocessed_rate .* (1 ...
                - (error_correction_efficiency .* bit_entropy) ...
                - phase_entropy);

            sifted_rate = coincidences_measured;

        end
    end
end
