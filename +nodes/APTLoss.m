function loss = aptLoss(kind, receiver, transmitter)
% aptLoss
%
% Compute acquisition, pointing, and tracking (APT) loss for either
% beacon or QKD signal between a transmitter and receiver.
%
% Syntax:
% loss = aptLoss(kind, receiver, transmitter)
%
% Inputs:
% kind        - string, either "beacon" or "qkd"
% receiver    - nodes.Satellite or nodes.Ground_Station object
% transmitter - nodes.Satellite or nodes.Ground_Station object
%
% Output:
% loss        - units.Loss object representing APT loss

    arguments
        kind {mustBeMember(kind, ["beacon", "qkd"])}
        receiver {mustBeA(receiver, ["nodes.Satellite", "nodes.GroundStation"])}
        transmitter {mustBeA(transmitter, ["nodes.Satellite", "nodes.GroundStation"])}
    end


    %% Acquisition, pointing, and tracking loss
    % See internal documentation for calculation details.
    % QKD signal is assumed to be a Gaussian beam.

    switch kind
        case "beacon"
            if isempty(transmitter.beacon)
                error(['transmitter.beacon of ', inputname(1), ' must not be empty']);
            end

            if isempty(receiver.camera)
                error(['receiver.camera of ', inputname(2), ' must not be empty']);
            end

            loss = transmitter.beacon.getAptLoss(receiver.camera);

        case "qkd"
            % Transmitter pointing loss (Gaussian beam)
            loss_tx = transmitter.telescope.fov ^ 2 ...
                / (transmitter.telescope.pointing_jitter ^ 2 ...
                   + transmitter.telescope.fov ^ 2);

            % Receiver pointing loss (flat-top FOV)
            loss_rx = 1 - exp( ...
                - (receiver.telescope.fov ^ 2 ...
                / (8 * receiver.telescope.pointing_jitter ^ 2)) ...
            );

            loss = loss_tx .* loss_rx;
    end


    %% Upscale to match other loss formats
    if isscalar(loss)
        n = max(receiver.n_position, transmitter.n_position);
        loss = loss * ones(1, n);
    end

    loss = units.Loss(loss);
end