% TODO: adapt this to allow double up/down link comms
function result = QkdPassSimulation(Receiver, Transmitter, proto, ...
        type, data_wavelengths, data_headings, data_elevations, data, unit, options)
    arguments
        Receiver { ...
            mustBeA(Receiver, ["nodes.Satellite", "nodes.Ground_Station"]), ...
            nodes.mustHaveDetector(Receiver)}
        Transmitter { ...
            mustBeA(Transmitter, ["nodes.Satellite", "nodes.Ground_Station"]), ...
            nodes.mustHaveSource(Transmitter)}
        proto protocol.proto
    end
    arguments (Repeating)
        type {mustBeMember(type, {"transmission", "background_emission"})}
        data_wavelengths (1, :) {mustBeNumeric}
        data_headings (1, :) {mustBeNumeric}
        data_elevations (1, :) {mustBeNumeric}
        data (:, :) {mustBeNumeric}
        unit {mustBeMember(unit, {"probability", "dB", "Hz/m^2/sr", "W/m^2/sr/nm"})}
    end
    arguments
        options.Headings (1, :) ...
            {mustBeNumeric, mustBeInRange(options.Headings, 0, 360)} = linspace(0, 360, 91)
        options.Elevations (1, :) ...
            {mustBeNumeric, mustBeInRange(options.Elevations, 0, 90)} = linspace(0, 90, 46)
        options.Environment Environment = []
        % options.Background_Sources = []
        % options.Visibility = '50km'
    end

    % first we need to determine the dimensions of our transmission and elevation
    % data. This is either set by the environment or by the repeating args.

    default_headings = options.Headings;
    default_elevations = options.Elevations;

    if ~isempty(options.Environment)
        default_headings = options.Environment.headings;
        default_elevations = options.Environment.elevations;
    end

    mapped_data = {};

    for i = 1:numel(type)
        mapped = environment.mapToEnvironment( ...
            data_headings,    data_elevations,    data, ...
            default_headings, default_elevations, ...
            Wavelength=data_wavelengths);
        mapped_data{i} = mapped;

        switch type{i}
        case "transmission"
            switch unit{i}
            case "probability"
                continue
            case "dB"
                % TODO: convert
            end
        case "background_emission"
            switch unit{i}
            case "Hz/M^2/sr" % "counts"
            case "W/m^2/sr/nm" % "power"
                continue
            end
        end
    end

    transmitter_name = utilities.node_name(Transmitter);
    receiver_name = utilities.node_name(Receiver);

    direction = nodes.LinkDirection.DetermineLinkDirection(Receiver, Transmitter);

    receiver_location = nodes.Located_Object();
    transmitter_location = nodes.Located_Object();
    % TODO: include reflected light off satellite surface in noise calculation
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

    % TODO: what is this?
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
            [headings, elevations, ~] = transmitter.RelativeHeadingAndElevation(receiver);
        case "nodes.Ground_Station"
            [headings, elevations, ~] = receiver.RelativeHeadingAndElevation(transmitter);
        end
        solar_radiance = options.Environment.Interp( ...
            "spectral_radiance", headings, elevations, Receiver.Source.Wavelength);
        background_counts_per_second = utilities.skyPhotons(...
            solar_radiance, ...
            Receiver.Telescope.FOV, ...
            Receiver.Telescope.Diameter, ...
            Receiver.Source.Wavelength, ...
            1);
    else
        [link_loss, ~] = nodes.linkLoss("qkd", Receiver, Transmitter, ...
            "apt", "optical", "geometric", "turbulence");
    end

    total_loss = link_loss.TotalLoss("dB");
    total_loss_db = total_loss.As("dB");
    total_loss_db(isnan(total_loss_db)) = 0;

    [secret, sifted, qber] = proto.Calculate( ...
        Transmitter, Receiver, total_loss_db, "dB", total_background_counts);

    %[secret, qber, sifted] = proto.EvaluateQKDLink( ...
    %    Transmitter.Source, Receiver.Detector, ...
    %    [total_loss_db(elevation_limit_mask)], ...
    %    [background_count_rate(elevation_limit_mask)]);

    %secret(~elevation_limit_mask) = 0; %outside elevation window == no comms
    %sifted(~elevation_limit_mask) = 0;

    %qber(~elevation_limit_mask) = nan;
    communicating =  ~(isnan(secret) | (secret <= 0));

    time_window_widths = times([false, communicating(1:end)]) - times(communicating);
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
