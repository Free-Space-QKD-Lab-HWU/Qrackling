function loss = AtmosphericLoss(receiver, transmitter, options)
    % Calculate the amount of loss contribution from the atmosphere between the
    % transmitter and receiver
    arguments
        receiver nodes.FreeSpaceReceiver
        transmitter nodes.FreeSpaceTransmitter
        % FIX: should be an array of visibilities, this is current form due to
        % the specifics of the 'Atmosphere_Spectral_Filter' class
        options.Visibility {mustBeText} = '50km'
    end

    % so we need to determine which of our two inputs, { receiver, transmitter }
    % is above the other, this should tell us which of them is the satellite.
    % this is maybe not the strongest assumption that we could apply and this
    % should also be replaced with an optional input arg to determine the
    % direction of the link. This is following the pattern that exists in the 
    % current satellite link model where the elevations are calculated from
    % satellite to ground station
    % FIX: an optional argument to set link direction, i.e. should the heading
    % and elevation calculation be from satellite to ground or from ground to
    % satellite?

    chk = ( receiver.location.Altitude > transmitter.location.Altitude );
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
        rx_tx{sat_index}.location.RelativeHeadingAndElevation(rx_tx{ogs_index}.location);

    % FIX: 'Atmosphere_Spectral_Filter.m' needs replacing
    atmosphere_spectral_filter = Atmosphere_Spectral_Filter( ...
        elevations, transmitter.source.Wavelength, {options.Visibility});

    loss = atmosphere_spectral_filter.ComputeTransmission( ...
        transmitter.source.Wavelength);

    %% input validation
    if ~all(isreal(loss) & loss >= 0)
        error('atmospheric loss must be a non-negative array of numeric values')
    end
    if isscalar(loss)
        %if provided a scalar, put this into everywhere in the array 
        n = max(receiver.location.N_Position, transmitter.location.N_Position);
        loss = loss * ones(1, n);
    elseif isrow(loss)
    elseif iscolumn(loss)
        loss = loss'; %can transpose lengths to match dimensions of Link_Models
    else
        error('Array must be a vector or scalar');
    end

end
