function varargout = linkLoss(kind, receiver, transmitter, loss, options)
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
    link_length = options.LinkLength;

    if any(contains(string(loss), "geometric"))
        [losses.("geometric"), spot_size, link_length] = ...
            nodes.GeometricLoss(kind, receiver, transmitter);
    end

    if any(contains(string(loss), "turbulence"))
        switch class(receiver)
        case "nodes.Ground_Station"
            direction = nodes.LinkDirection.Downlink;
        case "nodes.Satellite"
            direction = nodes.LinkDirection.Uplink;
        end

        fried_param = FriedParameter(direction, "Hufnagel_Valley", HufnagelValley.HV10_10);

        [losses.("turbulence"), beam_width, r0] = nodes.TurbulenceLoss( ...
            kind, receiver, transmitter, fried_param, ...
            "LinkLength", link_length, ...
            "SpotSize", spot_size);
    end

    for l = loss
        label = l{1};
        % we potentially have already calculated the geometric and turbulence
        % losses, so we should skip them
        if any(contains(fieldnames(losses), label))
            continue
        end

        switch label
        case 'optical'
            res = nodes.OpticalEfficiencyLoss(kind, receiver, transmitter);
        case 'apt'
            res = nodes.APTLoss(kind, receiver, transmitter);
        case 'atmospheric'
            res = nodes.AtmosphericLoss(kind, receiver, transmitter);
        end

        if options.dB
            res = utilities.decibelFromPercentLoss(res);
        end

        losses.(label) = res;
    end

    nargoutchk(0, 3)

    unit = "percent";
    if options.dB
        unit = "decibel";
    end

    loss_fields = fieldnames(losses);
    loss_values = struct2cell(losses);
    n_losses = length(loss_fields);
    kwargs = cell(2 * n_losses, 1);
    kwargs(1:2:end) = loss_fields;
    kwargs(2:2:end) = loss_values;
    loss_result = nodes.LossResult(unit, kind, kwargs{:});
    varargout{1} = loss_result;

    if 2 <= nargout()
        extras = {};
        extras.("turbulent_beam_width") = beam_width;
        extras.("r0") = r0;
        if options.dB
            total = sum(cell2mat(struct2cell(losses)), 1);
        else
            total = prod(cell2mat(struct2cell(losses)), 1);
        end
        extras.("total_loss") = total;
        varargout{2} = extras;
    end
end
