function eff = TransmitterLoss(kind, transmitter)
    arguments
        kind {mustBeMember(kind, ["beacon", "qkd"])}
        transmitter {mustBeA(transmitter, ["nodes.Satellite", "nodes.Ground_Station"])}
    end

    switch kind
    case "beacon"
        if isempty(transmitter.Beacon)
            error(['Transmitter.Beacon of ', inputname(1), ' must not be empty'])
        end

        eff = transmitter.Beacon.Total_Efficiency;

    case "qkd"
        %% sources of efficiency
        eff = transmitter.Source.Efficiency ...
            * transmitter.Telescope.Optical_Efficiency;
    end

    n = transmitter.N_Position;
    eff = units.Loss("probability", "Transmitter", utilities.validateLoss(eff, n));
end
