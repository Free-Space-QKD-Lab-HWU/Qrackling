function mustBeReceiver(receiver)
    if isscalar(receiver)
        mustBeA(receiver, ["nodes.Satellite", "nodes.Ground_Station"])
        return
    end

    for i = 1:numel(receiver)
        rx = receiver{i};
        nodes.mustBeReceiver(rx)
    end
end
