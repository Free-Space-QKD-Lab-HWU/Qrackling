classdef Fibre
% Fibre
% Model of an optical fibre with length, bulk loss rate, and connector losses.
%
% Properties are in snake_case.
% Methods are in mixedCase (single word methods lower case).
%
% Usage:
%   f = Fibre(10);  % 10 m, 0.16 dB/km, 0.5 dB each connector
%   f = Fibre(10, loss_rate=0.2, connector_loss=[0.3 0.7]);
%
%   Ld = f.distanceLoss();     % distance loss
%   Lc = f.connectionsLoss();  % connectors loss
%   Lt = f.totalLoss();        % total fibre loss

    properties
        length       {mustBeNonnegative} = 0          % length in m
        loss_rate {mustBeNonnegative} = 0.00016     % loss rate in dB/m
        connector_loss (1,2) cell                        % connector losses as units.Loss
    end

    properties(Dependent)
        distance_loss
        connections_loss
        total_loss
    end

    methods
        function f = Fibre(length, options)
        % fibre constructor
        % length in metres.
        % options.loss_rate in dB/km (converted to dB/m internally).
        % options.connector_loss in dB; scalar applies to both ends, or [a b].

            arguments
                length {mustBeNonnegative}
                options.loss_rate {mustBeNonnegative} = 0.16
                options.connector_loss {mustBeNonnegative} = 0.5
            end

            f.length = length;
            f.loss_rate = options.loss_rate / 1000; % dB/m

            if isscalar(options.connector_loss)
                L = units.Loss(options.connector_loss);
                f.connector_loss = {L, L};
            else
                vals = options.connector_loss;
                f.connector_loss = {units.Loss(vals(1)), units.Loss(vals(2))};
            end
        end

        function loss = get.distance_loss(fibre)
        % distanceLoss  Loss due to absorption in the fibre
            arguments
                fibre fibre.Fibre
            end

            loss_dB = fibre.length * fibre.loss_rate;
            loss = units.Loss(10.^(-loss_dB/10), 'distance');
        end

        function loss = get.connections_loss(fibre)
        % connectionsLoss  Loss due to both connectors
            L1 = fibre.connector_loss{1};
            L2 = fibre.connector_loss{2};
            loss = units.Loss(L1 * L2, 'connectors');
        end

        function loss = get.total_loss(fibre)
        % totalLoss  Combined distance and connector losses
            arguments
                fibre fibre.Fibre
            end

            Ld = fibre.distance_loss;
            Lc = fibre.connections_loss;
            loss = units.Loss(Ld * Lc, 'fibre');
        end
    end
end