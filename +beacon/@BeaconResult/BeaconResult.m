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
        scenario satelliteScenario
    end

    methods
        function result = BeaconResult(...
            transmitter_name,       receiver_name,       heading,...
            elevation,              range,               time,...
            within_elevation_limit, line_of_sight,...
            losses,                 total_loss_db,       received_power,...
            snr,                    snr_db,              link_direction,...
            background_counts, PAA, scenario)
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
                scenario
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
            result.scenario                = scenario;
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

            %% plot received power and SNR
            subplot(2, 3, [1,2])
            yyaxis left
            plot(x_axis(mask), result.received_power(mask));
            ylabel("Beacon Power (W)");
            xlabel(x_label);

            yyaxis right
            plot(x_axis(mask), result.snr_db(mask))
            ylabel("SNR (dB)");
            xlabel(x_label);

            %% plot link losses
            subplot(2, 3, [4,5])
            hold on
            result.losses.plotLosses(x_axis, x_label, "mask", mask);
            hold off

            %% plot link heading and elevation
            polarax = subplot(2,3,3,polaraxes);
            polarplot(polarax,deg2rad(result.heading(mask)), result.elevation(mask))
            set(polarax,'ThetaZeroLocation','top',...
                                'ThetaDir','clockwise',...
                                'ThetaAxisUnits','degrees',...
                                'RDir','reverse',...
                                'RLim',[0,90],...
                                'RTick',[0,30,60,90],...
                                'RTickLabel',{'0^\circ','30^\circ','60^\circ','90^\circ'});

            %% plot point ahead angles
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

        function ExportPAA(result,options)
            % write point ahead angle as a function of time to a CSV file
            % 
            % entries are (comma and space ', ' separated):
            % time (UTC in yyyy-MM-dd HH:mm:ss.SSSS format)
            % heading PAA, in rads, fixed-point to 16 dp
            % elevation PAA, in rads, fixed-point to 16 dp

            % if the intended file already exists, ExportPAA appends the
            % new information to the bottom
            arguments
                result beacon.BeaconResult
                options.Name {mustBeText} = 'PAA.csv'
            end

            %format file name
            if isstring(options.Name)
                Name = char(options.Name);
            else
                Name = options.Name;
            end
            
            if numel(Name)<4 || ~all(isequal(Name(end-3:end),'.csv'))
                Name = [Name,'.csv'];
            end

           
            %convert data to strings
            timestring = string(result.time','yyyy-MM-dd HH:mm:ss.SSS');
                %here we need to check whether times have been discretised
                %so that many points have same time to second precision
                milliseconds_from_start = round(seconds(result.time-result.time(1)),4);
                assert(all(milliseconds_from_start(2:end)-milliseconds_from_start(1:end-1)>0),...
                        'Time stamps must be uniformly increasing when recorded to second precision');

            xstring = compose("%.16f",result.PAA(1,:)');
            ystring = compose("%.16f",result.PAA(2,:)');

            %write strings to file
            writelines(strcat(timestring,', ',xstring,', ',ystring),Name,'WriteMode','append')
        end
    end
end

