function [loss_result,extras] = linkLoss(kind, receiver, transmitter, loss, options)
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

losses = {};

spot_size = options.SpotSize;

%% geometric loss
if any(contains(string(loss), "geometric"))
    [res, spot_size, ~] = ...
        nodes.GeometricLoss(kind, receiver, transmitter);
    losses.("geometric") = res;
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
    losses.("turbulence") = res;
end

%% optical (efficiency) loss
if any(contains(string(loss), "optical"))
    res = nodes.OpticalEfficiencyLoss(kind, receiver, transmitter);
    losses.optical = res;
end

if any(contains(string(loss), "apt"))
    res = nodes.APTLoss(kind, receiver, transmitter);
    losses.apt = res;
end

if any(contains(string(loss), "atmospheric"))
    res = nodes.AtmosphericLoss(kind, receiver, transmitter, direction);
    losses.atmospheric = res;
end



nargoutchk(0, 3)

loss_fields = fieldnames(losses);
loss_values = struct2cell(losses);
n_losses = length(loss_fields);
kwargs = cell(2 * n_losses, 1);
kwargs(1:2:end) = loss_fields;
kwargs(2:2:end) = loss_values;
loss_result = nodes.LossResult(kind, kwargs{:});

extras = {};
extras.("turbulent_beam_width") = beam_width;
extras.("r0") = r0;
extras.("total_loss") = loss_result.TotalLoss;
end
