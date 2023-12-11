%HACK: both the loss model here and the loss model for the qkd links is in 
% essense the same, these should be merged and placed behind a flag.
%TODO: add input argument "kind" that must be either beacon or qkd, and merge
% loss functions.
function loss = TurbulenceLoss(Receiver, Transmitter, fried_parameter, options)
    arguments
        Receiver {mustBeA(Receiver, ["nodes.Satellite", "nodes.Ground_Station"])}
        Transmitter {mustBeA(Transmitter, ["nodes.Satellite", "nodes.Ground_Station"])}
        fried_parameter FriedParameter
        options.Elevations
    end

    if contains(fieldnames(options), 'Elevations')
        error('UNIMPLEMENTED: we should be able to pass elevations in, currently we have to determine which of the inputs is the satellite and which is the ground station.');
    end

    if isempty(Transmitter.Beacon)
        error(['Transmitter.Beacon of ', inputname(1), ' must not be empty'])
    end

    if isempty(Receiver.Camera)
        error(['Receiver.Camera of ', inputname(2), ' must not be empty'])
    end

    % wavelength must come from a source, this will be in nm
    % wavelength = units.Magnitude.Convert("nano", "none", transmitter.source.Wavelength);
    wavelength = Transmitter.Beacon.Wavelength;


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
        wavenumber, zenith, altitude', ...
        ghv_defaults('Standard', 'HV10-10'));

    link_length = receiver.ComputeDistanceBetween(transmitter);

    [~, spot_size] = Transmitter.Beacon.GetGeoLoss(link_length, Receiver.Camera);

    beam_width(~elevation_flags) = 0;
    beam_width(elevation_flags) = long_term_gaussian_beam_width( ...
        spot_size(elevation_flags), link_length(elevation_flags), wavenumber, r0);

    loss(~elevation_flags) = 0;
    loss(elevation_flags) = ( ...
        beam_width(elevation_flags) ...
        ./ spot_size(elevation_flags) ) .^ (-2);

    n = max(Receiver.N_Position, Transmitter.N_Position);
    loss = utilities.validateLoss(loss, n);
end
