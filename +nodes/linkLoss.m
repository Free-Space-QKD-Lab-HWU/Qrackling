function varargout = linkLoss(kind, receiver, transmitter, loss, options)
    arguments
        kind {mustBeMember(kind, ["beacon", "qkd"])}
        receiver {mustBeA(receiver, ["nodes.Satellite", "nodes.Ground_Station"])}
        transmitter {mustBeA(transmitter, ["nodes.Satellite", "nodes.Ground_Station"])}
    end
    arguments (Repeating)
        loss {mustBeMember(loss, {'geometric', 'optical', 'apt', 'turbulence', 'atmospheric', 'dead_time'})}
    end
    arguments
        options.dB logical = false
        options.SpotSize = []
        options.LinkLength = []
        options.environment environment.Environment
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

        fried_param = environment.FriedParameter(direction, "Hufnagel_Valley", environment.HufnagelValley.HV10_10);

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
            %if isempty(options.environment)
            if ~contains(fieldnames(options), "environment")
                warning(['Atmospheric loss calculation requires an environment ', ...
                'See the "Environment" class. Add " "Environment" ', ...
                'to this functions arguments']);
            else
                res = nodes.AtmosphericLoss(kind, receiver, transmitter, options.environment);
            end
        end

        losses.(label) = res.ConvertTo(unit);
    end

    %dead time loss is nonlinear, in that it depends on the other channel
    %losses, so must be computed last
    if any(contains(string(loss), "dead_time"))
        
        assert(~isequal(kind,'beacon'),'beacon links do not suffer from dead time loss')
        %read all losses up to detector clicking
        individual_losses_to_now = cellfun(@(x) As(x,'probability'),struct2cell(losses),'UniformOutput',false);
        %format into single vector of total loss
        total_loss_to_now = prod(cell2mat(individual_losses_to_now),1);
        %compute detector photon arrival rate
        photon_detection_rate = transmitter.Source.Repetition_Rate*total_loss_to_now + receiver.Detector.Dark_Count_Rate;
        %compute dead time loss
        dead_time_loss = receiver.Detector.DeadTimeLoss(photon_detection_rate);
        %store in loss record
        losses.dead_time = dead_time_loss.ConvertTo(unit);
            
    end

    nargoutchk(0, 3)

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
