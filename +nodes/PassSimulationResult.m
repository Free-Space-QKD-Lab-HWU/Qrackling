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

            % first, if multiple results are provided, call multiplot
            % instead
            if ~isscalar(result)
                fig = multiplot(result,'x_axis',options.x_axis,'mask',options.mask);
                return
            end

            % label and prepare figure
            figure_name = string(result.protocol.name) + " simulation from " ...
                + result.transmitter.name + " to " + string(result.receiver.name);

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
            %if mask is empty, return now
            if ~any(mask)
                mask = true(size(result.elevation));
                options.mask = "No";
                warning('requested mask contains no points. plotting all')
            end

            % Compute total key
            [total_secure_key, ~] = result.totalKeyRates();

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
            if any(mask)
                xlim([min(x_axis(mask)), max(x_axis(mask))])
            end

            % Plot map
            nexttile(3, [2, 1])
            if result.direction == nodes.LinkDirection.Downlink
                geoplot(result.transmitter.latitude, result.transmitter.longitude, '.')
                hold on
                geoplot(result.transmitter.latitude(mask), result.transmitter.longitude(mask), '.')

                labels = ["Satellite path", strcat(options.mask, " window")];

                if isscalar(result.receiver)
                    nodes.PassSimulationResult.plotLOS( ...
                        result.receiver, ...
                        mean(result.transmitter.altitude), ...
                        result.receiver.elevation_limit)
                    labels{end + 1} = result.receiver.name;
                    labels{end + 1} = 'Line-of-Sight';
                else
                    for rx_loc = result.receiver
                        nodes.PassSimulationResult.plotLOS( ...
                            rx_loc, ...
                            mean(result.transmitter.altitude), ...
                            result.receiver.elevation_limit)
                        labels{end + 1} = rx_loc.name;
                        labels{end + 1} = 'Line-of-Sight';
                    end
                end

                legend(labels, "Location", "north")
                geolimits( ...
                    mean([result.receiver.latitude]) + [-15, 15], ...
                    mean([result.receiver.longitude]) + [-15, 15])
                axes = gca();
                axes.FontName = get(groot(), "defaultAxesFontName");
                axes.FontSize = get(groot(), "defaultAxesFontSize");

            elseif result.direction == nodes.LinkDirection.Uplink
                geoplot(result.receiver.latitude, result.receiver.longitude, '.')
                hold on
                geoplot(result.receiver.latitude(mask), result.receiver.longitude(mask), '.')

                labels = ["Ground station", strcat(options.mask, " window")];

                if isscalar(result.transmitter)
                    nodes.PassSimulationResult.plotLOS( ...
                        result.transmitter, ...
                        mean(result.receiver.altitude), ...
                        result.transmitter.elevation_limit)
                    labels{end + 1} = result.transmitter.name;
                    labels{end + 1} = 'Line-of-Sight';
                else
                    for tx_loc = result.transmitter
                        nodes.PassSimulationResult.plotLOS( ...
                            tx_loc, ...
                            mean(result.receiver.altitude), ...
                            result.transmitter.elevation_limit)
                        labels{end + 1} = result.transmitter.name;
                        labels{end + 1} = 'Line-of-Sight';
                    end
                end

                legend(labels, "Location", "north")
                geolimits( ...
                    mean([result.transmitter.latitude]) + [-15, 15], ...
                    mean([result.transmitter.longitude]) + [-15, 15])
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
            total_loss_db = result.loss.totalLoss.dB;
            semilogy(total_loss_db(mask), result.secret_key_rate(mask), 'k-')
            xlabel("Link Loss (dB)")
            ylabel("Secret Key Rate (bps)")
            xlim([min(total_loss_db(mask)), max(total_loss_db(mask))])
            grid on
            ax = gca();
            ax.YAxisLocation = "right";
        end

        function fig = multiplot(results, options)
            % multiplot
            %
            % Visualizes key rate metrics, loss, noise, and link geometry
            % for multiple result objects in an array (from multiple
            % passes)

            arguments
                results (1,:) nodes.PassSimulationResult
                options.x_axis {mustBeMember(options.x_axis, {'Time', 'Elevation'})} = "Time"
                options.mask {mustBeMember(options.mask, {'Elevation', 'Communication', 'Line of sight', 'None'})} = "Elevation"
            end
            
            %% if, for some reason, a scalar result has been sent here, send to scalar plot
            if isscalar(results)
                fig = results.plot("mask",options.mask,"x_axis",options.x_axis);
                return
            end

            % label and prepare figure
            figure_name = string(results(1).protocol.name) + " simulation from " ...
                + strjoin(getManyProperties(results,'transmitter.name'),', ') + " to " + strjoin(getManyProperties(results,'receiver.name'),', ');

            fig = figure("Name", figure_name);
            tiledlayout(3, 3, "TileSpacing", "tight");

            % x axis must always be time to avoid confusion
            x_label = "Time";
            x_axis = results.time;

            % Apply mask
            switch options.mask
                case "Elevation"
                    masks = getManyProperties(results,'elevation_mask');
                    mask = and(masks{:});
                case "Communication"
                    mask = ~(isnan(results(1).secret_key_rate) | results(1).secret_key_rate <= 0);
                case "Line of sight"
                    elevations = getManyProperties(results,'elevation');
                    masks = cellfun(@(x) x>0, elevations, 'UniformOutput',false);
                    mask = and(masks{:});
                case "None"
                    mask = true(size(results(1).elevation));
            end
            %if mask is empty, return now
            if ~any(mask)
                mask = true(size(results.elevation));
                options.mask = "None";
                warning('requested mask contains no points. plotting all')
            end

            % Compute total key
            [total_secure_key, ~] = results(1).totalKeyRates();

            % Plot key rates
            nexttile([1, 2])
            colororder(colororder())
            yyaxis left
            hold on
            plot(x_axis(mask), results(1).secret_key_rate(mask), '-')
            plot(x_axis(mask), results(1).sifted_key_rate(mask), ':')

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
            plot(x_axis(mask), results(1).qber(mask) * 100)
            xlabel(x_label)
            ylabel("QBER (%)")
            legend("Secret Key Rate", "Sifted Key Rate", "")
            if any(mask)
                xlim([min(x_axis(mask)), max(x_axis(mask))])
            end

            % Plot map
            nexttile(3, [2, 1])
            if results(1).direction == nodes.LinkDirection.Downlink
                for sat_index = 1:size(results,1)
                    geoplot(results(sat_index,1).transmitter.latitude, results(1).transmitter.longitude, '.')
                    hold on
                    geoplot(results(sat_index,1).transmitter.latitude(mask), results(1).transmitter.longitude(mask), '.')
                end
                labels = ["Satellite path", strcat(options.mask, " window")];
                

                for ogs_num = 1:size(results,2)
                    nodes.PassSimulationResult.plotLOS( ...
                        results(1,ogs_num).receiver, ...
                        mean(results(1).transmitter.altitude), ...
                        results(1,ogs_num).receiver.elevation_limit)
                    labels{end + 1} = results(1,ogs_num).receiver.name;
                    labels{end + 1} = 'Line-of-Sight';
                end


                legend(labels, "Location", "north")
                axes = gca();
                axes.FontName = get(groot(), "defaultAxesFontName");
                axes.FontSize = get(groot(), "defaultAxesFontSize");

            elseif results.direction == nodes.LinkDirection.Uplink
                for sat_index = 1:size(results,2)
                    geoplot(results(1,sat_index).receiver.latitude, results(1).receiver.longitude, '.')
                    hold on
                    geoplot(results(1,sat_index).receiver.latitude(mask), results(1).receiver.longitude(mask), '.')
                end
                labels = ["Satellite path", strcat(options.mask, " window")];
                

                for ogs_num = 1:size(results,2)
                    nodes.PassSimulationResult.plotLOS( ...
                        results(ogs_num,1).transmitter, ...
                        mean(results(1).transmitter.altitude), ...
                        results(ogs_num,1).transmitter.elevation_limit)
                    labels{end + 1} = results(ogs_num,1).transmitter.name;
                    labels{end + 1} = 'Line-of-Sight';
                end

                legend(labels, "Location", "north")
                axes = gca();
                axes.FontName = get(groot(), "defaultAxesFontName");
                axes.FontSize = get(groot(), "defaultAxesFontSize");
            end

            % Plot link loss tolerance
            nexttile(9,[1,1])
            title("Link performance")
            total_loss_db = zeros(1,numel(results(1).elevation));
            for result = results
                total_loss_db = total_loss_db + result.loss.total_loss.dB;
            end
            semilogy(total_loss_db(mask), results(1).secret_key_rate(mask), 'k-')
            xlabel("Link Loss (dB)")
            ylabel("Secret Key Rate (bps)")
            xlim([min(total_loss_db(mask)), max(total_loss_db(mask))])
            grid on
            ax = gca();
            ax.YAxisLocation = "right";

            % Plot loss
            for j=1:numel(results)
                nexttile(1+3*j, [1, 2])
                results(j).loss.plotLosses(x_axis, x_label, "mask", mask)
                xlim([min(x_axis(mask)), max(x_axis(mask))])
            end




            %% define a function which allows the reading of properties from the multiple results objects simultaneously
            function properties = getManyProperties(results, name)

                % prepare memory
                properties = cell(size(results));

                % separate name into calls to different objects
                name = string(name);
                level_names = strsplit(name,'.');

                    for i = 1:numel(results)
                        current_level_property = results(i);
                        % iterating through the parts of the called property (e.g.
                        % .telescope.name => {'telescope','name'}
                        for current_level_name = level_names
                            current_level_property = getfield(current_level_property,current_level_name{1});
                        end
                        properties{i} = current_level_property;
                    end


            end

        end

    end


    methods (Static)
        function plotLOS(ogs_location, sat_altitude, elevation_limit)
            % PlotLOS
            %
            % Plots the line-of-sight window from a ground station to a satellite altitude.

            arguments
                ogs_location nodes.LocatedObject
                sat_altitude (1, :) {mustBeNumeric}
                elevation_limit {mustBeNumeric}
            end

            % Plot ground station
            geoplot(ogs_location.latitude, ogs_location.longitude, 'k*', 'MarkerSize', 20)
            hold on

            % Plot elevation window
            headings = 1:359;
            window_lat = zeros(1, 359);
            window_lon = zeros(1, 359);
            arc_distance = utilities.computeLOSWindow(sat_altitude, elevation_limit);

            for heading = headings
                [current_window_lat, current_window_lon] = utilities.moveAlongSurface( ...
                    ogs_location.latitude, ogs_location.longitude, arc_distance, heading);
                window_lat(heading) = current_window_lat;
                window_lon(heading) = current_window_lon;
            end

            geoplot(window_lat, window_lon, 'k--')
        end


        function result = empty()
            % empty
            %
            % Returns an empty PassSimulationResult object for initialization.

            result = nodes.PassSimulationResult( ...
                fibre.FibreNode.empty(), ...
                fibre.FibreNode.empty(), ...
                protocol.BB84());
        end
    end
end