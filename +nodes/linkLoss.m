function varargout = linkLoss(kind, receiver, transmitter, loss, options)
    arguments
        kind {mustBeMember(kind, ["beacon", "qkd"])}
        receiver {mustBeA(receiver, ["nodes.Satellite", "nodes.Ground_Station"])}
        transmitter {mustBeA(transmitter, ["nodes.Satellite", "nodes.Ground_Station"])}
    end
    arguments (Repeating)
        loss {mustBeMember(loss, {'geometric', 'transmitter', 'apt', 'turbulence', 'atmospheric', 'receiver'})}
    end
    arguments
        options.dB logical = false
        options.SpotSize = []
        options.LinkLength = []
        options.environment environment.Environment
        options.N_Detectors = 4;
    end

    unit = "probability";
    if options.dB
        unit = "dB";
    end

    losses = {};
    LossResult = nodes.LossResult(kind);

    spot_size = options.SpotSize;
    link_length = options.LinkLength;

    if any(contains(string(loss), "geometric"))
        [res, spot_size, link_length] = ...
            nodes.GeometricLoss(kind, receiver, transmitter);
        LossResult = LossResult.addLoss(res.ConvertTo(unit));
    end

    if any(contains(string(loss), "turbulence"))
        switch class(receiver)
        case "nodes.Ground_Station"
            direction = nodes.LinkDirection.Downlink;
        case "nodes.Satellite"
            direction = nodes.LinkDirection.Uplink;
        end

        fried_param = environment.FriedParameter(direction, "Hufnagel_Valley", environment.HufnagelValley.HV10_10);

        [res, beam_width, r0] = nodes.TurbulenceLoss( ...
            kind, receiver, transmitter, fried_param, ...
            "LinkLength", link_length, ...
            "SpotSize", spot_size);

        LossResult = LossResult.addLoss(res.ConvertTo(unit));
    end

    for l = loss
        label = l{1};
      

        switch label
        case 'transmitter'
            res = nodes.TransmitterLoss(kind, transmitter);
        case 'apt'
            res = nodes.APTLoss(kind, receiver, transmitter);
        case 'atmospheric'
            %if isempty(options.environment)
            if ~contains(fieldnames(options), "environment")
                warning(['Atmospheric loss calculation requires an environment ', ...
                'See the "Environment" class. Add " "Environment" ', ...
                'to this functions arguments']);
            else
                res = nodes.AtmosphericLoss(kind, receiver, transmitter, options.environment);
            end
        end

        LossResult = LossResult.addLoss(res.ConvertTo(unit));
    end

    %dead time loss is nonlinear, in that it depends on the other channel
    %losses, receiver loss must be computed last
    if any(contains(string(loss), "receiver"))
        %compute loss up to detector
        total_prior_loss = LossResult.TotalLoss('probability').As('probability');
        receiver_loss = nodes.ReceiverLoss(kind, receiver, transmitter,total_prior_loss,options.N_Detectors);
        LossResult = LossResult.addLoss(receiver_loss.ConvertTo(unit));
    end

    nargoutchk(0, 3)
    varargout{1} = LossResult;

    if 2 <= nargout()
        extras = {};
        extras.("turbulent_beam_width") = beam_width;
        extras.("r0") = r0;
        extras.("total_loss") = LossResult.TotalLoss(unit);
        varargout{2} = extras;
    end
end
