function result = beaconSimulation( Receiver,Transmitter)
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

    [link_loss, link_extras] = nodes.linkLoss("beacon", Receiver, Transmitter, ...
        "apt", "optical", "geometric", "turbulence", "atmospheric", "dB", true);
    total_loss_db = link_extras.total_loss;

    received_power = Transmitter.Beacon.Power * 10 .^ (-total_loss_db ./ 10);

    background_counts = [];

    has_atm_file = any(contains(properties(Receiver), "Atmosphere_File_Location"));
    has_atm = false;
    if has_atm_file
        has_atm = ~isempty(Receiver.Atmosphere_File_Location);
    end

    %if has_atm_file && has_atm
    if has_atm
    %computed beacon channel noise
        sky_radiance = interp1( ...
            Receiver.Wavelengths, ...
            Receiver.Sky_Radiance', ...
            Transmitter.Beacon.Wavelength);
        background_counts = sky_radiance * Receiver.Camera.FOV;

        [snr, snr_db] = SNR(Receiver.Camera, received_power, background_counts);
    else
        [snr, snr_db] = SNR(Receiver.Camera, received_power);
    end

    result = beacon.BeaconResult( ...
        link_loss, total_loss_db, background_counts, received_power, snr, snr_db);

end
