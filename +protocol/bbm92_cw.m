classdef bbm92_cw< protocol.proto
    properties (SetAccess = protected)
        method = 'prepare_and_measure'
        source_features = protocol.sourceRequirements.features('MPN_Signal', 'State_Prep_Error')
        detector_features = protocol.detectorRequirements.features('Dark_Count_Rate')
        efficiency = 0.5
        num_detectors = 4;
        coincidence_window = 1E-9;
    end

    methods
        function p = bbm92_cw()
        end

        function [sifted_rate, secret_rate, qber] = QkdModel( ...
            protocol, Alice, Bob, channel_loss, total_erroneous_counts)

            arguments
                protocol
                Alice {nodes.mustHaveSource(Alice)}
                Bob {nodes.mustHaveDetector(Bob)}
                channel_loss = []
                total_erroneous_counts = []
            end
            

            %% this computation is based on:
            %https://journals.aps.org/pra/pdf/10.1103/PhysRevA.104.022406
            
            %% eq1 define efficiencies to alice and bob (alice is assumed to be at the source)
            efficiency_alice = Alice.Detector.Detection_Efficiency;
            efficiency_bob = Bob.Detector.Detection_Efficiency.*channel_loss;

            % HACK: Brightness for a downconversion Source might require a 
            % little bit more information than just mean photon number and 
            % repetition rate, for now this will do.
            brightness = Alice.Source.MPN_Signal * Alice.Source.Repetition_Rate;

            %% eq2
            singles_alice = brightness .* efficiency_alice;
            singles_bob = brightness .* efficiency_bob;

            %% eq3
            coincidences = brightness .* efficiency_alice .* efficiency_bob;

            %% eq6
            singles_alice_measured = singles_alice ...
                + protocol.num_detectors * Alice.Detector.Dark_Count_Rate;
            singles_bob_measured = singles_bob + total_erroneous_counts;

            %% eq7
            mean_photons_per_coincidence_window_alice = ...
                singles_alice_measured.*protocol.coincidence_window;
            mean_photons_per_coincidence_window_bob = ...
                singles_bob_measured.*protocol.coincidence_window;

            %% eq8
            accidental_probability = ...
                (1-exp(-mean_photons_per_coincidence_window_alice)).*...
                (1-exp(-mean_photons_per_coincidence_window_bob));

            %% eq10
            coincidence_rate_accidental = ...
                accidental_probability ./ protocol.coincidence_window;

            %% eq11- windowing loss
            %windowing loss is a function of timing jitter at both
            %ends. we need the COMBINED timing jitter between the
            %detectors, which means we must convolve the two detector
            %jitter distributions
            
            %first, check that both detector datasets use the same time
            %base for their characterisation
            assert(Alice.Detector.Histogram_Bin_Width==Bob.Detector.Histogram_Bin_Width,...
                ['both detectors must have their jitter characterised using the same histogram bin width in order to convolve them\n' ...
                'This is a necessary part of the BBM92 CW protocol']);
            bin_width = Alice.Detector.Histogram_Bin_Width;
            %then, convolve detector jitters to find total timing delay
            %distribution
            total_jitter = conv(Alice.Detector.PDF,Bob.Detector.PDF);
            
            %figure out limits (in vector indexes) of the upcoming integral
            [~,jitter_mode_index] = max(total_jitter);
            window_start_index = max(jitter_mode_index - round((protocol.coincidence_window/2)/bin_width),1);
            window_end_index = min(jitter_mode_index + round((protocol.coincidence_window/2)/bin_width),numel(total_jitter));
            
            %integrate this jitter distribution for 1 coincidence window
            %around its (assumed single) mode to find the windowing loss
            windowing_loss = trapz(total_jitter(window_start_index:window_end_index));

            %% eq16
            coincidences_measured = (windowing_loss .* coincidences) ...
                + 0.5*coincidence_rate_accidental;

            coincidences_erroneous = ...
                (windowing_loss .* coincidences .* Alice.Source.State_Prep_Error) ...
                + (protocol.efficiency .* coincidence_rate_accidental);

            qber = coincidences_erroneous ./ coincidences_measured;


            %% eq19 we use asymptotic limit in Qrackling
            sifted_rate = protocol.efficiency.*coincidences_measured;
            secret_rate = protocol.efficiency.*coincidences_measured.*(1-2.1*utilities.binaryEntropy(qber));

        end
    end
end
