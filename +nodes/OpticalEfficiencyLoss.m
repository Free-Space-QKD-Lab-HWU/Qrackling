function eff = OpticalEfficiencyLoss(receiver, transmitter)
    arguments
        receiver {mustBeA(receiver, ["nodes.Satellite", "nodes.Ground_Station"])}
        transmitter {mustBeA(transmitter, ["nodes.Satellite", "nodes.Ground_Station"])}
    end

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

    n = max(receiver.N_Position, transmitter.N_Position);
    eff = utilities.validateLoss(eff, n);

end
