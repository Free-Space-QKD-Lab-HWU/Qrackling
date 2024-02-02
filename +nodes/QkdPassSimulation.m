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
        options.Environment environment.Environment = []
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

    interferometer_visibility = nodes.Visibility(Receiver, Transmitter);
    Receiver.Detector.Visibility = interferometer_visibility(elevation_limit_mask);

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

        solar_radiance = options.Environment.Interp( ...
            "spectral_radiance", headings, elevations, Transmitter.Source.Wavelength);

        t = Receiver.Detector.Spectral_Filter.transmission;
        w = Receiver.Detector.Spectral_Filter.wavelengths;
        w_range = w(t ~= 0);
        filter_width = max(w_range) - min(w_range);

        background_counts_per_second = environment.countRateFromRadiance( ...
            solar_radiance, ...
            Receiver.Telescope.FOV, ...
            Receiver.Telescope.Diameter, ...
            Receiver.Detector.Wavelength, ...
            filter_width, ...
            1);

    else
        [link_loss, ~] = nodes.linkLoss("qkd", Receiver, Transmitter, ...
            "apt", "optical", "geometric", "turbulence");
        background_counts_per_second = [];
    end

    total_loss = link_loss.TotalLoss("dB");
    total_loss_db = total_loss.As("dB");
    total_loss_db(isnan(total_loss_db)) = 0;

    % TODO: include reflected light off satellite surface in noise calculation
    % background_counts_per_second needs to be extended to include the other
    % sources of background light
    [secret, sifted, qber] = proto.Calculate( ...
        Transmitter, Receiver, total_loss_db, "dB", ...
        proto.BackgroundCountProbability(background_counts_per_second, Receiver.Detector.Time_Gate_Width));

    %qber(~elevation_limit_mask) = nan;
    communicating =  ~(isnan(secret) | (secret <= 0));

    size(times)
    size(communicating)
    size(times(communicating))
    size(times([false, communicating(1:end-1)]))
    %time_window_widths = times([false, communicating(1:end)]) - times(communicating);
    %FIX: this is buggy, what are we doing here, do we just want the difference between odd and even indices?
    time_window_widths = times([false, communicating(1:end-1)]) - times(communicating(2:end));
    if isempty(time_window_widths)
        warning('no communication occurs in this simulation')
        total_sifted_key = 0;
        total_secret_key = 0;
    else

        if isnumeric(time_window_widths)
            total_sifted_key = dot(time_window_widths, sifted(communicating));
            total_secret_key = dot(time_window_widths, secret(communicating));
        elseif isduration(time_window_widths)
            time_seconds = seconds(time_window_widths);
            total_sifted_key = dot(time_seconds, sifted(communicating));
            total_secret_key = dot(time_seconds, secret(communicating));
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
        transmitter_location, receiver_location, background_count_rate);

end
