classdef BBM92CW < protocol.Proto
% BBM92CW
%
% Implements the continuous-wave BBM92 quantum key distribution protocol.
% This version models coincidence detection and timing jitter effects.
%
% Syntax:
% Output = protocol.Bbm92Cw(Input1, Input2, …)
%
% Based on:
% https://journals.aps.org/pra/pdf/10.1103/PhysRevA.104.022406

    properties (SetAccess = protected)
        method = 'prepare_and_measure'

        source_features = protocol.SourceRequirements.features( ...
            'MPN_Signal', 'Local_Loss', 'State_Prep_Error')

        detector_features = protocol.DetectorRequirements.features( ...
            'Dark_Count_Rate')

        efficiency = 0.5
        num_detectors = 4
        name = 'Continuous Wave BBM92'

        num_transmitters = 1
        num_receivers = 1
    end

    properties (SetAccess = public)
        coincidence_window = 1E-9
    end

    methods
        function p = BBM92CW()
        end

        function [secret_rate, sifted_rate, qber] = qkdModel( ...
                protocol, Alice, Bob, channel_loss, total_erroneous_counts)
        % qkdModel
        %
        % Computes the sifted and secret key rates for the CW BBM92 protocol.
        % Includes effects of timing jitter, accidental coincidences, and
        % state preparation errors.
        %
        % Syntax:
        % [secret_rate, sifted_rate, qber] = protocol.bbm92_cw.qkdModel(...)
        %
        % Inputs:
        % Alice, Bob - Transmitter and receiver nodes
        % channel_loss - (1x1) double, transmission loss
        % total_erroneous_counts - (1x1) double, background counts
        %
        % Outputs:
        % secret_rate - (1x1) double, secure key rate [bit/s]
        % sifted_rate - (1x1) double, sifted key rate [bit/s]
        % qber - (1x1) double, quantum bit error rate [%]

            arguments
                protocol
                Alice {nodes.mustHaveSource(Alice)}
                Bob {nodes.mustHaveDetector(Bob)}
                channel_loss = []
                total_erroneous_counts = []
            end

            %% Efficiency calculations
            efficiency_alice = Alice.source.local_loss ...
                * Alice.detector.detection_efficiency;

            efficiency_bob = Bob.detector.detection_efficiency ...
                .* channel_loss;

            %% Source brightness
            brightness = Alice.source.repetition_rate;

            %% Singles and coincidences
            singles_alice = brightness .* efficiency_alice;
            singles_bob = brightness .* efficiency_bob;
            coincidences = brightness .* efficiency_alice .* efficiency_bob;

            %% Measured singles
            singles_alice_measured = singles_alice ...
                + protocol.num_detectors * Alice.detector.dark_count_rate;

            singles_bob_measured = singles_bob + total_erroneous_counts;

            %% Mean photons per coincidence window
            mean_photons_per_coincidence_window_alice = ...
                singles_alice_measured .* protocol.coincidence_window;

            mean_photons_per_coincidence_window_bob = ...
                singles_bob_measured .* protocol.coincidence_window;

            %% Accidental coincidence probability
            accidental_probability = ...
                (1 - exp(-mean_photons_per_coincidence_window_alice)) ...
                .* (1 - exp(-mean_photons_per_coincidence_window_bob));

            %% Accidental coincidence rate
            coincidence_rate_accidental = ...
                accidental_probability ./ protocol.coincidence_window;

            %% Timing jitter convolution
            assert(Alice.detector.histogram_bin_width ...
                == Bob.detector.histogram_bin_width, ...
                ['Both detectors must use the same histogram bin width ' ...
                 'to convolve jitter distributions.']);

            bin_width = Alice.detector.histogram_bin_width;
            total_jitter = conv(Alice.detector.pdf, Bob.detector.pdf);

            [~, jitter_mode_index] = max(total_jitter);
            window_start_index = max(jitter_mode_index ...
                - round((protocol.coincidence_window / 2) / bin_width), 1);

            window_end_index = min(jitter_mode_index ...
                + round((protocol.coincidence_window / 2) / bin_width), ...
                numel(total_jitter));

            windowing_loss = trapz( ...
                total_jitter(window_start_index:window_end_index)*...
                Alice.detector.histogram_bin_width.*...
                Bob.detector.histogram_bin_width);

            %% Measured coincidences
            coincidences_measured = (windowing_loss .* coincidences) ...
                + 0.5 * coincidence_rate_accidental;

            coincidences_erroneous = ...
                (windowing_loss .* coincidences .* Alice.source.state_prep_error) ...
                + (protocol.efficiency .* coincidence_rate_accidental);

            qber = coincidences_erroneous ./ coincidences_measured;

            %% Key rates
            sifted_rate = protocol.efficiency .* coincidences_measured;

            secret_rate = protocol.efficiency .* coincidences_measured ...
                .* (1 - 2.1 * utilities.binaryEntropy(qber));

            secret_rate(secret_rate < 0) = 0;
        end
    end
end