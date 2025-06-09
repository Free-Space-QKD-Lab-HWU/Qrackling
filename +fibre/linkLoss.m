function loss_result = linkLoss(fibre, receiver, transmitter, losses)
arguments
    fibre fibre.Fibre
    receiver {utilities.mustBeSubclassOf(receiver,'nodes.QKD_Receiver')}
    transmitter {utilities.mustBeSubclassOf(transmitter,'nodes.QKD_Transmitter')}
end
arguments (Repeating)
    losses {mustBeMember(losses, {'source efficiency', 'detector efficiency', 'jitter', 'fibre', 'coupling'})}
end

%% fibre length loss
if any(contains(string(losses), "fibre"))
    loss_result = nodes.LossResult('qkd',fibre.distance_loss);
end

%% coupling loss
if any(contains(string(losses), "coupling"))
    loss_result = loss_result.addLoss(fibre.connections_loss());
end

%% source efficiency
if any(contains(string(losses), "source efficiency"))
    loss_result = loss_result.addLoss(units.Loss(transmitter.Source.Efficiency,'source efficiency'));
end

%% receiver efficiency
if any(contains(string(losses), "detector efficiency"))
    loss_result = loss_result.addLoss(units.Loss(receiver.Detector.Detection_Efficiency,'detector efficiency'));
end

%% jitter
if any(contains(string(losses), "jitter"))
    loss_result = loss_result.addLoss(units.Loss(receiver.Detector.Jitter_Loss,'jitter'));
end

end
