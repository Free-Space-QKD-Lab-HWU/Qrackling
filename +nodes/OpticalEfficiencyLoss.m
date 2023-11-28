function loss = OpticalEfficiencyLoss(transmitter, receiver)
    arguments
        transmitter {mustBeA(transmitter, "components.Telescope")}
        receiver {mustBeA(receiver, "components.Telescope")}
    end

    %% compute received wavelenth from doppler shift
    Doppler_Wavelength = DopplerShift(Ground_Station, Satellite);
    Filter_Efficiency = ComputeTransmission(Ground_Station.Detector.Spectral_Filter,Doppler_Wavelength);

    %% sources of efficiency
    Eff = Satellite.Source.Efficiency ...
        * Satellite.Telescope.Optical_Efficiency ...
        * Ground_Station.Detector.Detection_Efficiency ...
        * Ground_Station.Detector.Jitter_Loss ...
        * Ground_Station.Telescope.Optical_Efficiency ...
        * Filter_Efficiency;

    %% input validation
    if ~all(isreal(loss)&loss>=0)
        error('tracking loss must be a real, nonnegative array of numeric values')
    end
    if isscalar(loss)
        % if provided a scalar, put this into everywhere in the array
        loss=loss*ones(1, Link_Models.N);
    elseif isrow(loss)
    elseif iscolumn(loss)
        loss=loss'; %can transpose lengths to match dimensions of Link_Models
    else
        error('Array must be a vector or scalar');
    end

end
