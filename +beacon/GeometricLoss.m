function loss = GeometricLoss(Receiver, Transmitter)
    arguments
        Receiver {mustBeA(Receiver, ["nodes.Satellite", "nodes.Ground_Station"])}
        Transmitter {mustBeA(Transmitter, ["nodes.Satellite", "nodes.Ground_Station"])}
    end

    if isempty(Transmitter.Beacon)
        error(['Transmitter.Beacon of ', inputname(1), ' must not be empty'])
    end

    if isempty(Receiver.Camera)
        error(['Receiver.Camera of ', inputname(2), ' must not be empty'])
    end

    link_length = receiver.location.ComputeDistanceBetween(transmitter.location);
    [loss, ~] = Transmitter.Beacon.GetGeoLoss(link_length, Receiver.Camera);

    shadowed = nodes.InEarthsShadow(Receiver.location, Transmitter.location);

    loss(shadowed) = 0;

    n = max(Receiver.N_Position, Transmitter.N_Position);
    loss = utilities.validateLoss(loss, n);
end
