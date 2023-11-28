function [loss, beam_width, r0] = TurbulenceLoss(receiver, transmitter, ...
    link_length, fried_parameter, options)
    arguments
        receiver nodes.FreeSpaceReceiver
        transmitter nodes.FreeSpaceTransmitter
        fried_parameter FriedParameter
        options.Elevations
    end

    % wavelength must come from a source, this will be in nm
    wavelength = units.Magnitude.Convert("nano", "none", transmitter.Wavelength);
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
        rx_tx{sat_index}.location.RelativeHeadingAndElevation(rx_tx{ogs_index});

    elevation_flags = elevation > 0;
    zenith = 90 - elevation(elevation_flags);

    % altitude = altitude_from_nodes([receiver, transmitter]);
    % altitude = altitude(elevation_flags);
    % FIX: again this uses the hack to determine which the satellite
    altitude = rx_tx{sat_index}.Altitude;

    r0 = fried_parameter.AtmosphericTurbulenceCoherenceLength( ...
        altitude, zenith, wavelength, "Wavelength_Unit", "none");

    spot_size = Geo_Spot_Size(Elevation_Flags);

    beam_width(~elevation_flags) = 0;
    beam_width(elevation_flags) = long_term_gaussian_beam_width( ...
        spot_size, link_length(Elevation_Flags), wavenumber, r0);

    loss(~Elevation_Flags) = 0;
    loss(Elevation_Flags) = ( ...
        beam_width(Elevation_Flags) ...
        ./ Geo_Spot_Size(Elevation_Flags) ) .^ (-2);

    %% input validation
    if ~all(isreal(loss) & loss >= 0)
        error('tracking loss must be a real, nonnegative array of numeric values')
    end
    if isscalar(loss)
        %if provided a scalar, put this into everywhere in the array
        loss = loss*ones(1, Link_Models.N); % probably length of elevations?
    elseif isrow(loss)
    elseif iscolumn(loss)
        loss = loss'; %can transpose lengths to match dimensions of Link_Models
    else
        error('Array must be a vector or scalar');
    end
end
