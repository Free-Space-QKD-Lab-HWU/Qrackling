function result = QkdPassSimulation(Receiver, Transmitter, proto, options)
    arguments
        Receiver {mustBeA(Receiver, ["nodes.Satellite", "nodes.Ground_Station"])}
        Transmitter {mustBeA(Transmitter, ["nodes.Satellite", "nodes.Ground_Station"])}
        proto Protocol
        options.Background_Sources
    end

    % For correct [headings, elevations, ranges] we always want to get the 
    % relative coordinates from the Satellite to the Ground_Station, since we 
    % don't which is which we switch on the Transmitter
    switch class(Transmitter)
    case "nodes.Satellite"
        [headings, elevations, ranges] = ...
            Transmitter.RelativeHeadingAndElevation(Receiver);
        elevation_limit_mask = elevations > Receiver.Elevation_Limit;
    case "nodes.Ground_Station"
        [headings, elevations, ranges] = ...
            Receiver.RelativeHeadingAndElevation(Transmitter);
        elevation_limit_mask = elevations > Transmitter.Elevation_Limit;
    end

    % FIX: we need to properly define the assumptions around which element 
    % should have timestamps
    if any(contains(properties(Receiver), "Times"))
        times = Receiver.Times;
    elseif any(contains(properties(Transmitter), "Times"))
        times = Transmitter.Times;
    else
        error("no timestamps in either transmitter or reciever");
    end

    if any(contains(options, "Background_Sources"))
        [background_count_rate, ~] = ...
            Receiver.ComputeTotalBackgroundCountRate( ...
                options.Background_Sources, ...
                Transmitter, ...
                Headings, ...
                Elevations ...
            );
    end

    line_of_sight = elevations > 0;

    % TODO: what is this?
    visibility = nodes.Visibility(link.receiver, link.transmitter);
    Receiver.Detector.Visibility = visibility(elevation_limit_mask);

    [link_loss, link_extras] = nodes.linkLoss("qkd", hogs, spoqc, ...
        "apt", "optical", "geometric", "turbulence", "atmospheric", "dB", true);
    total_loss_db = link_extras.total_loss;

    [secret, qber, sifted] = proto.EvaluateQKDLink( ...
        Transmitter.Source, Receiver.Detector, ...
        [total_loss_db(elevation_limit_mask)], ...
        [background_count_rate(elevation_limit_mask)]); % TODO: need an empty array for background_count_rate to default to

    secret(~elevation_limit_mask) = 0; %outside elevation window == no comms
    sifted(~elevation_limit_mask) = 0;

    qber(~elevation_limit_mask) = nan;
    communicating = ~( isnan(secret) || (secret <= 0) );

    time_windows = times([false, communicating(1:end-1)]) - times(communicating);
    assert(~isempty(time_windows), "no time windows"); % not sure what correct error should be

    if isnumeric(time_windows)
        total_sifted_key = dot(time_windows, sifted(communicating(1:end-1)));
        total_secret_key = dot(time_windows, secret(communicating(1:end-1)));
    elseif isduration(time_windows)
        time_seconds = seconds(time_windows);
        total_sifted_key = dot(time_seconds, sifted(communicating(1:end-1)));
        total_secret_key = dot(time_seconds, secret(communicating(1:end-1)));
    end

    result = nodes.PassSimulationResult( ...
        headings,         elevations,           ranges,        ...
        times,            elevation_limit_mask, communicating, ...
        line_of_sight,    link_loss,            total_loss_db, ...
        sifted,           secret,               qber,          ...
        total_sifted_key, total_secret_key);

end
