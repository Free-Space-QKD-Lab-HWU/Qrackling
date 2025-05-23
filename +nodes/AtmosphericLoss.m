function loss = AtmosphericLoss(kind, receiver, transmitter, direction)
    % Calculate the amount of loss contribution from the atmosphere between the
    % transmitter and receiver
    arguments
        kind {mustBeMember(kind, ["beacon", "qkd"])}
        receiver {mustBeA(receiver, ["nodes.Satellite", "nodes.Ground_Station"])}
        transmitter {mustBeA(transmitter, ["nodes.Satellite", "nodes.Ground_Station"])}
        direction nodes.LinkDirection
    end

    % When we look at the original Satellite_Link_Model.m we can see that 
    % regardless of whether we are working with a downlink or uplink model the
    % elevations that we want to capture are always produced with:
    %   RelativeHeadingAndElevation(Satellite, Ground_Station);
    switch direction
        case nodes.LinkDirection.Downlink
        [headings, elevations, ~] = transmitter.RelativeHeadingAndElevation(receiver);
        environment = receiver.Environment;
        case nodes.LinkDirection.Uplink
        [headings, elevations, ~] = receiver.RelativeHeadingAndElevation(transmitter);
        environment = transmitter.Environment;
    end

    switch kind
    case "beacon"
        wavelength = transmitter.Beacon.Wavelength;
    case "qkd"
        wavelength = transmitter.Source.Wavelength;
    end

    % NOTE: why does this need "abs" around headings and elevations?
    % NOTE: SOLVED: add in mask by elevation limit (or other equivalent)
    % NOTE: mask by elevation >= 0
    loss = environment.Interp("attenuation", abs(headings), abs(elevations), wavelength);

    if any(isnan(loss))
        loss(isnan(loss)) = 1;
    end

    n = max(receiver.N_Position, transmitter.N_Position);
    loss = units.Loss(loss);
end
