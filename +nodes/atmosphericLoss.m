function loss = atmosphericLoss(kind, receiver, transmitter, direction)
% atmosphericLoss
%
% Calculate atmospheric attenuation loss between a transmitter and receiver
% based on link direction and signal type.
%
% Syntax:
% loss = atmosphericLoss(kind, receiver, transmitter, direction)
%
% Inputs:
% kind        - string, either "beacon" or "qkd"
% receiver    - nodes.Satellite or nodes.Ground_Station object
% transmitter - nodes.Satellite or nodes.Ground_Station object
% direction   - nodes.LinkDirection enum (Downlink or Uplink)
%
% Output:
% loss        - units.Loss object representing atmospheric attenuation

    arguments
        kind {mustBeMember(kind, ["beacon", "qkd"])}
        receiver {mustBeA(receiver, ["nodes.Satellite", "nodes.GroundStation"])}
        transmitter {mustBeA(transmitter, ["nodes.Satellite", "nodes.GroundStation"])}
        direction nodes.LinkDirection
    end


    %% Determine elevation and environment based on link direction
    switch direction
        case nodes.LinkDirection.Downlink
            [headings, elevations, ~] = transmitter.relativeHeadingAndElevation(receiver);
            environment = receiver.environment;

        case nodes.LinkDirection.Uplink
            [headings, elevations, ~] = receiver.relativeHeadingAndElevation(transmitter);
            environment = transmitter.environment;
    end


    %% Select wavelength based on signal type
    switch kind
        case "beacon"
            wavelength = transmitter.beacon.wavelength;

        case "qkd"
            wavelength = transmitter.source.wavelength;
    end


    %% Interpolate atmospheric attenuation
    % Mask by elevation >= 0
    loss = environment.interp("attenuation", abs(headings), abs(elevations), wavelength);

    if any(isnan(loss))
        loss(isnan(loss)) = 1;
    end


    %% Format output
    n = max(receiver.n_position, transmitter.n_position);
    loss = units.Loss(loss);
end