classdef new_link_model
    properties (SetAccess = protected)
        receiver nodes.FreeSpaceReceiver
        transmitter nodes.FreeSpaceTransmitter
        direction nodes.LinkDirection
    end
    methods

        function new_link_model = new_link_model(Transmitter, Receiver)
            arguments
                Transmitter {mustBeA(Transmitter, ...
                    ["nodes.Satellite", "nodes.Ground_Station"])}
                Receiver {mustBeA(Receiver, ...
                    ["nodes.Satellite", "nodes.Ground_Station"])}
            end

            new_link_model.receiver = nodes.freeSpaceReceiverFrom(Receiver);
            new_link_model.transmitter = nodes.freeSpaceTransmitterFrom(Transmitter);

            if isa(Receiver, "nodes.Satellite") && isa(Transmitter, "nodes.Ground_Station")
                new_link_model.direction = nodes.LinkDirection.Uplink;
            end

            if isa(Transmitter, "nodes.Satellite") && isa(Receiver, "nodes.Ground_Station")
                new_link_model.direction = nodes.LinkDirection.Downlink;
            end

        end

        function losses = LinkLosses(lm, loss)
            arguments
                lm nodes.new_link_model
            end
            arguments (Repeating)
                loss {mustBeMember(loss, { ...
                    'geometric', 'optical', 'apt', ...
                    'turbulence', 'atmospheric'})}
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
                    res = nodes.GeometricLoss(lm.receiver, lm.transmitter);
                case 'optical'
                    res = nodes.OpticalEfficiencyLoss(lm.receiver, lm.transmitter);
                case 'apt'
                    res = nodes.APTLoss(lm.receiver, lm.transmitter);
                case 'turbulence'
                    fried_param = FriedParameter(lm.direction, ...
                        "Hufnagel_Valley", HufnagelValley.HV10_10);
                    res = nodes.TurbulenceLoss( ...
                        lm.receiver, lm.transmitter, fried_param);
                case 'atmospheric'
                    res = nodes.AtmosphericLoss(lm.receiver, lm.transmitter);
                end
                losses.(label) = res;
            end
        end

        function total = TotalLoss(lm, options)
            arguments
                lm nodes.new_link_model
                options.dB logical = false
            end

            losses = lm.LinkLosses("apt", "optical", "geometric", ...
                "turbulence", "atmospheric");


            %total = prod( [geo', eff', apt', turb', atmos'], 2)';
            total = prod(cell2mat(struct2cell(losses)), 1);

            if options.dB
                total = utilities.decibelFromPercentLoss(total);
            end
        end

        function fig = lossStackPlot(lm, options)
            arguments
                lm nodes.new_link_model
                options.mask
            end

            losses = lm.LinkLosses("apt", "optical", "geometric", ...
                "turbulence", "atmospheric");

            labels = fieldnames(losses);

            losses = cell2mat(struct2cell(losses));
            if contains(fieldnames(options), 'mask')
                losses = losses(:, options.mask);
            end

            losses_db = utilities.decibelFromPercentLoss(losses);

            timestamps = [];
            if any(contains(properties(lm.receiver), 'timestamps'))
                timestamps = lm.receiver.timestamps;
            end

            if isempty(timestamps) && any(contains(properties(lm.transmitter), 'timestamps'))
                timestamps = lm.transmitter.timestamps;
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
