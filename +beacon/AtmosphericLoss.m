function loss = AtmosphericLoss(Receiver, Transmitter, options)
    arguments
        Receiver {mustBeA(Receiver, ["nodes.Satellite", "nodes.Ground_Station"])}
        Transmitter {mustBeA(Transmitter, ["nodes.Satellite", "nodes.Ground_Station"])}
        options.Visibility {mustBeText} = '50km'
    end

    if isempty(Transmitter.Beacon)
        error(['Transmitter.Beacon of ', inputname(1), ' must not be empty'])
    end

    if isempty(Receiver.Camera)
        error(['Receiver.Camera of ', inputname(2), ' must not be empty'])
    end

    % FIX: an optional argument to set link direction, i.e. should the heading
    % and elevation calculation be from satellite to ground or from ground to
    % satellite?

    chk = ( Receiver.Altitude > Transmitter.Altitude );
    assert( all(chk == 0) || all(check == 1), ...
        'Not able to determine which input is the satellite' );

    % if this assertion passes then we can safely assume that one of the inputs
    % to this function maintains an alitude above the other, if unique(chk) == 1
    % then we can assume that the receiver is the satellite, otherwise we can
    % assume that the satellite is the transmitter

    if 1 == unique(chk)
        sat_index = 1;
        ogs_index = 2;
    else
        sat_index = 2;
        ogs_index = 1;
    end

    % When we look at the original Satellite_Link_Model.m we can see that 
    % regardless of whether we are working with a downlink or uplink model the
    % elevations that we want to capture are always produced with:
    %   RelativeHeadingAndElevation(Satellite, Ground_Station);
    rx_tx = {receiver, transmitter};
    [~, elevations, ~] = ...
        rx_tx{sat_index}.RelativeHeadingAndElevation(rx_tx{ogs_index}.location);

    % FIX: 'Atmosphere_Spectral_Filter.m' needs replacing
    atmosphere_spectral_filter = Atmosphere_Spectral_Filter( ...
        elevations, Transmitter.Beacon.Wavelength, {options.Visibility});
    % FIX: why is there repition of the wavlength here, surely on ComputeTransmission
    % should need to know the operating wavlength
    loss = atmosphere_spectral_filter.ComputeTransmission(Transmitter.Beacon.Wavelength);

    n = max(receiver.location.N_Position, transmitter.location.N_Position);
    loss = utilities.validateLoss(loss, n);
end
