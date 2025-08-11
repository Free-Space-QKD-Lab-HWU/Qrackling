function [turbulence_loss, turbulent_beam_width, r0] = turbulenceLoss( ...
        kind, receiver, transmitter, direction, options)
% turbulenceLoss
%
% Computes the turbulence-induced loss for a free-space optical link.
% Applies beam spreading models based on elevation, wavelength, and
% atmospheric turbulence profiles.
%
% Syntax:
% [turbulence_loss, turbulent_beam_width, r0] = ...
%     turbulenceLoss(kind, receiver, transmitter, direction, options)
%
% Inputs:
% kind        - (1,1) string, either "beacon" or "qkd"
% receiver    - (1,1) nodes.Located_Object, receiving node
% transmitter - (1,1) nodes.Located_Object, transmitting node
% direction   - (1,1) nodes.LinkDirection, link direction
% options     - struct with optional field:
%   .SpotSize - (1,N) double, geometric spot size (optional)
%
% Outputs:
% turbulence_loss      - (1,N) units.Loss, loss due to turbulence
% turbulent_beam_width - (1,N) double, beam width after turbulence
% r0                   - (1,N) double, Fried parameter

    arguments
        kind {mustBeMember(kind, ["beacon", "qkd"])}
        receiver (1,1) {utilities.mustBeSubclassOf(receiver, 'nodes.LocatedObject')}
        transmitter (1,1) {utilities.mustBeSubclassOf(transmitter, 'nodes.LocatedObject')}
        direction (1,1) nodes.LinkDirection
        options.SpotSize = []
    end

    %% Determine wavelength
    switch kind
        case "beacon"
            if isempty(transmitter.Beacon)
                error('Transmitter.Beacon must not be empty')
            end
            if isempty(receiver.Camera)
                error('Receiver.Camera must not be empty')
            end
            wavelength = transmitter.beacon.wavelength;

        case "qkd"
            wavelength = transmitter.source.wavelength;
    end

    %% Compute link geometry
    [~, elevation, link_length] = relativeHeadingAndElevation(transmitter, receiver);

    %% Determine altitude bounds and turbulence model
    switch direction
        case nodes.LinkDirection.Downlink
            bottom_height = receiver.altitude;
            top_height = transmitter.altitude;
            turbulence_model = receiver.environment.turbulence_model;

        case nodes.LinkDirection.Uplink
            bottom_height = transmitter.altitude;
            top_height = receiver.altitude;
            turbulence_model = transmitter.environment.turbulence_model;

            % Elevation must be positive for turbulence calculations
            elevation = elevation + 180;
    end

    %% Identify valid time steps
    elevation_flags = elevation > 0;

    %% Determine geometric spot size
    geometric_spot_size = options.SpotSize;

    if isempty(geometric_spot_size)
        [~, geometric_spot_size] = nodes.geometricLoss( ...
            kind, receiver, transmitter, "LinkLength", link_length(elevation_flags));
    elseif isequal(size(geometric_spot_size), size(link_length))
        geometric_spot_size = geometric_spot_size(elevation_flags);
    end

    %% Compute beam spreading due to turbulence
    [turbulent_beam_width, r0] = beamSpread( ...
        turbulence_model, ...
        direction, ...
        wavelength, ...
        elevation(elevation_flags), ...
        link_length(elevation_flags), ...
        geometric_spot_size, ...
        'BottomHeight', bottom_height, ...
        'TopHeight', top_height);

    %% Compute turbulence loss
    turbulence_loss = zeros(size(elevation_flags));
    turbulence_loss(elevation_flags) = ...
        (geometric_spot_size ./ turbulent_beam_width).^2;

    turbulence_loss = units.Loss(turbulence_loss);
end