function [loss, beam_width, r0] = turbulenceLoss(receiver, transmitter, ...
    elevation, link_length, turbulence)
    arguments
        receiver nodes.QKD_Receiver
        transmitter nodes.QKD_Transmitter
        elevation % something something numeric...
        link_length
        turbulence % something something numeric...
    end

    wavelength = units.Magnitude.Convert("nano", "none", transmitter.Wavelength);
    wavenumber = 2 * pi / wavelength;

    elevation_flags = elevation > 0;
    zenith = 90 - elevation(elevation_flags);

    altitude = altitude_from_nodes([receiver, transmitter]);
    altitude = altitude(elevation_flags);

    r0 = atmospheric_turbulence_coherence_length_downlink( ...
            wavenumber, zenith, altitude, ghv_defaults('Standard', turbulence));

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

function altitude = altitude_from_nodes(tx_rx)
    arguments
        tx_rx (1, 2) nodes.Optical_Node
    end
    satellite = tx_rx(isa(tx_rx, nodes.Satellite));
    altitude = satellite.Altitude;
end
