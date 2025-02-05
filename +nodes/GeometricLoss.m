function [loss, spot_size, link_length] = GeometricLoss(kind, receiver, transmitter, options)
    arguments
        kind {mustBeMember(kind, ["beacon", "qkd"])}
        receiver {utilities.mustBeSubclassOf(receiver,'nodes.Located_Object')}
        transmitter {utilities.mustBeSubclassOf(transmitter,'nodes.Located_Object')}
        options.LinkLength = []
    end

    link_length = options.LinkLength;
    if isempty(options.LinkLength)
        link_length = receiver.ComputeDistanceBetween(transmitter);
    end

    switch kind
    case "beacon"
        if isempty(transmitter.Beacon)
            error(['Transmitter.Beacon of ', inputname(1), ' must not be empty'])
        end

        if isempty(receiver.Camera)
            error(['Receiver.Camera of ', inputname(2), ' must not be empty'])
        end

        [loss, spot_size] = ...
            transmitter.Beacon.GetGeoLoss(link_length, receiver.Camera);


    case "qkd"
        spot_size = (ones(size(link_length)) ...
            * transmitter.Telescope.Diameter ...
            + link_length ...
            * transmitter.Telescope.FOV);

        loss = (sqrt(pi) / 8) * (receiver.Telescope.Diameter ./ spot_size) .^2;
        loss = min(loss, 1); %make sure loss cannot be positive
    end

    %compute whether or not the earth is obstructing the link between rx and tx
    shadowed = nodes.InEarthsShadow(receiver, transmitter);

    loss(shadowed) = 0;

    n = max(receiver.N_Position, transmitter.N_Position);
    loss = units.Loss("probability", "Geometric",loss);
end
