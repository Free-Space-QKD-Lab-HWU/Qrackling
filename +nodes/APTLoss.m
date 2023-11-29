% TODO: need control on reciever and transmitter to determine the type of beam
% they should have, either gaussian or flat-top
function loss = APTLoss(receiver, transmitter)
    arguments
        receiver nodes.FreeSpaceReceiver
        transmitter nodes.FreeSpaceTransmitter
    end

    %% Acquisition, pointing and tracking loss
    %see Wiki for calculation details. QKD signal is assumed to be
    %a gaussian beam.

    % transmitter pointing loss, assumes gaussian beam
    loss_tx = transmitter.telescope.FOV^2 ...
        / (transmitter.telescope.Pointing_Jitter^2 + transmitter.telescope.FOV^2);

    % receiver pointing loss, assumes flat-top FOV
    loss_rx = 1 - exp( -(receiver.telescope.FOV^2 / (8*receiver.telescope.Pointing_Jitter^2)) );

    loss = loss_tx .* loss_rx;

    %% input validation
    if ~all(isreal(loss)&loss>=0)
        error('tracking loss must be a real, nonnegative array of numeric values')
    end
    if isscalar(loss)
        % if provided a scalar, put this into everywhere in the array
        n = max(receiver.location.N_Position, transmitter.location.N_Position);
        loss = loss * ones(1, n);
    elseif isrow(loss)
    elseif iscolumn(loss)
        loss=loss'; %can transpose lengths to match dimensions of Link_Models
    else
        error('Array must be a vector or scalar');
    end

end
