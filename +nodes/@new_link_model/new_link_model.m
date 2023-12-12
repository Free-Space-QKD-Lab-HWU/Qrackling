classdef new_link_model
    % properties (SetAccess = protected)
    %     receiver nodes.FreeSpaceReceiver
    %     transmitter nodes.FreeSpaceTransmitter
    %     direction nodes.LinkDirection
    % end
    methods (Static = true)

        % function new_link_model = new_link_model(Transmitter, Receiver)
        %     arguments
        %         Transmitter {mustBeA(Transmitter, ...
        %             ["nodes.Satellite", "nodes.Ground_Station"])}
        %         Receiver {mustBeA(Receiver, ...
        %             ["nodes.Satellite", "nodes.Ground_Station"])}
        %     end

        %     new_link_model.receiver = nodes.freeSpaceReceiverFrom(Receiver);
        %     new_link_model.transmitter = nodes.freeSpaceTransmitterFrom(Transmitter);

        %     if isa(Receiver, "nodes.Satellite") && isa(Transmitter, "nodes.Ground_Station")
        %         new_link_model.direction = nodes.LinkDirection.Uplink;
        %     end

        %     if isa(Transmitter, "nodes.Satellite") && isa(Receiver, "nodes.Ground_Station")
        %         new_link_model.direction = nodes.LinkDirection.Downlink;
        %     end

        % end

        function losses = LinkLosses(receiver, transmitter, loss)
            arguments
                receiver {mustBeA(receiver, ["nodes.Satellite", "nodes.Ground_Station"])}
                transmitter {mustBeA(transmitter, ["nodes.Satellite", "nodes.Ground_Station"])}
            end
            arguments (Repeating)
                loss {mustBeMember(loss, { ...
                    'geometric', 'optical', 'apt', 'turbulence', 'atmospheric'})}
            end

            switch class(receiver)
            case "nodes.Ground_Station"
                direction = nodes.LinkDirection.Downlink;
            case "nodes.Satellite"
                direction = nodes.LinkDirection.Uplink;
            end

            losses = struct();

            for l = loss
                label = l{1};

                % only compute loss if label is not already present in losses,
                % skip if label is already present
                if any(contains(fieldnames(losses), label))
                    continue
                end

                switch label
                case 'geometric'
                    res = nodes.GeometricLoss(receiver, transmitter);
                case 'optical'
                    res = nodes.OpticalEfficiencyLoss(receiver, transmitter);
                case 'apt'
                    res = nodes.APTLoss(receiver, transmitter);
                case 'turbulence'
                    fried_param = FriedParameter(direction, ...
                        "Hufnagel_Valley", HufnagelValley.HV10_10);
                    res = nodes.TurbulenceLoss( ...
                        receiver, transmitter, fried_param);
                case 'atmospheric'
                    res = nodes.AtmosphericLoss(receiver, transmitter);
                end
                losses.(label) = res;
            end
        end

        function total = TotalLoss(receiver, transmitter, options)
            arguments
                receiver {mustBeA(receiver, ["nodes.Satellite", "nodes.Ground_Station"])}
                transmitter {mustBeA(transmitter, ["nodes.Satellite", "nodes.Ground_Station"])}
                options.dB logical = false
            end

            losses = nodes.new_link_model.LinkLosses( ...
                receiver, transmitter, ...
                "apt", "optical", "geometric", "turbulence", "atmospheric");


            %total = prod( [geo', eff', apt', turb', atmos'], 2)';
            total = prod(cell2mat(struct2cell(losses)), 1);

            if options.dB
                total = utilities.decibelFromPercentLoss(total);
            end
        end

        function fig = lossStackPlot(receiver, transmitter, options)
            arguments
                receiver {mustBeA(receiver, ["nodes.Satellite", "nodes.Ground_Station"])}
                transmitter {mustBeA(transmitter, ["nodes.Satellite", "nodes.Ground_Station"])}
                options.mask
            end

            losses = nodes.new_link_model.LinkLosses( ...
                receiver, transmitter, ...
                "apt", "optical", "geometric", "turbulence", "atmospheric");

            labels = fieldnames(losses);

            losses = cell2mat(struct2cell(losses));
            if contains(fieldnames(options), 'mask')
                losses = losses(:, options.mask);
            end

            losses_db = utilities.decibelFromPercentLoss(losses);

            timestamps = [];
            if any(contains(properties(receiver), 'Times'))
                timestamps = lm.receiver.Times;
            end

            if isempty(timestamps) && any(contains(properties(transmitter), 'Times'))
                timestamps = lm.transmitter.Times;
            else
                error("No timestamps in either receiver or transmitter");
            end

            if contains(fieldnames(options), 'mask')
                timestamps = timestamps(options.mask);
            end

            fig = figure();
            hold on
            area(timestamps, losses_db')
            legend(labels)

        end

    end
end
