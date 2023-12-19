classdef BeaconResult
    properties (SetAccess = protected)
        transmitter_name,
        receiver_name,
        link_direction nodes.LinkDirection
        heading,
        elevation,
        range,
        time,
        within_elevation_limit,
        communications,
        line_of_sight,
        losses nodes.LossResult
        total_loss_db = []
        background_counts = []
        received_power = []
        snr = []
        snr_db = []
        PAA (2,:) = zeros(2,0)
    end

    methods
        function result = BeaconResult(...
            transmitter_name,       receiver_name,       heading,...
            elevation,              range,               time,...
            within_elevation_limit, line_of_sight,...
            losses,                 total_loss_db,       received_power,...
            snr,                    snr_db,              link_direction,...
            background_counts, PAA)
            arguments
                transmitter_name,
                receiver_name,
                heading,
                elevation,
                range,
                time,
                within_elevation_limit,
                line_of_sight,
                losses nodes.LossResult
                total_loss_db 
                received_power
                snr
                snr_db
                link_direction 
                background_counts
                PAA
            end
            result.transmitter_name         = transmitter_name;
            result.receiver_name            = receiver_name;
            result.heading                 = heading;
            result.elevation               = elevation;
            result.range                   = range;
            result.time                    = time;
            result.within_elevation_limit  = within_elevation_limit;
            result.line_of_sight           = line_of_sight;
            result.losses                   = losses;
            result.total_loss_db            = total_loss_db;
            result.received_power           = received_power;
            result.snr                      = snr;
            result.snr_db                   = snr_db;
            result.link_direction           =link_direction;
            result.background_counts        = background_counts;
            result.PAA                      = PAA;
        end

        function fig = plot(result, x_axis, x_label, options)
            arguments
                result beacon.BeaconResult
                x_axis
                x_label
                options.mask {mustBeMember(options.mask, { ...
                    'Elevation', 'Line of sight', 'None'})} = "Elevation"
            end
            
            %% what range is to be plotted?
            switch options.mask
            case "Elevation"
                mask = result.within_elevation_limit;
            case "Line of sight"
                mask = result.line_of_sight;
            case "None"
                mask = true(size(result.communications));
            end
            have_mask = any(contains(fieldnames(options), "mask"));

            fig = figure("Name", ['Beacon simulation from ', ...
                result.transmitter_name, ' to ', result.receiver_name], ...
                "WindowState", "maximized");

            subplot(3, 1, 1)
            if have_mask
                plot(x_axis(mask), result.received_power(mask));
            else
                plot(x_axis, result.received_power);
            end
            ylabel("Beacon Power (W)");
            xlabel(x_label);

            subplot(3, 1, 2)
            hold on
            if have_mask
                result.losses.plotLosses(x_axis, x_label, "mask", mask);
            else
                result.losses.plotLosses(x_axis, x_label);
            end
            hold off

            subplot(3, 1, 3)
            if have_mask
                plot(x_axis(mask), result.snr_db(mask))
            else
                plot(x_axis, result.snr_db)
            end
            ylabel("SNR (dB)");
            xlabel(x_label);

        end

    end
end

