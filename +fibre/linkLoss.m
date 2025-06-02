function loss_result = linkLoss(fibre, receiver, transmitter, loss)
arguments
    fibre fibre.Fibre
    receiver {utilities.mustBeSubclassOf(receiver,'nodes.QKD_Receiver')}
    transmitter {utilities.mustBeSubclassOf(transmitter,'nodes.QKD_Transmitter')}
end
arguments (Repeating)
    loss {mustBeMember(loss, {'efficiency', 'fibre', 'coupling'})}
end


%% optical (efficiency) loss
if any(contains(string(loss), "efficiency"))
    loss_result = nodes.LossResult('qkd',fibre.connections_loss());
end

%% fibre length loss
if any(contains(string(loss), "fibre"))
    loss_result = loss_result.addLoss(fibre.total_loss);
end

%% coupling loss
if any(contains(string(loss), "coupling"))
    loss_result = loss_result.addLoss(fibre.connections_loss());
end

end
