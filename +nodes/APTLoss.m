function loss = APTLoss(kind, receiver, transmitter)
    arguments
        kind {mustBeMember(kind, ["beacon", "qkd"])}
        receiver {mustBeA(receiver, ["nodes.Satellite", "nodes.Ground_Station"])}
        transmitter {mustBeA(transmitter, ["nodes.Satellite", "nodes.Ground_Station"])}
    end

    %% Acquisition, pointing and tracking loss
    %see Wiki for calculation details. QKD signal is assumed to be
    %a gaussian beam.

    switch kind
    case "beacon"
        if isempty(transmitter.Beacon)
            error(['Transmitter.Beacon of ', inputname(1), ' must not be empty'])
        end

        if isempty(receiver.Camera)
            error(['Receiver.Camera of ', inputname(2), ' must not be empty'])
        end

        loss = transmitter.Beacon.GetAPTLoss(receiver.Camera);

    case "qkd"
        % transmitter pointing loss, assumes gaussian beam
        loss_tx = transmitter.Telescope.FOV ^ 2 ...
            / ( transmitter.Telescope.Pointing_Jitter ^ 2 ...
               + transmitter.Telescope.FOV ^ 2 );

        % receiver pointing loss, assumes flat-top FOV
        loss_rx = 1 - exp( ...
            - ( receiver.Telescope.FOV ^ 2 ...
            / (8 * receiver.Telescope.Pointing_Jitter ^ 2) ) ...
        );

        loss = loss_tx .* loss_rx;
    end

    n = max(receiver.N_Position, transmitter.N_Position);
    loss = utilities.validateLoss(loss, n);

end
