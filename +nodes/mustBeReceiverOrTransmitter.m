function mustBeReceiverOrTransmitter(receiver_or_transmitter)
    if isscalar(receiver_or_transmitter) && ~isa(receiver_or_transmitter, "cell")
        assert(utilities.isSubclassOf(receiver_or_transmitter, 'nodes.QKD_Transmitter')||...
               utilities.isSubclassOf(receiver_or_transmitter,'nodes.QKD_Receiver'),...
               'must either be a QKD_Transmitter or QKD_Receiver')
        return
    end

    for i = 1:numel(receiver_or_transmitter)
        rx_tx = receiver_or_transmitter(i);
        nodes.mustBeReceiverOrTransmitter(rx_tx)
    end
end
