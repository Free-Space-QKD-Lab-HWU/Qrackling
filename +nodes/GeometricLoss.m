% TODO: add optional inputs -> link length save recomputing it
% TODO: add optional outputs -> return the spot size
function loss = GeometricLoss(receiver, transmitter)
    arguments
        receiver nodes.FreeSpaceReceiver
        transmitter nodes.FreeSpaceTransmitter
    end

    link_length = receiver.location.ComputeDistanceBetween(transmitter.location);

    spot_size = (ones(size(link_length)) ...
        * transmitter.telescope.Diameter ...
        + link_length ...
        * transmitter.telescope.FOV);

    loss = (sqrt(pi) / 8) * (receiver.telescope.Diameter ./ spot_size) .^2;
    loss = min(loss, 1); %make sure loss cannot be positive

    %compute whether or not the earth is obstructing the link between rx and tx
    shadowed = nodes.InEarthsShadow(receiver.location, transmitter.location);

    loss(shadowed) = 0;

    %% input validation
    if ~all(isreal(loss) & loss >= 0)
        error('geometric loss must be a non-negative array of numeric values')
    end
    if isscalar(loss)
        %if provided a scalar, put this into everywhere in the array 
        n = max(receiver.location.N_Position, transmitter.location.N_Position);
        loss = loss * ones(1, n);
    elseif isrow(loss)
    elseif iscolumn(loss)
        loss = loss'; %can transpose lengths to match dimensions of Link_Models
    else
        error('Array must be a vector or scalar');
    end

end
