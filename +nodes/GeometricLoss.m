function loss = GeometricLoss(transmitter, receiver, link_length)
    arguments
        transmitter {mustBeA(transmitter, "nodes.QKD_Transmitter")}
        receiver {mustBeA(receiver, "nodes.QKD_Receiver")}
        link_length
    end

    spot_size = (ones(size(link_length)) ...
        * transmitter.Telescope.Diameter ...
        + link_length ...
        * transmitter.Telescope.FOV);

    loss = (sqrt(pi) / 8) * (receiver.Telescope.Diameter ./ spot_size) .^2;
    loss = min(loss, 1); %make sure loss cannot be positive

    %compute when earth shadowing of link is present
    rx_tx = [receiver, transmitter];

    shadowed = nodes.InEarthsShadow( ...
        rx_tx(isa(rx_tx, "nodes.Satellite")), ...
        rx_tx(isa(rx_tx, "nodes.Ground_Station")) );

    loss(shadowed) = 0;

    %% input validation
    if ~all(isreal(loss) & loss >= 0)
        error('geometric loss must be a non-negative array of numeric values')
    end
    if isscalar(loss)
        %if provided a scalar, put this into everywhere in the array 
        loss = loss*ones(1, Link_Models.N);
    elseif isrow(loss)
    elseif iscolumn(loss)
        loss = loss'; %can transpose lengths to match dimensions of Link_Models
    else
        error('Array must be a vector or scalar');
    end

end
