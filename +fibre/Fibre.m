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
        length_m       {mustBeNonnegative} = 0          % length in m
        loss_rate_db_m {mustBeNonnegative} = 0.00016     % loss rate in dB/m
        connector_loss (1,2) cell                        % connector losses as units.Loss
    end

    methods
        function f = Fibre(length_m, options)
        % fibre constructor
        % length_m in metres.
        % options.loss_rate in dB/km (converted to dB/m internally).
        % options.connector_loss in dB; scalar applies to both ends, or [a b].

            arguments
                length_m {mustBeNonnegative}
                options.loss_rate {mustBeNonnegative} = 0.16
                options.connector_loss {mustBeNonnegative} = 0.5
            end

            f.length_m = length_m;
            f.loss_rate_db_m = options.loss_rate / 1000; % dB/m

            if isscalar(options.connector_loss)
                L = units.Loss(options.connector_loss);
                f.connector_loss = {L, L};
            else
                vals = options.connector_loss;
                f.connector_loss = {units.Loss(vals(1)), units.Loss(vals(2))};
            end
        end

        function loss = distanceLoss(fibre)
        % distanceLoss  Loss due to absorption in the fibre
            arguments
                fibre Fibre
            end

            loss_dB = fibre.length_m * fibre.loss_rate_db_m;
            loss = units.Loss(10.^(-loss_dB/10), 'distance');
        end

        function loss = connectionsLoss(fibre)
        % connectionsLoss  Loss due to both connectors
            L1 = fibre.connector_loss{1};
            L2 = fibre.connector_loss{2};
            loss = units.Loss(L1 * L2, 'connectors');
        end

        function loss = totalLoss(fibre)
        % totalLoss  Combined distance and connector losses
            arguments
                fibre Fibre
            end

            Ld = fibre.distanceLoss();
            Lc = fibre.connectionsLoss();
            loss = units.Loss(Ld * Lc, 'fibre');
        end
    end
end