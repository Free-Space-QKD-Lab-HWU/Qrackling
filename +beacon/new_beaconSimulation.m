function result = new_beaconSimulation(Transmitter, Receiver, options)
    arguments
        Transmitter {mustBeA(Transmitter, ...
            ["nodes.Satellite", "nodes.Ground_Station"])}
        Receiver {mustBeA(Receiver, ...
            ["nodes.Satellite", "nodes.Ground_Station"])}
        options.Background_Sources
    end

    [~] = options;

    if isempty(Transmitter.Beacon) || isempty(Receiver.Camera)
        msg = [ ...
            'A beacon simulation requires that the Transmitter ( ', ...
            inputname(1), ') has a beacon (see the "beacon" module) and', ...
            'that the Receiver ( ', inputname(2)', ' ) has a camera (see', ...
            '"components" module)'];
        error(msg)
    end


end
