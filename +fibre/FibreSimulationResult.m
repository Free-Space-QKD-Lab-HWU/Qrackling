classdef FibreSimulationResult
    properties
        transmitter_name = []
        receiver_name = []
        transmitter_location (1, :) = [] %nodes.Located_Object.empty(0, 0)
        receiver_location (1, :) = [] %nodes.Located_Object.empty(0, 0)
        protocol_name = ""
        range (:, :) {mustBeNumeric} = []
        time (:, :) = []
        loss nodes.LossResult = nodes.LossResult.empty(0, 0)
        noise environment.Noise = environment.Noise.empty(0, 0)
        sifted_key_rate (1, :) {mustBeNumeric} = []
        secret_key_rate (1, :) {mustBeNumeric} = []
        qber (1, :) {mustBeNumeric} = []
    end

    methods
        function result = FibreSimulationResult(receiver_name, transmitter_name, ...
            transmitter_location, receiver_location, ...
            range, time, ...
            loss, noise, ...
            sifted_key_rate, secret_key_rate, qber, protocol_name)
            arguments
                receiver_name string = ''
                transmitter_name string = ''
                transmitter_location (1, :) = nodes.Located_Object.empty(0, 0)
                receiver_location (1, :) = nodes.Located_Object.empty(0, 0)
                range (:, :) {mustBeNumeric} = []
                time (:, :) = []
                loss nodes.LossResult = nodes.LossResult.empty(0, 0)
                noise environment.Noise = environment.Noise.empty(0, 0)
                sifted_key_rate (1, :) {mustBeNumeric} = []
                secret_key_rate (1, :) {mustBeNumeric} = []
                qber (1, :) {mustBeNumeric} = []
                protocol_name {mustBeText} = ""
            end

            result.receiver_name = receiver_name;
            result.transmitter_name = transmitter_name;
            result.transmitter_location = transmitter_location;
            result.receiver_location = receiver_location;
            result.range = range;
            result.time = time;
            result.loss = loss;
            result.noise = noise;
            result.sifted_key_rate = sifted_key_rate;
            result.secret_key_rate = secret_key_rate;
            result.qber = qber;
            result.protocol_name = protocol_name;

        end

        function [total_secret, total_sifted] = total_key_rates(result)
            arguments
                result fibre.FibreSimulationResult
            end

            %% get data
            communicating = ~(isnan(result.secret_key_rate) | (result.secret_key_rate <= 0));
            time = result.time(communicating);
            %time should be a row vector
            if iscolumn(time)
                time = time';
            end

            time_window_widths = time(2:end) - time(1:end-1);
            if isempty(time_window_widths)
                warning("No communication occurs in this simulation");
                total_secret = 0;
                total_sifted = 0;
                return
            end

            %pad to match width of other arrays
            time_window_widths = [time_window_widths,time_window_widths(end)];

            if isnumeric(time_window_widths)
                total_sifted  = dot(time_window_widths, result.sifted_key_rate(communicating));
                total_secret = dot(time_window_widths, result.secret_key_rate(communicating));
                return
            end

            time_seconds = seconds(time_window_widths);
            total_sifted  = dot(time_seconds, result.sifted_key_rate(communicating));
            total_secret = dot(time_seconds, result.secret_key_rate(communicating));
        end

        function fig = plot(result, options)
            arguments
                result fibre.FibreSimulationResult
                options.x_axis {mustBeMember(options.x_axis, { ...
                    'Time'})} = "Time"
                options.mask {mustBeMember(options.mask, {'Communication', 'None'})} = "Communication"
            end
           

            %% if only single timestep simulated, double into two to allow plotting
            if isscalar(result.time)
                result.time = [result.time,result.time+seconds(1)];
                result.sifted_key_rate =  result.sifted_key_rate*ones(1,2);
                result.secret_key_rate =  result.secret_key_rate*ones(1,2);
                result.qber =  result.qber*ones(1,2);
                
                %expand out loss and noise
                for i = 1:numel(result.noise)
                    result.noise(i).values = result.noise(i).values*ones(1,2);

                end
                for i=1:numel(result.loss.losses)
                result.loss.losses{i} = units.Loss(result.loss.losses{i}*ones(1,2),result.loss.losses{i}.name);
                end
            end

            %% create figure
            figure_name = string(result.protocol_name) ...
                + " simulation from " ...
                + result.transmitter_name ...
                + " to "...
                + result.receiver_name;

            fig = figure("Name", figure_name);
            [~] = tiledlayout(3, 3, "TileSpacing", "tight");

            %% get useful information
            %x label
            switch options.x_axis
                case 'Time'
            x_label = 'Time';
            x_axis = result.time;
            end
            
            %mask
            switch options.mask
            case "Communication"
                mask = ~(isnan(result.secret_key_rate) | (result.secret_key_rate <= 0));
            case "None"
                mask = true(size(result.time));
            end
            
            %total key
            [total_secure_key, ~] = result.total_key_rates();

            %% plot key rates
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

            %% plot QBER
            yyaxis right
            plot(x_axis(mask), result.qber(mask) .* 100)
            xlabel(x_label)
            ylabel('QBER (%)')
            legend('Secret Key Rate','Sifted Key Rate','')

            %% plot map of path
                % plot scenario on map
                nexttile(3, [2, 1])
                labels = {};
                for tx_loc = result.transmitter_location
                    geoplot(tx_loc.Latitude,...
                            tx_loc.Longitude,...
                            'gx')
                    labels = [labels,{['Transmitter: ',tx_loc.Name]}];
                    hold on
                end
                for rx_loc = result.receiver_location
                    geoplot(tx_loc.Latitude,...
                            tx_loc.Longitude,...
                            'rx')
                    labels = [labels,{['Receiver: ',rx_loc.Name]}];
                    hold on
                end

                legend(labels, 'Location', 'southwest');


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

            grid on
            ax = gca; %put axis on right
            ax.YAxisLocation = 'right';
            clear ax;

        end
    end
end

