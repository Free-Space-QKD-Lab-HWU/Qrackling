classdef PassSimulationResult
    properties (SetAccess = protected)
        transmitter_name
        receiver_name
        protocol_name
        link_direction nodes.LinkDirection
        transmitter_location
        receiver_location
        heading = []
        elevation = []
        range = []
        time = []
        within_elevation_limit = []
        communications = []
        line_of_sight = []
        losses nodes.LossResult
        total_loss_db units.Loss
        sifted_rate = []
        secure_rate = []
        qber = []
        total_sifted_rate = []
        total_secure_rate = []
        noise_sources environment.Noise
    end

    methods
        function result = PassSimulationResult( ...
            transmitter_name,       receiver_name,  heading,           ...
            elevation,              range,          time,              ...
            within_elevation_limit, communications, line_of_sight,     ...
            losses,                 total_loss_db,  sifted_rate,       ...
            secure_rate,            qber,           total_sifted_rate, ...
            total_secure_rate, protocol_name, link_direction, ...
            transmitter_location, receiver_location, noise_sources)

            result.transmitter_name       = transmitter_name;
            result.receiver_name          = receiver_name;
            result.heading                = heading;
            result.elevation              = elevation;
            result.range                  = range;
            result.time                   = time;
            result.within_elevation_limit = within_elevation_limit;
            result.communications         = communications;
            result.line_of_sight          = line_of_sight;
            result.losses                 = losses;
            result.total_loss_db          = total_loss_db;
            result.sifted_rate            = sifted_rate;
            result.secure_rate            = secure_rate;
            result.qber                   = qber;
            result.total_sifted_rate      = total_sifted_rate;
            result.total_secure_rate      = total_secure_rate;
            result.protocol_name          = protocol_name;
            result.link_direction         = link_direction;
            result.transmitter_location   = transmitter_location;
            result.receiver_location      = receiver_location;
            result.noise_sources          = noise_sources;
        end

        function fig = plotResult(result, receiver, transmitter, options)
            arguments
                result nodes.PassSimulationResult
                receiver {mustBeA(receiver, ["nodes.Satellite", "nodes.Ground_Station"])}
                transmitter {mustBeA(transmitter, ["nodes.Satellite", "nodes.Ground_Station"])}
                options.x_axis {mustBeMember(options.x_axis, { ...
                    'Time', 'Elevation'})} = "Time"
                options.mask {mustBeMember(options.mask, { ...
                    'Elevation', 'Communication', 'Line of sight', 'None'})} = "Elevation"
                options.Background_Sources = [] % TODO: replace with environment
            end

            switch options.x_axis
                case 'Time'
                x_axis = result.time;
                x_label = 'Time';
                case 'Elevation'
                x_axis = result.elevation;
                x_label = 'Elevation (deg)';
            end

            switch options.mask
            case "Elevation"
                mask = result.within_elevation_limit;
            case "Communication"
                mask = result.communications;
            case "Line of sight"
                mask = result.line_of_sight;
            case "None"
                mask = true(size(result.communications));
            end

            fig = figure("Name", [result.protocol_name, ' simulation from ', ...
                result.transmitter_name, ' to ', result.receiver_name], ...
                "WindowState", "maximized");

            subplot(3, 3, [3, 6])

            switch result.link_direction
            case nodes.LinkDirection.Downlink
                sat_latitude = result.transmitter_location.Latitude;
                sat_longitude = result.transmitter_location.Longitude;
                altitude = mean(result.transmitter_location.Altitude);
                ogs_latitude = result.receiver_location.Latitude;
                ogs_longitude = result.receiver_location.Longitude;
            case nodes.LinkDirection.Uplink
                sat_latitude = result.receiver_location.Latitude;
                sat_longitude = result.receiver_location.Longitude;
                altitude = mean(result.receiver_location.Altitude);
                ogs_latitude = result.transmitter_location.Latitude;
                ogs_longitude = result.transmitter_location.Longitude;
            case nodes.LinkDirection.Intersatellite
                %FIX: IMPLEMENT
                error("UNIMPLEMENTED")

            case nodes.LinkDirection.Terrestrial
                %FIX: IMPLEMENT
                error("UNIMPLEMENTED")
            end

            title('Satellite Ground Path')
            %plot non-flagged path (no comms or out of elevation range)
            geoplot(sat_latitude, sat_longitude, 'b.', 'LineWidth', 0.5)
            hold('on');
            %then plot flagged path
            geoplot(sat_latitude(mask), sat_longitude(mask), 'g.', 'LineWidth', 1)
            legend('Satellite path', strcat(options.mask, " window"), 'Location', 'southwest')
            %determine satellite altitude for plotting lines of sight
            switch class(receiver)
            case "nodes.Satellite"
                PlotLOS(transmitter, altitude)
            case "nodes.Ground_Station"
                PlotLOS(receiver, altitude)
            end

            % set limits to around the OGS
            geolimits( ogs_latitude + [-30, 15], ogs_longitude + [-30, 15] );

            %% plot the status during comms above one another
            subplot(3, 3, [1, 2])
            % plot performance
            yyaxis left
            hold on
            plot(x_axis(mask), result.secure_rate(mask), '-')
            plot(x_axis(mask), result.sifted_rate(mask), ':')
            xlabel(x_label)
            ylabel('Rate (bits/s)')
            text(0.5, 0.5, sprintf('total secret key\ntransfered = %3.2g', result.total_secure_rate), ...
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

            subplot(3, 3, [7, 8])
            title('BCR (counts/s)')
            n_sources = numel(result.noise_sources);
            n_points = numel(result.noise_sources(1).values);
            bcr_data = reshape([result.noise_sources.values], [n_points, n_sources]);
            area(x_axis(mask), bcr_data(mask, :))
            xlabel(x_label)
            legend(result.noise_sources.label)

            subplot(3, 3, [4, 5])
            result.losses.plotLosses(x_axis, x_label, "mask", mask);

            subplot(3, 3, [9, 9])
            title('Link performance')
            semilogy(result.total_loss_db.values(mask), result.secure_rate(mask), 'k-')
            xlabel('Link Loss (dB)')
            ylabel('Secret Key Rate (bps)')
            xlim([ ...
                min(result.total_loss_db.values(mask)), ...
                max(result.total_loss_db.values(mask)) ]);
            grid on
            ax = gca; %put axis on right
            ax.YAxisLocation = 'right';
            clear ax;

        end

    end
end
