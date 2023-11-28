classdef new_link_model
    properties (SetAccess = protected)
        receiver
        transmitter
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
                new_link_model.receiver = satellite;
            end

            if contains(Receiver, 'Ground Station')
                new_link_model.receiver = groundstation;
            end

            if contains(Transmitter, 'Satellite')
                new_link_model.transmitter = satellite;
            end

            if contains(Transmitter, 'Ground Station')
                new_link_model.transmitter = groundstation;
            end

        end

        function [geo, eff, apt, turb, atmos] = LinkLosses(link_model)
            arguments
                link_model new_link_model
            end

            %TODO: Now we need to develop the methods that will convert our
            % satellite and ground stations to recievers or transmitters, see:
            % nodes.FreeSpaceReceiver and nodes.FreeSpaceTransmitter

            rx = link_model.receiver.as_receiver....
            tx = link_model.transmitter.as_tranmitter...

            geo = nodes.GeometricLoss(rx, tx);
            eff = nodes.OpticalEfficiencyLoss(rx, tx);
            apt = nodes.APTLoss(rx, tx);
            turb = nodes.TurbulenceLoss(rx, tx);
            atmos = nodes.AtmosphericLoss(rx, tx);

        end

    end
end
