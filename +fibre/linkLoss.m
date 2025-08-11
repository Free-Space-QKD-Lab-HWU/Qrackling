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
        receiver {utilities.mustBeSubclassOf(receiver, 'nodes.QKD_Receiver')}
        transmitter {utilities.mustBeSubclassOf(transmitter, 'nodes.QKD_Transmitter')}
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
        loss_result = loss_result.addLoss(fibre.connections_loss());
    end


    %% Source efficiency
    if any(contains(string(losses), "source efficiency"))
        loss_result = loss_result.addLoss( ...
            units.Loss(transmitter.Source.Efficiency, 'source efficiency'));
    end


    %% Detector efficiency
    if any(contains(string(losses), "detector efficiency"))
        loss_result = loss_result.addLoss( ...
            units.Loss(receiver.Detector.Detection_Efficiency, 'detector efficiency'));
    end


    %% Jitter
    if any(contains(string(losses), "jitter"))
        loss_result = loss_result.addLoss( ...
            units.Loss(receiver.Detector.Jitter_Loss, 'jitter'));
    end

end