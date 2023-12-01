classdef new_link_model
    properties (SetAccess = protected)
        receiver nodes.FreeSpaceReceiver
        transmitter nodes.FreeSpaceTransmitter
        direction nodes.LinkDirection
    end
    methods

        function new_link_model = new_link_model(satellite, groundstation, ...
                Receiver, Transmitter)
            % TODO: change the entry point here. Instead of taking satellite and
            % ground station, we should instead take receiver and transmitter,
            % ensure that each of these is a Satellite.m or Ground_Station.m
            % and use the order of arguments to correctly produce the free-space
            % receiver and transmitter objects
            arguments
                satellite nodes.Satellite
                groundstation nodes.Ground_Station
                Receiver {mustBeMember(Receiver, ...
                    {'Satellite', 'Ground_Station'})}
                Transmitter {mustBeMember(Transmitter, ...
                    {'Satellite', 'Ground_Station'})}
            end

            disp(Receiver)

            % NOTE: This is maybe a bit cryptic and also places dependency on 
            % the argument names in nodes.freeSpaceReceiverFrom and in 
            % nodes.freeSpaceTransmitterFrom
            rx_tx = {satellite, groundstation};
            rx_idx = contains({'Satellite', 'Ground_Station'}, Receiver);
            tx_idx = contains({'Satellite', 'Ground_Station'}, Transmitter);
            new_link_model.receiver = nodes.freeSpaceReceiverFrom(string(Receiver), rx_tx{rx_idx});
            new_link_model.transmitter = nodes.freeSpaceTransmitterFrom(string(Transmitter), rx_tx{tx_idx});

            if strcmp(Receiver, 'Satellite') && strcmp(Transmitter, 'Ground_Station')
                new_link_model.direction = nodes.LinkDirection.Uplink;
            end

            if strcmp(Receiver, 'Ground_Station') && strcmp(Transmitter, 'Satellite')
                new_link_model.direction = nodes.LinkDirection.Downlink;
            end

        end

        function [geo, eff, apt, turb, atmos] = LinkLosses(lm)
            arguments
                lm nodes.new_link_model
            end

            geo = nodes.GeometricLoss(lm.receiver, lm.transmitter);
            eff = nodes.OpticalEfficiencyLoss(lm.receiver, lm.transmitter);
            apt = nodes.APTLoss(lm.receiver, lm.transmitter);

            fried_param = FriedParameter( ...
                lm.direction, ...
                "Hufnagel_Valley", HufnagelValley.HV10_10);

            turb = nodes.TurbulenceLoss( ...
                lm.receiver, ...
                lm.transmitter, ...
                fried_param);
            atmos = nodes.AtmosphericLoss(lm.receiver, lm.transmitter);

        end

        function total = TotalLoss(lm, options)
            arguments
                lm nodes.new_link_model
                options.dB logical = false
            end

            [geo, eff, apt, turb, atmos] = lm.LinkLosses();

            total = prod( [geo', eff', apt', turb', atmos'], 2)';

            if options.dB
                total = utilities.decibelFromPercentLoss(total);
            end

        end

    end
end