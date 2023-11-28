classdef new_link_model
    properties (SetAccess = protected)
        receiver nodes.FreeSpaceReceiver
        transmitter nodes.FreeSpaceTransmitter
    end
    methods

        function new_link_model = new_link_model(satellite, groundstation, ...
                Receiver, Transmitter)
            arguments
                satellite nodes.Satellite
                groundstation nodes.Ground_Station
                Receiver {mustBeMember(Receiver, ...
                    {'Satellite', 'Ground Station'})}
                Transmitter {mustBeMember(Transmitter, ...
                    {'Satellite', 'Ground Station'})}
            end

            if contains(Receiver, 'Satellite')
                new_link_model.receiver = satellite.MakeFreeSpaceReceiver();
            end

            if contains(Receiver, 'Ground Station')
                new_link_model.receiver = groundstation.MakeFreeSpaceReceiver();
            end

            if contains(Transmitter, 'Satellite')
                new_link_model.transmitter = satellite.MakeFreeSpaceTransmitter();
            end

            if contains(Transmitter, 'Ground Station')
                new_link_model.transmitter = groundstation.MakeFreeSpaceTransmitter();
            end

        end

        function [geo, eff, apt, turb, atmos] = LinkLosses(link_model)
            arguments
                link_model new_link_model
            end

            geo = nodes.GeometricLoss(link_model.receiver, link_model.transmitter);
            eff = nodes.OpticalEfficiencyLoss(link_model.receiver, link_model.transmitter);
            apt = nodes.APTLoss(link_model.receiver, link_model.transmitter);
            turb = nodes.TurbulenceLoss(link_model.receiver, link_model.transmitter);
            atmos = nodes.AtmosphericLoss(link_model.receiver, link_model.transmitter);

        end

        function total = TotalLoss(link_model, options)
            arguments
                link_model new_link_model
                options.dB logical = false
            end

            [geo, eff, apt, turb, atmos] = link_model.LinkLosses();

            total = prod( [geo', eff', apt', turb', atmos'], 2)';

            if options.dB
                total = utilities.decibelFromPercentLoss(total);
            end

        end

    end
end
