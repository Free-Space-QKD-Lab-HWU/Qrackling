function [loss, beam_width, r0] = TurbulenceLoss(receiver, transmitter, ...
    fried_parameter, options)
    arguments
        receiver nodes.FreeSpaceReceiver
        transmitter nodes.FreeSpaceTransmitter
        fried_parameter FriedParameter
        options.Elevations
    end

    link_length = receiver.location.ComputeDistanceBetween(transmitter.location);

    spot_size = (ones(size(link_length)) ...
        * transmitter.telescope.Diameter ...
        + link_length ...
        * transmitter.telescope.FOV);

    % wavelength must come from a source, this will be in nm
    wavelength = units.Magnitude.Convert("nano", "none", transmitter.source.Wavelength);
    %wavelength = transmitter.Wavelength;
    wavenumber = 2 * pi / wavelength;

    if contains(fieldnames(options), 'Elevations')
        error('UNIMPLEMENTED: we should be able to pass elevations in, currently we have to determine which of the inputs is the satellite and which is the ground station.');
    end

    % FIX: this is the same issue as present in nodes.AtmosphericLoss.m
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

    elevation_flags = elevations > 0;
    zenith = 90 - elevations(elevation_flags);

    % altitude = altitude_from_nodes([receiver, transmitter]);
    % altitude = altitude(elevation_flags);
    % FIX: again this uses the hack to determine which the satellite
    altitude = rx_tx{sat_index}.location.Altitude(elevation_flags)';

    r0 = fried_parameter.AtmosphericTurbulenceCoherenceLength( ...
        altitude, zenith, wavelength, "Wavelength_Unit", "none");

    beam_width(~elevation_flags) = 0;
    beam_width(elevation_flags) = long_term_gaussian_beam_width( ...
        spot_size(elevation_flags), link_length(elevation_flags), wavenumber, r0);

    loss(~elevation_flags) = 0;
    loss(elevation_flags) = ( ...
        beam_width(elevation_flags) ...
        ./ spot_size(elevation_flags) ) .^ (-2);

    %% input validation
    if ~all(isreal(loss) & loss >= 0)
        error('tracking loss must be a real, nonnegative array of numeric values')
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
