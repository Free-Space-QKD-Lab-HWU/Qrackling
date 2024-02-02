function varargout = TurbulenceLoss(kind, receiver, transmitter, fried_parameter, options)
    arguments
        kind {mustBeMember(kind, ["beacon", "qkd"])}
        receiver {mustBeA(receiver, ["nodes.Satellite", "nodes.Ground_Station"])}
        transmitter {mustBeA(transmitter, ["nodes.Satellite", "nodes.Ground_Station"])}
        % FIX: why does this produce different values to older method for r0?
        fried_parameter environment.FriedParameter
        options.Elevations
        options.LinkLength = []
        options.GHV = ghv_defaults('Standard', 'HV10-10')
        options.SpotSize = []
    end

    % wavelength must come from a source, this will be in nm
    % wavelength = units.Magnitude.Convert("nano", "none", transmitter.source.Wavelength);
    switch kind
    case "beacon"
        if isempty(transmitter.Beacon)
            error(['Transmitter.Beacon of ', inputname(1), ' must not be empty'])
        end

        if isempty(receiver.Camera)
            error(['Receiver.Camera of ', inputname(2), ' must not be empty'])
        end

        wavelength = transmitter.Beacon.Wavelength;
    case "qkd"
        wavelength = transmitter.Source.Wavelength;
    end

    if contains(fieldnames(options), 'Elevations')
        error('UNIMPLEMENTED: we should be able to pass elevations in, currently we have to determine which of the inputs is the satellite and which is the ground station.');
    end

    % When we look at the original Satellite_Link_Model.m we can see that 
    % regardless of whether we are working with a downlink or uplink model the
    % elevations that we want to capture are always produced with:
    %   RelativeHeadingAndElevation(Satellite, Ground_Station);
    % rx_tx = {receiver, transmitter};
    % [~, elevations, ~] = ...
    %     rx_tx{sat_index}.location.RelativeHeadingAndElevation(rx_tx{ogs_index}.location);
    switch class(transmitter)
    case "nodes.Satellite"
        [~, elevations, ~] = transmitter.RelativeHeadingAndElevation(receiver);
    case "nodes.Ground_Station"
        [~, elevations, ~] = receiver.RelativeHeadingAndElevation(transmitter);
    end

    elevation_flags = elevations > 0;
    zenith = 90 - elevations(elevation_flags);

    switch class(transmitter)
    case "nodes.Satellite"
        altitude = transmitter.Altitude(elevation_flags);
    case "nodes.Ground_Station"
        altitude = receiver.Altitude(elevation_flags);
    end

    % r0 = fried_parameter.AtmosphericTurbulenceCoherenceLength( ...
    %     altitude, zenith, wavelength, "Wavelength_Unit", "none");

    wavenumber = 2 * pi / (wavelength * (1e-9));

    r0 = atmospheric_turbulence_coherence_length_downlink( ...
        wavenumber, zenith, altitude', options.GHV);

    link_length = options.LinkLength;
    if isempty(options.LinkLength)
        link_length = receiver.ComputeDistanceBetween(transmitter);
    end

    spot_size = options.SpotSize;
    if isempty(options.SpotSize)
        switch kind
        case "beacon"
            [~, spot_size] = transmitter.Beacon.GetGeoLoss(link_length, receiver.Camera);
        case "qkd"
            spot_size = (ones(size(link_length)) ...
                * transmitter.Telescope.Diameter ...
                + link_length ...
                * transmitter.Telescope.FOV);
        end
    end

    beam_width(~elevation_flags) = 0;
    beam_width(elevation_flags) = long_term_gaussian_beam_width( ...
        spot_size(elevation_flags), link_length(elevation_flags), wavenumber, r0);

    % NOTE: Is this true? -> "residual beam wander is not needed here as this is dealt with in"
    % NOTE: Is this where we need "greenwood_frequency.m"?

    loss(~elevation_flags) = 0;
    loss(elevation_flags) = ( ...
        beam_width(elevation_flags) ...
        ./ spot_size(elevation_flags) ) .^ (-2);

    n = max(receiver.N_Position, transmitter.N_Position);
    loss = units.Loss("probability", "Turbulence", utilities.validateLoss(loss, n));

    nargoutchk(0, 3)
    varargout{1} = loss;

    if 2 <= nargout()
        varargout{2} = beam_width;
    end

    if 3 <= nargout()
        varargout{3} = r0;
    end
end
