function varargout = GeometricLoss(kind, receiver, transmitter, options)
    arguments
        kind {mustBeMember(kind, ["beacon", "qkd"])}
        receiver {mustBeA(receiver, ["nodes.Satellite", "nodes.Ground_Station"])}
        transmitter {mustBeA(transmitter, ["nodes.Satellite", "nodes.Ground_Station"])}
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
    loss = utilities.validateLoss(loss, n);

    nargoutchk(0, 3);
    varargout{1} = loss;

    if 2 <= nargout()
        varargout{2} = spot_size;
    end

    if 3 <= nargout()
        varargout{3} = link_length;
    end

end
