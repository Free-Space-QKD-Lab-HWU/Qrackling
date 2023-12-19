function result = QkdPassSimulation(Receiver, Transmitter, proto, options)
arguments
    Receiver {mustBeA(Receiver, ["nodes.Satellite", "nodes.Ground_Station"]),nodes.mustHaveDetector(Receiver)}
    Transmitter {mustBeA(Transmitter, ["nodes.Satellite", "nodes.Ground_Station"]),nodes.mustHaveSource(Transmitter)}
    proto Protocol
    options.Background_Sources = []
end

%{
    takeFirst = @(array) array{end};
    node_string = @(node_obj) replace(takeFirst(strsplit(class(node_obj), ".")), "_", " ");
    node_name = @(node_obj) [node_string(node_obj), ': ' char(node_obj.Location_Name)];
%}
transmitter_name = utilities.node_name(Transmitter);
receiver_name = utilities.node_name(Receiver);

direction = nodes.LinkDirection.DetermineLinkDirection(Receiver, Transmitter);

switch direction
    case nodes.LinkDirection.Downlink
        [headings, elevations, ranges] = Transmitter.RelativeHeadingAndElevation(Receiver);
        elevation_limit_mask = elevations > Receiver.Elevation_Limit;
        times = Transmitter.Times;

        receiver_location = nodes.Located_Object();
        receiver_location = receiver_location.SetPosition( ...
            'Latitude', Receiver.Latitude, ...
            'Longitude', Receiver.Longitude, ...
            'Altitude', Receiver.Altitude);

        transmitter_location = nodes.Located_Object();
        transmitter_location = transmitter_location.SetPosition( ...
            'Latitude', Transmitter.Latitude, ...
            'Longitude', Transmitter.Longitude, ...
            'Altitude', Transmitter.Altitude);

    case nodes.LinkDirection.Uplink
        [headings, elevations, ranges] = Receiver.RelativeHeadingAndElevation(Transmitter);
        elevation_limit_mask = elevations > Transmitter.Elevation_Limit;
        times = Receiver.Times;

        receiver_location = nodes.Located_Object();
        receiver_location = receiver_location.SetPosition( ...
            'Latitude', Receiver.Latitude, ...
            'Longitude', Receiver.Longitude, ...
            'Altitude', Receiver.Altitude);

        transmitter_location = nodes.Located_Object();
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
visibility = nodes.Visibility(Receiver, Transmitter);
Receiver.Detector.Visibility = visibility(elevation_limit_mask);

[background_count_rate, ~] = Receiver.ComputeTotalBackgroundCountRate( ...
    options.Background_Sources, Transmitter, headings, elevations);

[link_loss, ~] = nodes.linkLoss("qkd", Receiver, Transmitter, ...
    "apt", "optical", "geometric", "turbulence", "atmospheric");

total_loss = link_loss.TotalLoss("dB");
total_loss_db = total_loss.As("dB");
total_loss_db(isnan(total_loss_db)) = 0;

[secret, qber, sifted] = proto.EvaluateQKDLink( ...
    Transmitter.Source, Receiver.Detector, ...
    [total_loss_db(elevation_limit_mask)], ...
    [background_count_rate(elevation_limit_mask)]);

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
result = nodes.PassSimulationResult( ...
    transmitter_name,     receiver_name, headings,         ...
    elevations,           ranges,        times,            ...
    elevation_limit_mask, communicating, line_of_sight,    ...
    link_loss,            total_loss,    sifted,           ...
    secret,               qber,          total_sifted_key, ...
    total_secret_key,     char(proto), direction, ...
    transmitter_location, receiver_location, background_count_rate);

end
