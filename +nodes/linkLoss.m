function [losses,extras] = linkLoss(kind, receiver, transmitter, loss, options)
arguments
    kind {mustBeMember(kind, ["beacon", "qkd"])}
    receiver {mustBeA(receiver, ["nodes.Satellite", "nodes.Ground_Station"])}
    transmitter {mustBeA(transmitter, ["nodes.Satellite", "nodes.Ground_Station"])}
end
arguments (Repeating)
    loss {mustBeMember(loss, {'geometric', 'optical', 'apt', 'turbulence', 'atmospheric'})}
end
arguments
    options.dB logical = false
    options.SpotSize = []
    options.LinkLength = []
end

spot_size = options.SpotSize;

%% geometric loss
if any(contains(string(loss), "geometric"))
    [res, spot_size, ~] = ...
        nodes.GeometricLoss(kind, receiver, transmitter);
    losses=nodes.LossResult('qkd',units.Loss(res,'geometric'));
end

%% turbulence
if any(contains(string(loss), "turbulence"))
    switch class(receiver)
        case "nodes.Ground_Station"
            direction = nodes.LinkDirection.Downlink;
        case "nodes.Satellite"
            direction = nodes.LinkDirection.Uplink;
    end

   [res, beam_width, r0] = nodes.TurbulenceLoss(kind,...
                                                receiver,...
                                                transmitter,...
                                                direction,...
                                                "SpotSize", spot_size);
    losses = losses.addLoss(units.Loss(res,'turbulence'));
end

%% optical (efficiency) loss
if any(contains(string(loss), "optical"))
    res = nodes.OpticalEfficiencyLoss(kind, receiver, transmitter);
    losses = losses.addLoss(units.Loss(res,'optical'));
end

%% acquisition, pointing and tracking loss
if any(contains(string(loss), "apt"))
    res = nodes.APTLoss(kind, receiver, transmitter);
    losses = losses.addLoss(units.Loss(res,'apt'));
end

%% atmospheric loss
if any(contains(string(loss), "atmospheric"))
    res = nodes.AtmosphericLoss(kind, receiver, transmitter, direction);
    losses = losses.addLoss(units.Loss(res,'atmospheric'));
end

extras = {};
extras.("turbulent_beam_width") = beam_width;
extras.("r0") = r0;
extras.("total_loss") = losses.TotalLoss;
end
