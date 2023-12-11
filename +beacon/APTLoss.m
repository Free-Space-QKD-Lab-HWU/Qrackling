%TODO: the same arguments block needs to be used in nodes/*loss.m functions
function loss = APTLoss(Receiver, Transmitter)
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

    loss = Transmitter.Beacon.GetAPTLoss(Receiver.Camera);

    n = max(Receiver.N_Position, Transmitter.N_Position);
    loss = utilities.validateLoss(loss, n);

end
