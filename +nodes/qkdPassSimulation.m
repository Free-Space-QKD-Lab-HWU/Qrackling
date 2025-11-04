function results = qkdPassSimulation(receivers, transmitters, qkd_protocol)
% qkdPassSimulation
%
% Architects and executes a QKD pass simulation between transmitter-receiver pairs.
%
% Inputs:
% receivers     - array of QKD_Receiver or QKD_Transmitter objects with detectors
% transmitters  - array of QKD_Transmitter or QKD_Receiver objects with sources
% qkd_protocol  - protocol.proto object defining simulation logic
%
% Output:
% results - array of nodes.PassSimulationResult objects

    arguments
        receivers { ...
            nodes.mustBeReceiverOrTransmitter(receivers), ...
            nodes.mustHaveDetector(receivers) }
        transmitters { ...
            nodes.mustBeReceiverOrTransmitter(transmitters), ...
            nodes.mustHaveSource(transmitters)}
        qkd_protocol protocol.Proto
    end

    % Validate transmitter/receiver compatibility
    qkd_protocol.mustHaveCorrectTransmittersAndReceivers(transmitters, receivers)

    % Preallocate memory
    n_tx = qkd_protocol.num_transmitters;
    n_rx = qkd_protocol.num_receivers;

    loss_results = repmat(nodes.LossResult(), [n_tx, n_rx]);
    total_loss = zeros(n_tx, n_rx, 0);
    noise_results = repmat(environment.Noise('', []), [n_tx, n_rx, 0]);
    total_noise = zeros(n_tx, n_rx, 0);
    headings = zeros(n_tx, n_rx, 0);
    elevations = zeros(n_tx, n_rx, 0);
    ranges = zeros(n_tx, n_rx, 0);
    times = NaT(n_tx, n_rx, 0, 'TimeZone', 'UTC');
    elevation_flags = false(n_tx, n_rx, 0);
    link_directions = repmat(nodes.LinkDirection.Downlink, [n_tx, n_rx]);
    elevation_limits = zeros(1, n_rx);

    % Loop over transmitter-receiver pairs
    for rx_idx = 1:n_rx
        for tx_idx = 1:n_tx
            tx = transmitters(tx_idx);
            rx = receivers(rx_idx);

            % Determine link direction
            if utilities.isSubclassOf(tx, 'nodes.Satellite') && ...
               utilities.isSubclassOf(rx, 'nodes.GroundStation')
                link_directions(tx_idx, rx_idx) = nodes.LinkDirection.Downlink;
            elseif utilities.isSubclassOf(rx, 'nodes.Satellite') && ...
                   utilities.isSubclassOf(tx, 'nodes.GroundStation')
                link_directions(tx_idx, rx_idx) = nodes.LinkDirection.Uplink;
            else
                error('Unimplemented link configuration')
            end

            % Compute geometry
            switch link_directions(tx_idx, rx_idx)
                case nodes.LinkDirection.Downlink
                    [hdg, elev, rng] = relativeHeadingAndElevation(tx, rx);
                    t = tx.time;
                    elev_flag = elev > rx.elevation_limit;
                    elevation_limits(rx_idx) = receivers(rx_idx).elevation_limit;
                case nodes.LinkDirection.Uplink
                    [hdg, elev, rng] = relativeHeadingAndElevation(rx, tx);
                    t = rx.time;
                    elev_flag = elev > tx.elevation_limit;
                    elevation_limits(rx_idx) = transmitters(tx_idx).elevation_limit;
            end

            n_steps = numel(t);

            % Compute loss and noise
            [loss, noise] = lossAndNoiseForChannel(tx, rx, qkd_protocol);

            % Store results
            loss_results(tx_idx, rx_idx) = loss;
            total_loss(tx_idx, rx_idx, 1:n_steps) = loss.totalLoss;
            noise_results(tx_idx, rx_idx, 1:numel(noise)) = noise;
            total_noise(tx_idx, rx_idx, 1:n_steps) = noise.total;
            headings(tx_idx, rx_idx, 1:n_steps) = hdg;
            elevations(tx_idx, rx_idx, 1:n_steps) = elev;
            ranges(tx_idx, rx_idx, 1:n_steps) = rng;
            times(tx_idx, rx_idx, 1:n_steps) = t;
            elevation_flags(tx_idx, rx_idx, 1:n_steps) = elev_flag;
        end


    end

    % Identify valid time steps across all links
    all_elevation_flags = squeeze(all(elevation_flags, [1, 2]));
    total_loss_valid = total_loss(:, :, all_elevation_flags);
    total_noise_valid = total_noise(:, :, all_elevation_flags);

    % Evaluate QKD protocol
    secret_key_rate = zeros(1, n_steps);
    sifted_key_rate = zeros(1, n_steps);
    qber = 0.5 * ones(1, n_steps);

    [skr_valid, skt_valid, qber_valid] = qkd_protocol.calculate( ...
        transmitters, receivers, total_loss_valid, total_noise_valid);

    secret_key_rate(all_elevation_flags) = skr_valid;
    sifted_key_rate(all_elevation_flags) = skt_valid;
    qber(all_elevation_flags) = qber_valid;

    % Construct result objects
    results = repmat(nodes.PassSimulationResult.empty(), [n_tx, n_rx]);
    for rx_idx = 1:n_rx
        for tx_idx = 1:n_tx
            results(tx_idx, rx_idx) = nodes.PassSimulationResult( ...
                transmitters(tx_idx), ...
                receivers(rx_idx), ...
                qkd_protocol, ...
                link_directions(tx_idx, rx_idx), ...
                headings(tx_idx, rx_idx, :), ...
                elevations(tx_idx, rx_idx, :), ...
                ranges(tx_idx, rx_idx, :), ...
                times(tx_idx, rx_idx, :), ...
                all_elevation_flags, ...
                loss_results(tx_idx, rx_idx), ...
                noise_results(tx_idx, rx_idx, :), ...
                sifted_key_rate, ...
                secret_key_rate, ...
                qber);
        end
    end
