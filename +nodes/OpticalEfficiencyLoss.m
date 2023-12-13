function eff = OpticalEfficiencyLoss(kind, receiver, transmitter)
    arguments
        kind {mustBeMember(kind, ["beacon", "qkd"])}
        receiver {mustBeA(receiver, ["nodes.Satellite", "nodes.Ground_Station"])}
        transmitter {mustBeA(transmitter, ["nodes.Satellite", "nodes.Ground_Station"])}
    end

    switch kind
    case "beacon"
        if isempty(transmitter.Beacon)
            error(['Transmitter.Beacon of ', inputname(1), ' must not be empty'])
        end

        if isempty(receiver.Camera)
            error(['Receiver.Camera of ', inputname(2), ' must not be empty'])
        end

        eff = transmitter.Beacon.Total_Efficiency * receiver.Camera.Total_Efficiency;

    case "qkd"
        %% compute received wavelenth from doppler shift
        shifted_wavelength = nodes.Doppler_Shift(receiver, transmitter);
        filter_efficiency = receiver.Detector.Spectral_Filter ...
            .ComputeTransmission(shifted_wavelength);

        %% sources of efficiency
        eff = transmitter.Source.Efficiency ...
            * transmitter.Telescope.Optical_Efficiency ...
            * receiver.Detector.Detection_Efficiency ...
            * receiver.Detector.Jitter_Loss ...
            * receiver.Telescope.Optical_Efficiency ...
            * filter_efficiency;
    end

    n = max(receiver.N_Position, transmitter.N_Position);
    eff = units.Loss("probability", "Optical", utilities.validateLoss(eff, n));
end
