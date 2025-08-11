function mustBeReceiverOrTransmitter(receiver_or_transmitter)
% mustBeReceiverOrTransmitter
%
% Validates that input is a QKD_Transmitter or QKD_Receiver object.
%
% Syntax:
% mustBeReceiverOrTransmitter(obj)
%
% Inputs:
% obj - scalar or array of QKD node objects

    if isscalar(receiver_or_transmitter) && ~isa(receiver_or_transmitter, "cell")
        is_valid = utilities.isSubclassOf(receiver_or_transmitter, 'nodes.QKDTransmitter') || ...
                   utilities.isSubclassOf(receiver_or_transmitter, 'nodes.QKDReceiver');

        assert(is_valid, ...
            'Input must be either a QKDTransmitter or QKDReceiver');
        return
    end

    for i = 1:numel(receiver_or_transmitter)
        rx_tx = receiver_or_transmitter(i);
        nodes.mustBeReceiverOrTransmitter(rx_tx)
    end
end