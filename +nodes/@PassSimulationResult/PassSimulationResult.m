classdef PassSimulationResult
    properties
        transmitter_name = []
        receiver_name = []
        transmitter_location (1, :) = [] %nodes.Located_Object.empty(0, 0)
        receiver_location (1, :) = [] %nodes.Located_Object.empty(0, 0)
        protocol_name = ""
        direction nodes.LinkDirection = nodes.LinkDirection.empty(0,0)
        heading (:, :) {mustBeNumeric} = []
        elevation (:, :) {mustBeNumeric} = []
        range (:, :) {mustBeNumeric} = []
        time (:, :) = []
        elevation_limit = 0
        elevation_mask (1, :) {mustBeNumericOrLogical} = []
        loss nodes.LossResult = nodes.LossResult.empty(0, 0)
        noise environment.Noise = environment.Noise.empty(0, 0)
        sifted_key_rate (1, :) {mustBeNumeric} = []
        secret_key_rate (1, :) {mustBeNumeric} = []
        qber (1, :) {mustBeNumeric} = []
    end

    methods
        function result = PassSimulationResult(receiver, transmitter, ...
            transmitter_location, receiver_location, ...
            link_direction, heading, elevation, range, time, ...
            limit, elevation_mask, ...
            loss, noise, ...
            sifted_key_rate, secret_key_rate, qber, protocol_name)
            arguments
                receiver { ...
                    nodes.mustBeReceiverOrTransmitter(receiver), ...
                    nodes.mustHaveDetector(receiver) } = {}
                transmitter { ...
                    nodes.mustBeReceiverOrTransmitter(transmitter), ...
                    nodes.mustHaveSource(transmitter) } = {}
                transmitter_location (1, :) = nodes.Located_Object.empty(0, 0)
                receiver_location (1, :) = nodes.Located_Object.empty(0, 0)
                link_direction nodes.LinkDirection = nodes.LinkDirection.empty(0,0)
                heading (:, :) {mustBeNumeric} = []
                elevation (:, :) {mustBeNumeric} = []
                range (:, :) {mustBeNumeric} = []
                time (:, :) = []
                limit {mustBeNumeric} = 0
                elevation_mask (1, :) {mustBeNumericOrLogical} = []
                loss nodes.LossResult = nodes.LossResult.empty(0, 0)
                noise environment.Noise = environment.Noise.empty(0, 0)
                sifted_key_rate (1, :) {mustBeNumeric} = []
                secret_key_rate (1, :) {mustBeNumeric} = []
                qber (1, :) {mustBeNumeric} = []
                protocol_name {mustBeText} = ""
            end

            if isscalar(transmitter)
                result.transmitter_name = string(utilities.node_name(transmitter));
            else
                result.transmitter_name = string( ...
                    cellfun(@(tx) utilities.node_name(tx), transmitter, ...
                            "UniformOutput", false));
            end

            if isscalar(receiver)
                result.receiver_name = string(utilities.node_name(receiver));
            else
                result.receiver_name = string( ...
                    cellfun(@(tx) utilities.node_name(tx), receiver, ...
                            "UniformOutput", false));
            end

            result.transmitter_location = transmitter_location;
            result.receiver_location = receiver_location;

            result.direction = link_direction;
            result.heading = heading;
            result.elevation = elevation;
            result.range = range;
            result.time = time;
            result.elevation_limit = limit;
            result.elevation_mask = elevation_mask;
            result.loss = loss;
            result.noise = noise;
            result.sifted_key_rate = sifted_key_rate;
            result.secret_key_rate = secret_key_rate;
            result.qber = qber;
            result.protocol_name = protocol_name;
        end

        function [total_secret, total_sifted] = total_key_rates(result)
            arguments
                result nodes.PassSimulationResult
            end

            communicating = ~(isnan(result.secret_key_rate) | (result.secret_key_rate <= 0));
            time = result.time;
            time_window_widths = time([false, communicating(1:end-1)]) - time(communicating(2:end));




            if isempty(time_window_widths)
                warning("No communication occurs in this simulation");
                total_secret = 0;
                total_sifted = 0;
                return
            end

            if isnumeric(time_window_widths)
                total_sifted  = dot(time_window_widths, result.sifted_key_rate(communicating(1:end-1)));
                total_secret = dot(time_window_widths, result.secret_key_rate(communicating(1:end-1)));
                return
            end

            time_seconds = seconds(time_window_widths);
            total_sifted  = dot(time_seconds, result.sifted_key_rate(communicating(1:end-1)));
            total_secret = dot(time_seconds, result.secret_key_rate(communicating(1:end-1)));
        end

        function fig = plot(result, options)
            arguments
                result nodes.PassSimulationResult
                options.x_axis {mustBeMember(options.x_axis, { ...
                    'Time', 'Elevation'})} = "Time"
                options.mask {mustBeMember(options.mask, { ...
                    'Elevation', 'Communication', 'Line of sight', 'None'})} = "Elevation"
            end

            x_label = 'Time';
            x_axis = result.time;
            if numel(result.receiver_name) > 1
                x_axis = result.time(1, :);
                total_loss_db = result.loss(1).TotalLoss("dB").values ...
                    + result.loss(2).TotalLoss("dB").values;
            else
                total_loss_db = result.loss.TotalLoss("dB").values;
            end

            if string(options.x_axis) == "Elevation"
                x_axis = result.elevation;
                x_label = 'Elevation (deg)';
            end

            mask = result.elevation_mask;

            switch options.mask
            case "Elevation"
                mask = result.elevation_mask;
            case "Communication"
                mask = ~(isnan(result.secret_key_rate) | (result.secret_key_rate <= 0));
            case "Line of sight"
                mask = result.elevation > 0;
            case "None"
                mask = true(size(result.communications));
            end

            figure_name = string(result.protocol_name) ...
                + " simulation from " ...
                + result.transmitter_name ...
                + " to ";

            if numel(result.receiver_name) > 1
                figure_name = figure_name ...
                    + result.receiver_name{1} + " and " + result.receiver_name{2};
            else
                figure_name = figure_name + result.receiver_name;
            end

            fig = figure("Name", figure_name);
            [~] = tiledlayout(3, 3, "TileSpacing", "tight");

            [total_secure_key, ~] = result.total_key_rates();

            % plot performance
            nexttile([1, 2])
            yyaxis left
            hold on
            plot(x_axis(mask), result.secret_key_rate(mask), '-')
            plot(x_axis(mask), result.sifted_key_rate(mask), ':')
            xlabel(x_label)
            ylabel('Rate (bits/s)')
            text(0.5, 0.5, ...
                sprintf('total secret key\ntransfered = %3.2g', total_secure_key), ...
                'Units', 'Normalized', ...
                'VerticalAlignment', 'middle', ...
                'HorizontalAlignment', 'center', ...
                'FontName', get(groot,'defaultAxesFontName'), ...
                'FontSize', get(groot,'defaultAxesFontSize'))

            % plot QBER
            yyaxis right
            plot(x_axis(mask), result.qber(mask) .* 100)
            xlabel(x_label)
            ylabel('QBER (%)')
            legend('Secret Key Rate','Sifted Key Rate','')
            xlim([min(x_axis(mask)), max(x_axis(mask))])

            % plot scenario on map
            nexttile(3, [2, 1])
            geoplot( ...
                result.transmitter_location.Latitude, ...
                result.transmitter_location.Longitude)
            hold('on')
            geoplot( ...
                result.transmitter_location.Latitude(mask), ...
                result.transmitter_location.Longitude(mask), 'g')

            labels = ["Satellite path", strcat(options.mask, " window")];

            r = 1;
            for rx_loc = result.receiver_location
                nodes.PassSimulationResult.PlotLOS( ...
                    rx_loc, ...
                    mean(result.transmitter_location.Altitude), ...
                    result.elevation_limit(1))
                labels{end + 1} = result.receiver_name{r};
                labels{end + 1} = 'Line-of-Sight';
                r = r + 1;
            end

            legend(labels, 'Location', 'southwest');
            geolimits( ...
                mean([result.receiver_location.Latitude]) + [-4, 4], ...
                mean([result.receiver_location.Longitude]) + [-4, 4] );

            % plot loss
            if numel(result.loss) > 1
                ax1 = nexttile(4);
                result.loss(1).plotLosses(x_axis, x_label, "mask", mask);
                xlim([min(x_axis(mask)), max(x_axis(mask))])
                ax2 = nexttile(5);
                result.loss(2).plotLosses(x_axis, x_label, "mask", mask);
                linkaxes([ax1, ax2], 'y')
                xlim([min(x_axis(mask)), max(x_axis(mask))])
            else
                nexttile(4, [1, 2])
                result.loss.plotLosses(x_axis, x_label, "mask", mask);
                xlim([min(x_axis(mask)), max(x_axis(mask))])
            end

            % plot background counts
            if numel(result.noise) > 2
                nexttile(7)
                title('BCR (counts/s)')
                noise_rx1 = result.noise(:, 1);
                n_sources = numel(noise_rx1);
                n_points = numel(noise_rx1(1).values);
                bcr_data = reshape([noise_rx1.values], [n_points, n_sources]);
                area(x_axis(mask), bcr_data(mask, :))
                xlabel(x_label)
                lgd = legend(noise_rx1.label);
                lgd.NumColumns = 1;
                xlim([min(x_axis(mask)), max(x_axis(mask))])

                nexttile(8)
                title('BCR (counts/s)')
                noise_rx2 = result.noise(:, 2);
                n_sources = numel(noise_rx2);
                n_points = numel(noise_rx2(1).values);
                bcr_data = reshape([noise_rx2.values], [n_points, n_sources]);
                area(x_axis(mask), bcr_data(mask, :))
                xlabel(x_label)
                lgd = legend(noise_rx2.label);
                lgd.NumColumns = 1;
                xlim([min(x_axis(mask)), max(x_axis(mask))])
            else
                nexttile(7, [1, 2])
                title('BCR (counts/s)')
                n_sources = numel(result.noise);
                n_points = numel(result.noise(1).values);
                bcr_data = reshape([result.noise.values], [n_points, n_sources]);
                area(x_axis(mask), bcr_data(mask, :))
                xlabel(x_label)
                lgd = legend(result.noise.label);
                lgd.NumColumns = 1;
                xlim([min(x_axis(mask)), max(x_axis(mask))])
            end

            nexttile()
            title('Link performance')
            semilogy(total_loss_db(mask), result.secret_key_rate(mask), 'k-')
            xlabel('Link Loss (dB)')
            ylabel('Secret Key Rate (bps)')
            xlim([ ...
                min(total_loss_db(mask)), ...
                max(total_loss_db(mask)) ]);
            grid on
            ax = gca; %put axis on right
            ax.YAxisLocation = 'right';
            clear ax;

        end

    end

    methods (Static)
        function PlotLOS(ogs_location, sat_altitude, elevation_limit)
            arguments
                ogs_location nodes.Located_Object
                sat_altitude (1, :) {mustBeNumeric}
                elevation_limit {mustBeNumeric}
            end
            % PLOTLOS plot the ground station and its line of sight to a
            % given altitude

            % plot ground station
            geoplot(ogs_location.Latitude, ogs_location.Longitude, 'k*', 'MarkerSize', 20);
            hold on
            % plot the ground station's elevation window
            Headings = 1:359;
            WindowLat = zeros(1, 359);
            WindowLon = zeros(1, 359);
            ArcDistance = utilities.ComputeLOSWindow(sat_altitude, elevation_limit);
            for Heading = Headings
                % NOTE: this is the only call site for MoveAlongSurface
                [CurrentWindowLat, CurrentWindowLon] = utilities.MoveAlongSurface( ...
                    ogs_location.Latitude, ogs_location.Longitude, ArcDistance, Heading);
                WindowLat(Heading) = CurrentWindowLat;
                WindowLon(Heading) = CurrentWindowLon;
            end
            geoplot(WindowLat, WindowLon, 'k--')
            % leg = legend;
            % % leg.String{end + 1} = "Ground Station";
            % leg.String{end + 1} = ogs_name;
            % leg.String{end} = "Ground Station orbit LOS";
        end
    end

end

