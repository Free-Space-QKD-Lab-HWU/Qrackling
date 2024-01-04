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

        function fig = plot(result, options)
            arguments
                result beacon.BeaconResult
                options.x_axis {mustBeMember(options.x_axis, { ...
                    'Time', 'Elevation'})} = "Time"
                options.mask {mustBeMember(options.mask, { ...
                    'Elevation', 'Line of sight', 'None'})} = "Elevation"
            end
            
            %% what is on the x axis?
            switch options.x_axis
                case 'Time'
                x_axis = result.time;
                x_label = 'Time';
                case 'Elevation'
                x_axis = result.elevation;
                x_label = 'Elevation (deg)';
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

            fig = figure("Name", ['Beacon simulation from ', ...
                result.transmitter_name, ' to ', result.receiver_name], ...
                "WindowState", "maximized");

            subplot(2, 3, [1,2])
            yyaxis left
            plot(x_axis(mask), result.received_power(mask));
            ylabel("Beacon Power (W)");
            xlabel(x_label);

            yyaxis right
            plot(x_axis(mask), result.snr_db(mask))
            ylabel("SNR (dB)");
            xlabel(x_label);

            subplot(2, 3, [4,5])
            hold on
            result.losses.plotLosses(x_axis, x_label, "mask", mask);
            hold off
            
            polarax = subplot(2,3,3,polaraxes);
            polarplot(polarax,deg2rad(result.heading(mask)), result.elevation(mask))
            set(polarax,'ThetaZeroLocation','top',...
                                'ThetaDir','clockwise',...
                                'ThetaAxisUnits','degrees',...
                                'RDir','reverse',...
                                'RLim',[0,90],...
                                'RTick',[0,30,60,90],...
                                'RTickLabel',{'0^\circ','30^\circ','60^\circ','90^\circ'});

            subplot(2,3,6)
            plot(result.PAA(1,mask), result.PAA(2,mask))
            %centre plot on zero with equal axes
            total_PAA_angle = sqrt(result.PAA(1,mask).^2 + result.PAA(2,mask).^2);
            max_angle = max(total_PAA_angle);
            ylim([-max_angle,max_angle])
            xlim([-max_angle,max_angle])
            axes = gca;
            axes.YAxisLocation = 'right';
            xlabel('Heading PAA (rads)')
            ylabel('Elevation PAA (rads)')
            grid on


        end

    end
end

