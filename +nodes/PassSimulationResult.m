classdef PassSimulationResult < nodes.QKDSimulationResult
    properties
        direction nodes.LinkDirection = nodes.LinkDirection.empty(0,0)
        heading (:, :) {mustBeNumeric} = []
        elevation (:, :) {mustBeNumeric} = []
        range (:, :) {mustBeNumeric} = []
        elevation_limit = 0
        elevation_mask logical = false([1,0]);
    end

    methods
        function result = PassSimulationResult(transmitter,...
                receiver,...
                protocol,...
                link_direction, ...
                heading, ...
                elevation, ...
                range, ...
                time, ...
                elevation_mask, ...
                loss,...
                noise, ...
                sifted_key_rate,...
                secret_key_rate,...
                qber)
            arguments
                transmitter
                receiver
                protocol
                link_direction nodes.LinkDirection = nodes.LinkDirection.empty(0,0)
                heading (:, :) {mustBeNumeric} = []
                elevation (:, :) {mustBeNumeric} = []
                range (:, :) {mustBeNumeric} = []
                time (:, :) = []
                elevation_mask logical = false([1,0]);
                loss nodes.LossResult = nodes.LossResult.empty(0, 0)
                noise environment.Noise = environment.Noise.empty(0, 0)
                sifted_key_rate (1, :) {mustBeNumeric} = []
                secret_key_rate (1, :) {mustBeNumeric} = []
                qber (1, :) {mustBeNumeric} = []
            end
            result@nodes.QKDSimulationResult(transmitter,...
                receiver,...
                protocol,...
                time,...
                loss,...
                noise,...
                sifted_key_rate,...
                secret_key_rate,...
                qber)

            result.direction = link_direction;
            result.heading = heading;
            result.elevation = elevation;
            result.range = range;
            result.elevation_mask = elevation_mask;
        end

        function fig = plot(result, options)
            arguments
                result nodes.PassSimulationResult
                options.x_axis {mustBeMember(options.x_axis, { ...
                    'Time', 'Elevation'})} = "Time"
                options.mask {mustBeMember(options.mask, { ...
                    'Elevation', 'Communication', 'Line of sight', 'None'})} = "Elevation"
            end

            %% create figure
            figure_name = string(result.protocol.name) ...
                + " simulation from " ...
                + result.transmitter.Name ...
                + " to "...
                + result.receiver.Name;



            fig = figure("Name", figure_name);
            [~] = tiledlayout(3, 3, "TileSpacing", "tight");

            %% get useful information
            %x label
            switch options.x_axis
                case 'Time'
                    x_label = 'Time';
                    x_axis = result.time;
                case 'Elevation'
                    x_label = 'Elevation (deg)';
                    x_axis = result.elevation;
            end

            %mask
            switch options.mask
                case "Elevation"
                    mask = result.elevation_mask;
                case "Communication"
                    mask = ~(isnan(result.secret_key_rate) | (result.secret_key_rate <= 0));
                case "Line of sight"
                    mask = result.elevation > 0;
                case "None"
                    mask = true(size(result.elevation));
            end

            %total key
            [total_secure_key, ~] = result.total_key_rates();

            %% plot key rates
            nexttile([1, 2])
            colororder(colororder())
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

            %% plot QBER
            yyaxis right
            plot(x_axis(mask), result.qber(mask) .* 100)
            xlabel(x_label)
            ylabel('QBER (%)')
            legend('Secret Key Rate','Sifted Key Rate','')
            xlim([min(x_axis(mask)), max(x_axis(mask))])


            %% plot map of path
            switch result.direction
                case nodes.LinkDirection.Downlink
                    % plot scenario on map
                    nexttile(3, [2, 1])
                    geoplot( ...
                        result.transmitter.Latitude, ...
                        result.transmitter.Longitude,'.')
                    hold('on')
                    geoplot( ...
                        result.transmitter.Latitude(mask), ...
                        result.transmitter.Longitude(mask), '.')

                    labels = ["Satellite path", strcat(options.mask, " window")];

                    %for single receiver
                    if isscalar(result.receiver)
                    nodes.PassSimulationResult.PlotLOS( ...
                            result.receiver, ...
                            mean(result.transmitter.Altitude), ...
                            result.receiver.Elevation_Limit)
                        labels{end + 1} = result.receiver.Name;
                        labels{end + 1} = 'Line-of-Sight';
                    else
                    r = 1;
                    for rx_loc = result.receiver
                        nodes.PassSimulationResult.PlotLOS( ...
                            rx_loc, ...
                            mean(result.transmitter.Altitude), ...
                            result.receiver.Elevation_Limit)
                        labels{end + 1} = result.receiver.Name;
                        labels{end + 1} = 'Line-of-Sight';
                        r = r + 1;
                    end
                    end
                    legend(labels, 'Location', 'north');
                    geolimits( ...
                        mean([result.receiver.Latitude]) + [-15, 15], ...
                        mean([result.receiver.Longitude]) + [-15, 15] );
                    axes = gca();
                    axes.FontName = get(groot(),'defaultAxesFontName');
                    axes.FontSize = get(groot(),'defaultAxesFontSize');
                case nodes.LinkDirection.Uplink
                    yyaxis right
                    plot(x_axis(mask), result.qber(mask) .* 100)
                    xlabel(x_label)
                    ylabel('QBER (%)')
                    legend('Secret Key Rate','Sifted Key Rate','')
                    xlim([min(x_axis(mask)), max(x_axis(mask))])

                    % plot scenario on map
                    nexttile(3, [2, 1])
                    geoplot( ...
                        result.receiver.Latitude, ...
                        result.receiver.Longitude,'.')
                    hold('on')
                    geoplot( ...
                        result.receiver.Latitude(mask), ...
                        result.receiver.Longitude(mask), '.')

                    labels = ["Satellite path", strcat(options.mask, " window")];

                    %for single transmitter
                    if isscalar(result.transmitter)
                        nodes.PassSimulationResult.PlotLOS( ...
                            result.transmitter, ...
                            mean(result.receiver.Altitude), ...
                            result.receiver.Elevation_Limit)
                        labels{end + 1} = result.transmitter.Name;
                        labels{end + 1} = 'Line-of-Sight';
                    
                   %for multiple transmitters
                    else
                        t = 1;
                        for tx_loc = result.transmitter
                            nodes.PassSimulationResult.PlotLOS( ...
                                tx_loc, ...
                                mean(result.receiver.Altitude), ...
                                result.receiver.Elevation_Limit)
                            labels{end + 1} = result.transmitter.Name;
                            labels{end + 1} = 'Line-of-Sight';
                            t = t + 1;
                        end
                    end

                    legend(labels, 'Location', 'north');
                    geolimits( ...
                        mean([result.transmitter.Latitude]) + [-15, 15], ...
                        mean([result.transmitter.Longitude]) + [-15, 15] );
                    axes = gca();
                    axes.FontName = get(groot(),'defaultAxesFontName');
                    axes.FontSize = get(groot(),'defaultAxesFontSize');
            end


            %% plot loss
            nexttile(4, [1, 2])
            result.loss.plotLosses(x_axis, x_label, "mask", mask);
            xlim([min(x_axis(mask)), max(x_axis(mask))])


            %% plot background counts
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

            %% plot link loss tolerance
            nexttile()
            title('Link performance')
            total_loss_db = result.loss.TotalLoss.dB;
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

        function result = empty()
            result = nodes.PassSimulationResult(...
                fibre.Fibre_Node.empty(),...
                fibre.Fibre_Node.empty(),...
                protocol.bb84());
        end
    end
end

