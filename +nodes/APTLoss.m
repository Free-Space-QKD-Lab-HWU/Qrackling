function loss = APTLoss(receiver, transmitter)
    arguments
        receiver {mustBeA(receiver, ["nodes.Satellite", "nodes.Ground_Station"])}
        transmitter {mustBeA(transmitter, ["nodes.Satellite", "nodes.Ground_Station"])}
    end

    %% Acquisition, pointing and tracking loss
    %see Wiki for calculation details. QKD signal is assumed to be
    %a gaussian beam.

    % transmitter pointing loss, assumes gaussian beam
    loss_tx = transmitter.Telescope.FOV^2 ...
        / (transmitter.Telescope.Pointing_Jitter^2 + transmitter.Telescope.FOV^2);

    % receiver pointing loss, assumes flat-top FOV
    loss_rx = 1 - exp( -(receiver.Telescope.FOV^2 / (8*receiver.Telescope.Pointing_Jitter^2)) );

    loss = loss_tx .* loss_rx;

    n = max(receiver.N_Position, transmitter.N_Position);
    loss = utilities.validateLoss(loss, n);

end
