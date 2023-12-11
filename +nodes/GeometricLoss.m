% TODO: add optional inputs -> link length save recomputing it
% TODO: add optional outputs -> return the spot size
function loss = GeometricLoss(receiver, transmitter)
    arguments
        receiver {mustBeA(receiver, ["nodes.Satellite", "nodes.Ground_Station"])}
        transmitter {mustBeA(transmitter, ["nodes.Satellite", "nodes.Ground_Station"])}
    end

    link_length = receiver.ComputeDistanceBetween(transmitter);

    spot_size = (ones(size(link_length)) ...
        * transmitter.Telescope.Diameter ...
        + link_length ...
        * transmitter.Telescope.FOV);

    loss = (sqrt(pi) / 8) * (receiver.Telescope.Diameter ./ spot_size) .^2;
    loss = min(loss, 1); %make sure loss cannot be positive

    %compute whether or not the earth is obstructing the link between rx and tx
    shadowed = nodes.InEarthsShadow(receiver, transmitter);

    loss(shadowed) = 0;

    n = max(receiver.N_Position, transmitter.N_Position);
    loss = utilities.validateLoss(loss, n);

end
