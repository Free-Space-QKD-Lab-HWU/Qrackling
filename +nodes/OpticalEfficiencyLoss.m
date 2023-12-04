function eff = OpticalEfficiencyLoss(receiver, transmitter)
    arguments
        receiver nodes.FreeSpaceReceiver
        transmitter nodes.FreeSpaceTransmitter
    end

    %% compute received wavelenth from doppler shift
    shifted_wavelength = nodes.Doppler_Shift(receiver, transmitter);
    filter_efficiency = receiver.detector.Spectral_Filter ...
        .ComputeTransmission(shifted_wavelength);

    %% sources of efficiency
    eff = transmitter.source.Efficiency ...
        * transmitter.telescope.Optical_Efficiency ...
        * receiver.detector.Detection_Efficiency ...
        * receiver.detector.Jitter_Loss ...
        * receiver.telescope.Optical_Efficiency ...
        * filter_efficiency;

    %% input validation
    if ~all(isreal(eff) & eff >= 0)
        error('tracking eff must be a real, nonnegative array of numeric values')
    end
    if isscalar(eff)
        % if provided a scalar, put this into everywhere in the array
        eff = eff*ones(1, Link_Models.N);
    elseif isrow(eff)
    elseif iscolumn(eff)
        eff = eff'; %can transpose lengths to match dimensions of Link_Models
    else
        error('Array must be a vector or scalar');
    end

end
