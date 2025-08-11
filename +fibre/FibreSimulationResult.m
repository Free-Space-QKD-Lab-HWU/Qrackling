classdef FibreSimulationResult < nodes.QKDSimulationResult
% FibreSimulationResult
%
% Simulation results for a fibre QKD link, adding range to the base
% simulation result and providing plotting utilities.
%
% Syntax:
% result = fibre.FibreSimulationResult(transmitter, receiver, protocol, ...)
%
% Inputs:
% transmitter, receiver, protocol - as per nodes.QKDSimulationResult
% time                - timeline (optional)
% loss                - nodes.LossResult (optional)
% noise               - environment.Noise array (optional)
% sifted_key_rate     - numeric row vector (optional)
% secret_key_rate     - numeric row vector (optional)
% qber                - numeric row vector (optional)
% range               - numeric row vector (optional)

    properties
        range (1, :) {mustBeNonnegative}  % link range (units as per simulation)
    end


    methods
        function result = FibreSimulationResult(transmitter, receiver, protocol, ...
                time, loss, noise, sifted_key_rate, secret_key_rate, qber, range)
        % FibreSimulationResult
        %
        % Construct a FibreSimulationResult object.
        %
        % Syntax:
        % result = fibre.FibreSimulationResult(transmitter, receiver, protocol, ...)
        %
        % Inputs:
        % transmitter - transmitter node
        % receiver    - receiver node
        % protocol    - QKD protocol
        % time        - timeline (optional)
        % loss        - loss result object (optional)
        % noise       - array of noise sources (optional)
        % sifted_key_rate - row vector of sifted key rates (optional)
        % secret_key_rate - row vector of secret key rates (optional)
        % qber        - row vector of QBER values (optional)
        % range       - row vector of link ranges (optional)
        %
        % Output:
        % result - FibreSimulationResult object

            arguments
                transmitter
                receiver
                protocol
                time (:, :) = []
                loss nodes.LossResult = nodes.LossResult.empty()
                noise environment.Noise = environment.Noise.empty(0, 0)
                sifted_key_rate (1, :) {mustBeNumeric} = []
                secret_key_rate (1, :) {mustBeNumeric} = []
                qber (1, :) {mustBeNumeric} = []
                range (:, :) {mustBeNumeric} = []
            end

            % Call superclass constructor
            result@nodes.QKDSimulationResult( ...
                transmitter, receiver, protocol, time, ...
                loss, noise, sifted_key_rate, secret_key_rate, qber);

            % Store fibre-specific property
            result.range = range;
        end


        function fig = plot(result, options)
        % plot
        %
        % Visualize simulation results including key rates, QBER, map,
        % loss breakdown, and background count rates.
        %
        % Syntax:
        % fig = result.plot(options)
        %
        % Inputs:
        % options.x_axis - string, 'Time' (default)
        % options.mask   - string, 'Communication' or 'None' (default: 'Communication')
        %
        % Output:
        % fig - figure handle

            arguments
                result fibre.FibreSimulationResult
                options.x_axis {mustBeMember(options.x_axis, {'Time'})} = "Time"
                options.mask   {mustBeMember(options.mask, {'Communication','None'})} = "Communication"
            end

            %% Expand single timestep if needed
            if isscalar(result.time)
                result.time = [result.time, result.time + seconds(1)];
                result.sifted_key_rate = result.sifted_key_rate * ones(1, 2);
                result.secret_key_rate = result.secret_key_rate * ones(1, 2);
                result.qber = result.qber * ones(1, 2);

                for i = 1:numel(result.noise)
                    result.noise(i).values = result.noise(i).values * ones(1, 2);
                end

                for i = 1:numel(result.loss.losses)
                    Li = result.loss.losses{i};
                    result.loss.losses{i} = units.Loss(Li * ones(1, 2), Li.name);
                end
            end

            %% Create figure
            figure_name = string(result.protocol.name) + " simulation from " ...
                + result.transmitter.Name + " to " + result.receiver.Name;

            fig = figure("Name", figure_name);
            tiledlayout(3, 3, "TileSpacing", "tight");

            %% X-axis
            switch options.x_axis
                case "Time"
                    x_label = "Time";
                    x_axis = result.time;
            end

            %% Mask
            switch options.mask
                case "Communication"
                    mask = ~(isnan(result.secret_key_rate) | (result.secret_key_rate <= 0));
                case "None"
                    mask = true(size(result.time));
            end

            if ~any(mask)
                mask = true(size(result.time));
            end

            %% Total key
            [total_secure_key, ~] = result.totalKeyRates();

            %% Plot key rates and QBER
            nexttile([1, 2]);
            yyaxis left; hold on;
            plot(x_axis(mask), result.secret_key_rate(mask), '-');
            plot(x_axis(mask), result.sifted_key_rate(mask), ':');
            xlabel(x_label);
            ylabel('Rate (bits/s)');

            text(0.5, 0.5, ...
                sprintf('Total secret key transferred = %3.2g', total_secure_key), ...
                'Units', 'Normalized', ...
                'VerticalAlignment', 'middle', ...
                'HorizontalAlignment', 'center', ...
                'FontName', get(groot, 'defaultAxesFontName'), ...
                'FontSize', get(groot, 'defaultAxesFontSize'));

            yyaxis right;
            plot(x_axis(mask), result.qber(mask) .* 100);
            ylabel('QBER (%)');
            legend('Secret Key Rate', 'Sifted Key Rate', 'QBER', 'Location', 'best');

            %% Map of path
            nexttile(3, [2, 1]);
            labels = {};
            hold on;

            for tx_loc = result.transmitter
                geoplot(tx_loc.Latitude, tx_loc.Longitude, 'g+');
                labels = [labels, {['Transmitter: ', tx_loc.Name]}]; %#ok<AGROW>
            end

            for rx_loc = result.receiver
                geoplot(rx_loc.Latitude, rx_loc.Longitude, 'rx');
                labels = [labels, {['Receiver: ', rx_loc.Name]}]; %#ok<AGROW>
            end

            legend(labels, 'Location', 'southwest');

            %% Loss breakdown
            nexttile(4, [1, 2]);
            result.loss.plotLosses(x_axis, x_label, "mask", mask);
            xlim([min(x_axis(mask)), max(x_axis(mask))]);

            %% Background count rates
            nexttile(7, [1, 2]);
            title('BCR (counts/s)');
            n_sources = numel(result.noise);
            n_points = numel(result.noise(1).values);
            bcr_data = reshape([result.noise.values], [n_points, n_sources]);
            area(x_axis(mask), bcr_data(mask, :));
            xlabel(x_label);

            lgd = legend(result.noise.label);
            lgd.NumColumns = 1;
            xlim([min(x_axis(mask)), max(x_axis(mask))]);

            %% Link performance vs total loss
            nexttile();
            title('Link performance');
            total_loss_db = result.loss.TotalLoss.dB;
            semilogy(total_loss_db(mask), result.secret_key_rate(mask), 'k-');
            xlabel('Link Loss (dB)');
            ylabel('Secret Key Rate (bps)');
            grid on;

            ax = gca;
            ax.YAxisLocation = 'right';
        end
    end


    methods (Static)
        function result = empty()
        % empty
        %
        % Create a default FibreSimulationResult with a BB84 protocol.
        %
        % Syntax:
        % result = fibre.FibreSimulationResult.empty()
        %
        % Output:
        % result - empty FibreSimulationResult object

            result = fibre.FibreSimulationResult( ...
                fibre.Fibre_Node.empty(), ...
                fibre.Fibre_Node.empty(), ...
                protocol.bb84());
        end
    end
end