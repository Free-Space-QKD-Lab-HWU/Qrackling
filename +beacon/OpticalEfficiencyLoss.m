function eff = OpticalEfficiencyLoss(Receiver, Transmitter)
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

    eff = Transmitter.Beacon.Total_Efficiency * Receiver.Camera.Total_Efficiency;

    n = max(Receiver.N_Position, Transmitter.N_Position);
    eff = utilities.validateLoss(eff, n);

end
