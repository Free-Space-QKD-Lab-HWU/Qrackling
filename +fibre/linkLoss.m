function loss_result = linkLoss(fibre, receiver, transmitter, losses)
% linkLoss
%
% Compute total link loss for a fibre QKD connection, based on selected
% physical and system-level loss mechanisms.
%
% Syntax:
% loss_result = linkLoss(fibre, receiver, transmitter, losses)
%
% Inputs:
% fibre       - fibre.Fibre object representing the optical link
% receiver    - subclass of nodes.QKD_Receiver
% transmitter - subclass of nodes.QKD_Transmitter
% losses      - cell array of strings specifying which losses to include.
%               Valid options: 'source efficiency', 'detector efficiency',
%               'jitter', 'fibre', 'coupling'
%
% Output:
% loss_result - nodes.LossResult object containing cumulative losses

    arguments
        fibre fibre.Fibre
        receiver {utilities.mustBeSubclassOf(receiver, 'nodes.QKDReceiver')}
        transmitter {utilities.mustBeSubclassOf(transmitter, 'nodes.QKDTransmitter')}
    end

    arguments (Repeating)
        losses {mustBeMember(losses, {'source efficiency', 'detector efficiency', 'jitter', 'fibre', 'coupling'})}
    end


    %% Fibre length loss
    if any(contains(string(losses), "fibre"))
        loss_result = nodes.LossResult('qkd', fibre.distance_loss);
    end


    %% Coupling loss
    if any(contains(string(losses), "coupling"))
        loss_result = loss_result.addLoss(fibre.connections_loss);
    end


    %% Source efficiency
    if any(contains(string(losses), "source efficiency"))
        loss_result = loss_result.addLoss( ...
            units.Loss(transmitter.source.efficiency, 'source efficiency'));
    end


    %% Detector efficiency
    if any(contains(string(losses), "detector efficiency"))
        loss_result = loss_result.addLoss( ...
            units.Loss(receiver.detector.detection_efficiency, 'detector efficiency'));
    end


    %% Jitter
    if any(contains(string(losses), "jitter"))
        loss_result = loss_result.addLoss( ...
            units.Loss(receiver.detector.jitter_loss, 'jitter'));
    end

end