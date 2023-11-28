function [loss, beam_width, r0] = turbulenceLoss(transmitter, receiver, ...
    elevation, link_length, fried_parameter)
    arguments
        % minimally, transmitter must inherit nodes.QKD_Transmitter and receiver
        % must inherit from nodes.QKD_Receiver
        transmitter {mustBeA(transmitter, "nodes.QKD_Transmitter")}
        receiver {mustBeA(receiver, "nodes.QKD_Receiver")}
        elevation % something something numeric...
        link_length
        fried_parameter FriedParameter
    end

    % wavelength must come from a source, this will be in nm
    wavelength = units.Magnitude.Convert("nano", "none", transmitter.Wavelength);
    %wavelength = transmitter.Wavelength;
    wavenumber = 2 * pi / wavelength;

    elevation_flags = elevation > 0;
    zenith = 90 - elevation(elevation_flags);

    altitude = altitude_from_nodes([receiver, transmitter]);
    altitude = altitude(elevation_flags);

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

function altitude = altitude_from_nodes(tx_rx)
    arguments
        tx_rx (1, 2) nodes.Optical_Node
    end
    satellite = tx_rx(isa(tx_rx, nodes.Satellite));
    altitude = satellite.Altitude;
end
