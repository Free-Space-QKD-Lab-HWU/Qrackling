classdef Fibre
    properties
        length {mustBeNonnegative} = 0 % length in m
        loss_rate {mustBeNonnegative} = 0.00016 % loss in dB/m
        connector_loss (1,2) cell % loss in dB
    end
    methods
        function f = Fibre(length, options)
        %%FIBRE constructor for a fibre object. Takes length in m and loss
        %%rate in dB/km
            arguments
                length {mustBeNonnegative}
                options.loss_rate {mustBeNonnegative} = 0.16
                options.connector_loss {mustBeNonnegative} = 0.5;
            end
            f.length = length;
            loss_rate_dB_per_m = options.loss_rate/1000;
            f.loss_rate = loss_rate_dB_per_m;

            %deal with connector loss
            if isscalar(options.connector_loss)
                f.connector_loss = {units.Loss(options.connector_loss),units.Loss(options.connector_loss)};
            else
                f.connector_loss = units.Loss(options.connector_loss);
            end
        end

        function loss = distance_loss(fibre)
            %%DISTANCE_LOSS return the loss due to absorption in the fibre
            arguments
                fibre fibre.Fibre
            end

            loss_dB = fibre.length*fibre.loss_rate;
            loss = units.Loss(10^-(loss_dB/10),'distance');
        end

        function loss = connections_loss(fibre)
            %%CONNECTION_LOSS return the loss due to connectors at both
            %%fibre ends

            loss = units.Loss(fibre.connector_loss{1}*fibre.connector_loss{2},'connector');
        end

        function loss = total_loss(fibre)
            %%DISTANCE_LOSS return the loss due to absorption in the fibre
            arguments
                fibre fibre.Fibre
            end

            distance_loss = fibre.distance_loss();
            connections_loss = fibre.connections_loss;
            loss = units.Loss(distance_loss*connections_loss,'fibre');
        end
    end
end


