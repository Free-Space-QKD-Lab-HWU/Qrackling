function mustBeReceiverOrTransmitter(receiver_or_transmitter)
    if isscalar(receiver_or_transmitter) && ~isa(receiver_or_transmitter, "cell")
        mustBeA(receiver_or_transmitter, ["nodes.Satellite", "nodes.Ground_Station"])
        return
    end

    for i = 1:numel(receiver_or_transmitter)
        rx_tx = receiver_or_transmitter{i};
        nodes.mustBeReceiverOrTransmitter(rx_tx)
    end
end
