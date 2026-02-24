% result = BeaconResult(transmitter,...
%                       receiver,...
%                       link_direction,...
%                       elevation,...
%                       range,...
%                       time,...
%                       above_elevation_limit,...
%                       has_line_of_sight,...
%                       losses,...
%                       total_loss_db,...
%                       background_counts,...
%                       received_power,...
%                       snr,...
%                       point_ahead_angle)
%
% A class which contains the results of a beacon simulation.

classdef BeaconResult
    properties (SetAccess = protected)
        transmitter (1,1)
        receiver (1,1)
        link_direction (1,1) nodes.LinkDirection = nodes.LinkDirection.Downlink
        heading (1,:) {mustBeNumeric}
        elevation (1,:) {mustBeNumeric}
        range (1,:) {mustBeNonnegative}
        time (1,:) datetime
        above_elevation_limit (1,:) logical
        has_line_of_sight (1,:) logical
        losses (1,1) nodes.LossResult
        total_loss_db (1,:) {mustBeNonnegative}
        background_counts (1,:) {mustBeNonnegative}
        received_power (1,:) {mustBeNonnegative}
        snr (1,:) {mustBeNumeric}
        point_ahead_angle (2,:) {mustBeNumeric} = zeros(2,0)
    end

    properties (Dependent)
        snr_db (1,:) {mustBeNumeric} %snr in dB
    end

    methods
        function result = BeaconResult(...
            transmitter,...
            receiver,...
            link_direction,...
            heading,...
            elevation,...
            range,...
            time,...
            above_elevation_limit,...
            has_line_of_sight,...
            losses,...
            total_loss_db,...
            background_counts,...
            received_power,...
            snr,...
            point_ahead_angle)
            % BeaconResult
            % 
            % Create a BeaconResult object from results of simulation.
            %
            % Syntax:
            % result = BeaconResult(transmitter,...
            %                       receiver,...
            %                       link_direction,...
            %                       elevation,...
            %                       range,...
            %                       time,...
            %                       above_elevation_limit,...
            %                       has_line_of_sight,...
            %                       losses,...
            %                       total_loss_db,...
            %                       background_counts,...
            %                       received_power,...
            %                       snr,...
            %                       point_ahead_angle)
            %
            % Inputs:
            % transmitter - scalar
            % receiver - scalar
            % link_direction - scalar direction object of beacon link (may be
            % different to SatQKD link)
            % elevation - row vector, elevation of link from receiver in degrees
            % range - row vector, distance of link in m
            % time - row vector, datetime time of simulation
            % above_elevation_limit - row vector logical, true when satellite is
            % above elevation limit of receiver
            % has_line_of_sight - row vector logical, true when line
            % between transmitter and receiver is clear
            % losses - scalar lossResult object describing link
            % total_loss_db - row vector, total loss of link in dB
            % background_counts - row vector, background photon arrival
            % rate at receiver in counts/s
            % received_power - row vector, beacon power at receiver in W
            % snr - row vector, signal to noise ration of link
            % point_ahead_angle (2,:) 2 row vectors, point ahead angle of 
            % beacon in radians of heading and elevation
            %
            % Outputs:
            % result (1,1) BeaconResult

            arguments
                transmitter (1,1) {utilities.mustBeSubclassOf(transmitter,'nodes.FreeSpaceOpticalNode')}
                receiver (1,1) {utilities.mustBeSubclassOf(receiver,'nodes.FreeSpaceOpticalNode')}
                link_direction (1,1) nodes.LinkDirection
                heading (1,:) {mustBeNumeric}
                elevation (1,:) {mustBeNumeric}
                range (1,:) {mustBeNonnegative}
                time (1,:) datetime
                above_elevation_limit (1,:) logical
                has_line_of_sight (1,:) logical
                losses (1,1) nodes.LossResult
                total_loss_db (1,:) {mustBeNonnegative}
                background_counts (1,:) {mustBeNonnegative}
                received_power (1,:) {mustBeNonnegative}
                snr (1,:) {mustBeNumeric}
                point_ahead_angle (2,:) {mustBeNumeric}
            end

            % Store all input variables.
            result.transmitter              = transmitter;
            result.receiver                 = receiver;
            result.link_direction           = link_direction;
            result.heading                  = heading;
            result.elevation                = elevation;
            result.range                    = range;
            result.time                     = time;
            result.above_elevation_limit    = above_elevation_limit;
            result.has_line_of_sight        = has_line_of_sight;
            result.losses                   = losses;
            result.total_loss_db            = total_loss_db;
            result.received_power           = received_power;
            result.snr                      = snr;
            result.link_direction           =link_direction;
            result.background_counts        = background_counts;
            result.point_ahead_angle        = point_ahead_angle;
        end

        function fig = plot(result, options)
                % plot
                % 
                % Plot the contained beacon simulation result.
                %
                % Syntax:
                % fig = plot(result, options)
                %
                % Inputs:
                % result - scalar BeaconResult
                % options.x_axis - 'Time' or 'Elevation', variable to be
                % plotted on x axis
                % options.mask - 'Elevation', 'Line of sight', 'None',
                % range of x axis values to be plotted for
                %
                % Outputs:
                % fig - scalar figure
            arguments
                result beacon.BeaconResult
                options.x_axis {mustBeMember(options.x_axis, { ...
                    'Time', 'Elevation'})} = "Time"
                options.mask {mustBeMember(options.mask, { ...
                    'Elevation', 'Line of sight', 'None'})} = "Elevation"
            end

            %% What is on the x axis?
            switch options.x_axis
                case 'Time'
                x_axis = result.time;
                x_label = 'Time';
                case 'Elevation'
                x_axis = result.elevation;
                x_label = 'Elevation (deg)';
            end


            %% What range is to be plotted?
            switch options.mask
            case "Elevation"
                mask = result.above_elevation_limit;
            case "Line of sight"
                mask = result.has_line_of_sight;
            case "None"
                mask = true(size(result.elevation));
            end

            fig = figure("Name", "Beacon simulation from " + ...
                result.transmitter.name + " to " + result.receiver.name, ...
                "WindowState", "maximized");


            %% Plot received power and SNR.
            subplot(2, 3, [1,2])
            colororder(colororder())
            yyaxis left
            plot(x_axis(mask), result.received_power(mask));
            ylabel("Beacon Power (W)");
            xlabel(x_label);

            yyaxis right
            plot(x_axis(mask), result.snr_db(mask))
            ylabel("SNR (dB)");
            xlabel(x_label);


            %% Plot link losses.
            subplot(2, 3, [4,5])
            hold on
            result.losses.plotLosses(x_axis, x_label, "mask", mask);
            hold off


            %% Plot link heading and elevation.
            polarax = subplot(2,3,3,polaraxes);
            polarplot(polarax,deg2rad(result.heading(mask)), result.elevation(mask))
            set(polarax,'ThetaZeroLocation','top',...
                                'ThetaDir','clockwise',...
                                'ThetaAxisUnits','degrees',...
                                'RDir','reverse',...
                                'RLim',[0,90],...
                                'RTick',[0,30,60,90],...
                                'RTickLabel',{'0^\circ','30^\circ','60^\circ','90^\circ'});


            %% Plot point ahead angles.
            subplot(2,3,6)
            plot(result.point_ahead_angle(1,mask), result.point_ahead_angle(2,mask))
            %centre plot on zero with equal axes
            total_PAA_angle = sqrt(result.point_ahead_angle(1,mask).^2 + result.point_ahead_angle(2,mask).^2);
            max_angle = max(total_PAA_angle);
            ylim([-max_angle,max_angle])
            xlim([-max_angle,max_angle])
            axes = gca;
            axes.YAxisLocation = 'right';
            xlabel('Heading PAA (rads)')
            ylabel('Elevation PAA (rads)')
            grid on


        end

        function exportPAA(result,options)
            % exportPAA
            % 
            % Write point ahead angle as a function of time to a CSV file.
            %
            % Syntax:
            % exportPAA(result,options)
            %
            % Inputs:
            % result - scalar BeaconResult
            % options.Name - Name of .csv file to be saved to
            % 
            % Entries are (comma and space ', ' separated):
            % Time (UTC in yyyy-MM-dd HH:mm:ss.SSSS format).
            % Heading point ahead angle, in rads, fixed-point to 16 dp.
            % Elevation point ahead angle, in rads, fixed-point to 16 dp.
            %
            % If the intended file already exists, exportPAA appends the
            % new information to the bottom.
            arguments
                result beacon.BeaconResult
                options.Name {mustBeText} = 'PAA.csv'
            end

            %% Format file name.
            if isstring(options.Name)
                Name = char(options.Name);
            else
                Name = options.Name;
            end
            
            if numel(Name)<4 || ~all(isequal(Name(end-3:end),'.csv'))
                Name = [Name,'.csv'];
            end

           
            %% Convert data to strings.
            timestring = string(result.time','yyyy-MM-dd HH:mm:ss.SSS');
                % Here we need to check whether times have been discretised
                % so that many points have same time to second precision.
                milliseconds_from_start = round(seconds(result.time-result.time(1)),4);
                assert(all(milliseconds_from_start(2:end)-milliseconds_from_start(1:end-1)>0),...
                        'Time stamps must be uniformly increasing when recorded to second precision');

            xstring = compose("%.16f",result.point_ahead_angle(1,:)');
            ystring = compose("%.16f",result.point_ahead_angle(2,:)');


            %% Write strings to file.
            writelines(strcat(timestring,', ',xstring,', ',ystring),Name,'WriteMode','append')
        end
    
        function snr_dB = get.snr_db(result)
                % get.snr_dB
                % 
                % return signal-to-noise-ratio of beacon link in dB
                %
                % Syntax:
                % snr_dB = get.snr_dB(result)
                %
                % Inputs:
                % result - (1,1) BeaconResult
                % 
                % Outputs:
                % snr_dB - row vector of SNR values in dB
            snr_dB = 10*log10(result.snr);
        end
    end
end