end

function [loss_results, noise] = lossAndNoiseForChannel(transmitter, receiver, qkd_protocol)
% lossAndNoiseForChannel
%
% Computes loss and noise for a given transmitter-receiver pair.

    arguments
        transmitter (1, 1) { ...
            nodes.mustBeReceiverOrTransmitter(transmitter), ...
            nodes.mustHaveSource(transmitter) }
        receiver (1, 1) { ...
            nodes.mustBeReceiverOrTransmitter(receiver), ...
            nodes.mustHaveDetector(receiver) }
        qkd_protocol protocol.Proto
    end

    % Get background radiance
    switch class(transmitter)
        case "nodes.Satellite"
            [hdg, elev, ~] = transmitter.relativeHeadingAndElevation(receiver);
            background_radiance = receiver.environment.interp( ...
                "spectral_radiance", hdg, elev, transmitter.source.wavelength);
        case "nodes.GroundStation"
            [hdg, elev, ~] = receiver.relativeHeadingAndElevation(transmitter);
            background_radiance = transmitter.environment.interp( ...
                "spectral_radiance", hdg, elev, transmitter.source.wavelength);
    end

    % Filter width
    t = receiver.detector.spectral_filter.transmission;
    w = receiver.detector.spectral_filter.wavelengths;
    w_range = w(t ~= 0);
    filter_width = max(w_range) - min(w_range);

    % Background counts
    background_counts = environment.countRateFromRadiance( ...
        background_radiance, ...
        receiver.telescope.fov, ...
        receiver.telescope.diameter, ...
        filter_width, ...
        1, ...
        receiver.detector.wavelength);

    % Dark counts
    dark_counts = ones(size(hdg)) * receiver.detector.dark_count_rate * qkd_protocol.num_detectors;

    % Package noise
    noise = [environment.Noise("Background Counts", background_counts)
             environment.Noise("Detector Dark Counts", dark_counts)];


    % Compute losses
    [loss_results, ~] = nodes.linkLoss("qkd", ...
        receiver, transmitter);
    %here, if we wanted, we could specify which losses to simulate
end