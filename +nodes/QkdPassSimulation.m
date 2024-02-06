% TODO: adapt this to allow double up/down link comms
function result = QkdPassSimulation(Receiver, Transmitter, proto, options)
    arguments
        Receiver { ...
            mustBeA(Receiver, ["nodes.Satellite", "nodes.Ground_Station"]), ...
            nodes.mustHaveDetector(Receiver)}
        Transmitter { ...
            mustBeA(Transmitter, ["nodes.Satellite", "nodes.Ground_Station"]), ...
            nodes.mustHaveSource(Transmitter)}
        proto protocol.proto
        options.Environment environment.Environment = environment.Environment.empty
    end

    transmitter_name = utilities.node_name(Transmitter);
    receiver_name = utilities.node_name(Receiver);

    direction = nodes.LinkDirection.DetermineLinkDirection(Receiver, Transmitter);

    receiver_location = nodes.Located_Object();
    transmitter_location = nodes.Located_Object();
    switch direction
        case nodes.LinkDirection.Downlink
            [headings, elevations, ranges] = Transmitter.RelativeHeadingAndElevation(Receiver);
            elevation_limit_mask = elevations > Receiver.Elevation_Limit;
            times = Transmitter.Times;

            receiver_location = receiver_location.SetPosition( ...
                'Latitude', Receiver.Latitude, ...
                'Longitude', Receiver.Longitude, ...
                'Altitude', Receiver.Altitude);

            transmitter_location = transmitter_location.SetPosition( ...
                'Latitude', Transmitter.Latitude, ...
                'Longitude', Transmitter.Longitude, ...
                'Altitude', Transmitter.Altitude);

        case nodes.LinkDirection.Uplink
            [headings, elevations, ranges] = Receiver.RelativeHeadingAndElevation(Transmitter);
            elevation_limit_mask = elevations > Transmitter.Elevation_Limit;
            times = Receiver.Times;

            receiver_location = receiver_location.SetPosition( ...
                'Latitude', Receiver.Latitude, ...
                'Longitude', Receiver.Longitude, ...
                'Altitude', Receiver.Altitude);

            transmitter_location = transmitter_location.SetPosition( ...
                'Latitude', Transmitter.Latitude, ...
                'Longitude', Transmitter.Longitude, ...
                'Altitude', Transmitter.Altitude);

        case nodes.LinkDirection.Intersatellite
            %FIX: IMPLEMENT
            error("UNIMPLEMENTED")

        case nodes.LinkDirection.Terrestrial
            %FIX: IMPLEMENT
            error("UNIMPLEMENTED")
    end

    line_of_sight = elevations > 0;

    % [background_count_rate, ~] = Receiver.ComputeTotalBackgroundCountRate( ...
    %     options.Background_Sources, Transmitter, headings, elevations);

    if ~isempty(options.Environment)
        [link_loss, ~] = nodes.linkLoss("qkd", Receiver, Transmitter, ...
            "apt", "optical", "geometric", "turbulence", ...
            "atmospheric", "environment", options.Environment);

        switch class(Transmitter)
        case "nodes.Satellite"
            [headings, elevations, ~] = Transmitter.RelativeHeadingAndElevation(Receiver);
        case "nodes.Ground_Station"
            [headings, elevations, ~] = Receiver.RelativeHeadingAndElevation(Transmitter);
        end

        % NOTE: why does this need "abs" around headings and elevations?
        % NOTE: SOLVED: add in mask by elevation limit (or other equivalent)
        % NOTE: mask by elevation >= 0
        background_radiance = options.Environment.Interp( ...
            "spectral_radiance", abs(headings), abs(elevations), Transmitter.Source.Wavelength);

        t = Receiver.Detector.Spectral_Filter.transmission;
        w = Receiver.Detector.Spectral_Filter.wavelengths;
        w_range = w(t ~= 0);
        filter_width = max(w_range) - min(w_range)

        background_counts_per_second = environment.countRateFromRadiance( ...
            background_radiance, ...
            Receiver.Telescope.FOV, ...
            Receiver.Telescope.Diameter, ...
            filter_width, ...
            1, ...
            Receiver.Detector.Wavelength);

    else
        [link_loss, ~] = nodes.linkLoss("qkd", Receiver, Transmitter, ...
            "apt", "optical", "geometric", "turbulence");
        background_counts_per_second = zeros(size(headings));
    end

    noise_sources = [ ...
        environment.Noise( ...
            "Detector Dark Counts", ...
            ones(size(headings)) .* Receiver.Detector.Dark_Count_Rate), ...
        environment.Noise( ...
            "Background Counts", ...
            background_counts_per_second) ...
    ];

    total_loss = link_loss.TotalLoss("dB");
    total_loss_db = total_loss.As("dB");
    total_loss_db(isnan(total_loss_db)) = 0;

    % TODO: include reflected light off satellite surface in noise calculation
    % background_counts_per_second needs to be extended to include the other
    % sources of background light
    secret = zeros(size(elevations));
    sifted = secret;
    qber = secret;
    [secret_masked, sifted_masked, qber_masked] = proto.Calculate( ...
        Transmitter, Receiver, total_loss_db(elevation_limit_mask), "dB", background_counts_per_second(elevation_limit_mask));
    %pad key rates to fit
    secret(elevation_limit_mask) = secret_masked;
    sifted(elevation_limit_mask) = sifted_masked;
    qber(elevation_limit_mask) = qber_masked;

    %qber(~elevation_limit_mask) = nan;
    communicating =  ~(isnan(secret) | (secret <= 0));

    time_window_widths = times([false, communicating(1:end-1)]) - times(communicating(2:end));
    if isempty(time_window_widths)
        warning('no communication occurs in this simulation')
        total_sifted_key = 0;
        total_secret_key = 0;
    else
        if isnumeric(time_window_widths)
            total_sifted_key = dot(time_window_widths, sifted(communicating(1:end-1)));
            total_secret_key = dot(time_window_widths, secret(communicating(1:end-1)));
        elseif isduration(time_window_widths)
            time_seconds = seconds(time_window_widths);
            total_sifted_key = dot(time_seconds, sifted(communicating(1:end-1)));
            total_secret_key = dot(time_seconds, secret(communicating(1:end-1)));
        end
    end

    proto_str = class(proto);

    result = nodes.PassSimulationResult( ...
        transmitter_name,     receiver_name,     headings,         ...
        elevations,           ranges,            times,            ...
        elevation_limit_mask, communicating,     line_of_sight,    ...
        link_loss,            total_loss,        sifted,           ...
        secret,               qber,              total_sifted_key, ...
        total_secret_key,     proto_str,         direction,        ...
        transmitter_location, receiver_location, noise_sources);

end
