classdef PassSimulationResult < nodes.QKDSimulationResult
% PassSimulationResult
%
% Stores and visualizes results from a QKD pass simulation, including
% link geometry, key rates, and loss/noise metrics.

    properties
        % direction - link direction (uplink/downlink)
        direction nodes.LinkDirection = nodes.LinkDirection.empty(0, 0)

        % heading - azimuth angles (degrees)
        heading (:, :) {mustBeNumeric} = []

        % elevation - elevation angles (degrees)
        elevation (:, :) {mustBeNumeric} = []

        % range - slant range (meters)
        range (:, :) {mustBeNumeric} = []

        % elevation_limit - elevation threshold for visibility
        elevation_limit (1, 1) double = 0

        % elevation_mask - logical mask for elevation filtering
        elevation_mask logical = false(1, 0)
    end


    methods
        function result = PassSimulationResult( ...
                transmitter, receiver, protocol, link_direction, ...
                heading, elevation, range, time, elevation_mask, ...
                loss, noise, sifted_key_rate, secret_key_rate, qber)
        % PassSimulationResult constructor

            arguments
                transmitter
                receiver
                protocol
                link_direction nodes.LinkDirection = nodes.LinkDirection.empty(0, 0)
                heading (:, :) {mustBeNumeric} = []
                elevation (:, :) {mustBeNumeric} = []
                range (:, :) {mustBeNumeric} = []
                time (:, :) = []
                elevation_mask logical = false(1, 0)
                loss nodes.LossResult = nodes.LossResult.empty(0, 0)
                noise environment.Noise = environment.Noise.empty(0, 0)
                sifted_key_rate (1, :) {mustBeNumeric} = []
                secret_key_rate (1, :) {mustBeNumeric} = []
                qber (1, :) {mustBeNumeric} = []
            end

            result@nodes.QKDSimulationResult( ...
                transmitter, receiver, protocol, time, ...
                loss, noise, sifted_key_rate, secret_key_rate, qber)

            result.direction = link_direction;
            result.heading = heading;
            result.elevation = elevation;
            result.range = range;
            result.elevation_mask = elevation_mask;
        end


        function fig = plot(result, options)
        % plot
        %
        % Visualizes key rate metrics, loss, noise, and link geometry.

            arguments
                result nodes.PassSimulationResult
                options.x_axis {mustBeMember(options.x_axis, {'Time', 'Elevation'})} = "Time"
                options.mask {mustBeMember(options.mask, {'Elevation', 'Communication', 'Line of sight', 'None'})} = "Elevation"
            end

            figure_name = string(result.protocol.name) + " simulation from " ...
                + result.transmitter.Name + " to " + result.receiver.Name;

            fig = figure("Name", figure_name);
            tiledlayout(3, 3, "TileSpacing", "tight");

            % Determine x-axis
            switch options.x_axis
                case "Time"
                    x_label = "Time";
                    x_axis = result.time;
                case "Elevation"
                    x_label = "Elevation (deg)";
                    x_axis = result.elevation;
            end

            % Apply mask
            switch options.mask
                case "Elevation"
                    mask = result.elevation_mask;
                case "Communication"
                    mask = ~(isnan(result.secret_key_rate) | result.secret_key_rate <= 0);
                case "Line of sight"
                    mask = result.elevation > 0;
                case "None"
                    mask = true(size(result.elevation));
            end

            % Compute total key
            [total_secure_key, ~] = result.total_key_rates();

            % Plot key rates
            nexttile([1, 2])
            colororder(colororder())
            yyaxis left
            hold on
            plot(x_axis(mask), result.secret_key_rate(mask), '-')
            plot(x_axis(mask), result.sifted_key_rate(mask), ':')

            xlabel(x_label)
            ylabel("Rate (bits/s)")
            text(0.5, 0.5, ...
                sprintf("Total secret key\ntransferred = %3.2g", total_secure_key), ...
                "Units", "Normalized", ...
                "VerticalAlignment", "middle", ...
                "HorizontalAlignment", "center", ...
                "FontName", get(groot, "defaultAxesFontName"), ...
                "FontSize", get(groot, "defaultAxesFontSize"))

            % Plot QBER
            yyaxis right
            plot(x_axis(mask), result.qber(mask) * 100)
            xlabel(x_label)
            ylabel("QBER (%)")
            legend("Secret Key Rate", "Sifted Key Rate", "")
            xlim([min(x_axis(mask)), max(x_axis(mask))])

            % Plot map
            nexttile(3, [2, 1])
            if result.direction == nodes.LinkDirection.Downlink
                geoplot(result.transmitter.Latitude, result.transmitter.Longitude, '.')
                hold on
                geoplot(result.transmitter.Latitude(mask), result.transmitter.Longitude(mask), '.')

                labels = ["Satellite path", strcat(options.mask, " window")];

                if isscalar(result.receiver)
                    nodes.PassSimulationResult.PlotLOS( ...
                        result.receiver, ...
                        mean(result.transmitter.Altitude), ...
                        result.receiver.Elevation_Limit)
                    labels{end + 1} = result.receiver.Name;
                    labels{end + 1} = "Line-of-Sight";
                else
                    for rx_loc = result.receiver
                        nodes.PassSimulationResult.PlotLOS( ...
                            rx_loc, ...
                            mean(result.transmitter.Altitude), ...
                            result.receiver.Elevation_Limit)
                        labels{end + 1} = rx_loc.Name;
                        labels{end + 1} = "Line-of-Sight";
                    end
                end

                legend(labels, "Location", "north")
                geolimits( ...
                    mean([result.receiver.Latitude]) + [-15, 15], ...
                    mean([result.receiver.Longitude]) + [-15, 15])
                axes = gca();
                axes.FontName = get(groot(), "defaultAxesFontName");
                axes.FontSize = get(groot(), "defaultAxesFontSize");

            elseif result.direction == nodes.LinkDirection.Uplink
                geoplot(result.receiver.Latitude, result.receiver.Longitude, '.')
                hold on
                geoplot(result.receiver.Latitude(mask), result.receiver.Longitude(mask), '.')

                labels = ["Ground station", strcat(options.mask, " window")];

                if isscalar(result.transmitter)
                    nodes.PassSimulationResult.PlotLOS( ...
                        result.transmitter, ...
                        mean(result.receiver.Altitude), ...
                        result.receiver.Elevation_Limit)
                    labels{end + 1} = result.transmitter.Name;
                    labels{end + 1} = "Line-of-Sight";
                else
                    for tx_loc = result.transmitter
                        nodes.PassSimulationResult.PlotLOS( ...
                            tx_loc, ...
                            mean(result.receiver.Altitude), ...
                            result.receiver.Elevation_Limit)
                        labels{end + 1} = tx_loc.Name;
                        labels{end + 1} = "Line-of-Sight";
                    end
                end

                legend(labels, "Location", "north")
                geolimits( ...
                    mean([result.transmitter.Latitude]) + [-15, 15], ...
                    mean([result.transmitter.Longitude]) + [-15, 15])
                axes = gca();
                axes.FontName = get(groot(), "defaultAxesFontName");
                axes.FontSize = get(groot(), "defaultAxesFontSize");
            end

            % Plot loss
            nexttile(4, [1, 2])
            result.loss.plotLosses(x_axis, x_label, "mask", mask)
            xlim([min(x_axis(mask)), max(x_axis(mask))])

            % Plot background counts
            nexttile(7, [1, 2])
            title("BCR (counts/s)")
            n_sources = numel(result.noise);
            n_points = numel(result.noise(1).values);
            bcr_data = reshape([result.noise.values], [n_points, n_sources]);
            area(x_axis(mask), bcr_data(mask, :))
            xlabel(x_label)
            lgd = legend(result.noise.label);
            lgd.NumColumns = 1;
            xlim([min(x_axis(mask)), max(x_axis(mask))])

            % Plot link loss tolerance
            nexttile()
            title("Link performance")
            total_loss_db = result.loss.TotalLoss.dB;
            semilogy(total_loss_db(mask), result.secret_key_rate(mask), 'k-')
            xlabel("Link Loss (dB)")
            ylabel("Secret Key Rate (bps)")
            xlim([min(total_loss_db(mask)), max(total_loss_db(mask))])
            grid on
            ax = gca();
            ax.YAxisLocation = "right";
        end
    end


    methods (Static)
        function PlotLOS(ogs_location, sat_altitude, elevation_limit)
        % PlotLOS
        %
        % Plots the line-of-sight window from a ground station to a satellite altitude.

            arguments
                ogs_location nodes.Located_Object
                sat_altitude (1, :) {mustBeNumeric}
                elevation_limit {mustBeNumeric}
            end

            % Plot ground station
            geoplot(ogs_location.Latitude, ogs_location.Longitude, 'k*', 'MarkerSize', 20)
            hold on

            % Plot elevation window
            Headings = 1:359;
            WindowLat = zeros(1, 359);
            WindowLon = zeros(1, 359);
            ArcDistance = utilities.ComputeLOSWindow(sat_altitude, elevation_limit);

            for Heading = Headings
                [CurrentWindowLat, CurrentWindowLon] = utilities.MoveAlongSurface( ...
                    ogs_location.Latitude, ogs_location.Longitude, ArcDistance, Heading);
                WindowLat(Heading) = CurrentWindowLat;
                WindowLon(Heading) = CurrentWindowLon;
            end

            geoplot(WindowLat, WindowLon, 'k--')
        end


        function result = empty()
        % empty
        %
        % Returns an empty PassSimulationResult object for initialization.

            result = nodes.PassSimulationResult( ...
                fibre.Fibre_Node.empty(), ...
                fibre.Fibre_Node.empty(), ...
                protocol.bb84());
        end
    end
end