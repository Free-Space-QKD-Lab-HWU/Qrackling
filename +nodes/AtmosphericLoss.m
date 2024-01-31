function loss = AtmosphericLoss(kind, receiver, transmitter, environment)
    % Calculate the amount of loss contribution from the atmosphere between the
    % transmitter and receiver
    arguments
        kind {mustBeMember(kind, ["beacon", "qkd"])}
        receiver {mustBeA(receiver, ["nodes.Satellite", "nodes.Ground_Station"])}
        transmitter {mustBeA(transmitter, ["nodes.Satellite", "nodes.Ground_Station"])}
        environment Environment
    end

    % When we look at the original Satellite_Link_Model.m we can see that 
    % regardless of whether we are working with a downlink or uplink model the
    % elevations that we want to capture are always produced with:
    %   RelativeHeadingAndElevation(Satellite, Ground_Station);
    switch class(transmitter)
    case "nodes.Satellite"
        [headings, elevations, ~] = transmitter.RelativeHeadingAndElevation(receiver);
    case "nodes.Ground_Station"
        [headings, elevations, ~] = receiver.RelativeHeadingAndElevation(transmitter);
    end

    switch kind
    case "beacon"
        wavelength = transmitter.Beacon.Wavelength;
    case "qkd"
        wavelength = transmitter.Source.Wavelength;
    end

    loss = environment.Interp("attenuation", headings, elevations, wavelength);

    n = max(receiver.N_Position, transmitter.N_Position);
    loss = units.Loss("probability", "Atmospheric", utilities.validateLoss(loss, n));
end
