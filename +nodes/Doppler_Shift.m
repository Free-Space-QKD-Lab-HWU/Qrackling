function shifted_wavelength = Doppler_Shift(receiver, transmitter)
    arguments
        receiver {mustBeA(receiver, ["nodes.Satellite", "nodes.Ground_Station"])}
        transmitter {mustBeA(transmitter, ["nodes.Satellite", "nodes.Ground_Station"])}
    end

    %get timestamps from either node
    link_direction = nodes.LinkDirection.DetermineLinkDirection(receiver,transmitter);
    switch link_direction
        case 'Uplink'
            times = receiver.Times;
        case 'Downlink'
            times = transmitter.Times;
        case 'Intersatellite'
            times = transmitter.Times;
        otherwise
            error('At least one of receiver and transmitter must have time stamps')
    end
    distances = receiver.ComputeDistanceBetween(transmitter);
    wavelength = receiver.Telescope.Wavelength;

    % differentiate wrt time
    doppler_velocity = ...
        (distances(2:end) - distances(1:end-1)) ...
        ./seconds(times(2:end) - times(1:end-1));

    % append last result to fill end slot
    doppler_velocity = [doppler_velocity, doppler_velocity(end)];

    c = 2.998E8; %speed of light in m/s
    shifted_wavelength = ( 1 + (doppler_velocity / c) ) .* wavelength;

end

