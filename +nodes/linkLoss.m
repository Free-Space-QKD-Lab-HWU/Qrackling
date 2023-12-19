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
        options.Visibility = '50km'
    end

    unit = "probability";
    if options.dB
        unit = "dB";
    end

    losses = {};

    spot_size = options.SpotSize;
    link_length = options.LinkLength;

    if any(contains(string(loss), "geometric"))
        [res, spot_size, link_length] = ...
            nodes.GeometricLoss(kind, receiver, transmitter);
        losses.("geometric") = res.ConvertTo(unit);
    end

    if any(contains(string(loss), "turbulence"))
        switch class(receiver)
        case "nodes.Ground_Station"
            direction = nodes.LinkDirection.Downlink;
        case "nodes.Satellite"
            direction = nodes.LinkDirection.Uplink;
        end

        fried_param = FriedParameter(direction, "Hufnagel_Valley", HufnagelValley.HV10_10);

        [res, beam_width, r0] = nodes.TurbulenceLoss( ...
            kind, receiver, transmitter, fried_param, ...
            "LinkLength", link_length, ...
            "SpotSize", spot_size);

        losses.("turbulence") = res.ConvertTo(unit);
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
            res = nodes.AtmosphericLoss(kind, receiver, transmitter,'Visibility',options.Visibility);
        end

        losses.(label) = res.ConvertTo(unit);
    end

    nargoutchk(0, 3)

    % NOTE: is it worth moving this into a struct2kwargs function? would make it
    % possible to convert structs to function args. might be nice for constructors
    loss_fields = fieldnames(losses);
    loss_values = struct2cell(losses);
    n_losses = length(loss_fields);
    kwargs = cell(2 * n_losses, 1);
    kwargs(1:2:end) = loss_fields;
    kwargs(2:2:end) = loss_values;
    loss_result = nodes.LossResult(kind, kwargs{:});
    varargout{1} = loss_result;

    if 2 <= nargout()
        extras = {};
        extras.("turbulent_beam_width") = beam_width;
        extras.("r0") = r0;
        extras.("total_loss") = loss_result.TotalLoss(unit);
        varargout{2} = extras;
    end
end
