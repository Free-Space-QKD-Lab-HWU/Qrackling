function phi = PhaseShiftFromRelativeMotion(receiver, transmitter)
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

    c=2.998E8;

    wavelength = transmitter.Source.Wavelength * (1e-9);
    rep_rate = transmitter.Source.Repetition_Rate;

    % differentiate wrt time
    relative_velocity = ...
        (distances(2:end) - distances(1:end-1)) ...
        ./ seconds(times(2:end) - times(1:end-1));

    %append last result to fill end slot
    relative_velocity = [relative_velocity, relative_velocity(end)];

    %% compute phase shift
    phi = -2 * pi ...
        * ( c/(wavelength * rep_rate) ) ...
        * ( relative_velocity ./ (relative_velocity + c) );
end
