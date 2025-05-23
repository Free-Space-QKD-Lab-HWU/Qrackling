function results = QkdPassSimulation(receivers, transmitters, qkd_protocol)
%%QKDPASSSIMULATION this function architects the simulation of a QKD pass.
%%It takes at least one receiver, a transmitter, a protocol and an
%%(optional) environment, then finds and performs the required links
    arguments
        receivers { ...
            nodes.mustBeReceiverOrTransmitter(receivers), ...
            nodes.mustHaveDetector(receivers) }
        transmitters { ...
            nodes.mustBeReceiverOrTransmitter(transmitters), ...
            nodes.mustHaveSource(transmitters) }
        qkd_protocol protocol.proto
    end    

    %% Check that we have the correct number of transmitters and receivers for this protocol
    qkd_protocol.mustHaveCorrectTransmittersAndReceivers(transmitters,receivers)

    %% what direction are links between 

    %% Establish the loss and noise between each transmitter and receiver pair
    %prepare memory
    loss_results = repmat(nodes.LossResult(),[qkd_protocol.num_transmitters,qkd_protocol.num_receivers]);
    total_loss = zeros(qkd_protocol.num_transmitters,qkd_protocol.num_receivers,0);
    noise_results = repmat(environment.Noise('',[]),[qkd_protocol.num_transmitters,qkd_protocol.num_receivers,0]);
    total_noise = zeros(qkd_protocol.num_transmitters,qkd_protocol.num_receivers,0);
    headings = zeros(qkd_protocol.num_transmitters,qkd_protocol.num_receivers,0);
    elevations = zeros(qkd_protocol.num_transmitters,qkd_protocol.num_receivers,0);
    ranges = zeros(qkd_protocol.num_transmitters,qkd_protocol.num_receivers,0);
    times = NaT(qkd_protocol.num_transmitters,qkd_protocol.num_receivers,0,'TimeZone','UTC');
    elevation_flags = false(qkd_protocol.num_transmitters,qkd_protocol.num_receivers,0);
    link_directions = repmat(nodes.LinkDirection.Downlink,[qkd_protocol.num_transmitters,qkd_protocol.num_receivers]);
    elevation_limits = zeros(1,qkd_protocol.num_receivers);

    %iterating over each transmitter-receiver pair
    for receiver_index = 1:qkd_protocol.num_receivers
        for transmitter_index = 1:qkd_protocol.num_transmitters
            %what direction is the link?
            if utilities.isSubclassOf(transmitters(transmitter_index),'nodes.Satellite')&&...
                    utilities.isSubclassOf(receivers(receiver_index),'nodes.Ground_Station')
                link_directions(transmitter_index,receiver_index)=nodes.LinkDirection.Downlink;
            elseif utilities.isSubclassOf(receivers(receiver_index),'nodes.Satellite')&&...
                    utilities.isSubclassOf(transmitters(transmitter_index),'nodes.Ground_Station')
                link_directions(transmitter_index,receiver_index)=nodes.LinkDirection.Uplink;
            else
                error('Unimplemented')
            end
            
            %determine when the link has line of sight
            switch link_directions(transmitter_index,receiver_index)
                case nodes.LinkDirection.Downlink
                    [current_headings,current_elevations,current_ranges] = RelativeHeadingAndElevation(transmitters(transmitter_index),receivers(receiver_index));
                    current_time = transmitters(transmitter_index).Times;
                case nodes.LinkDirection.Uplink
                    [current_headings,current_elevations,current_ranges] = RelativeHeadingAndElevation(receivers(receiver_index),transmitters(transmitter_index));
                    current_time = transmitters(transmitter_index).Times;
            end
            current_elevation_flags = current_elevations > receivers(receiver_index).Elevation_Limit;
            num_time_steps = numel(current_time);

            

            [loss,noise]=loss_and_noise_for_channel(transmitters(transmitter_index),...
                                                    receivers(receiver_index),...
                                                    qkd_protocol);
            %store loss and noise in cells with index transmitter x
            %receiver
            loss_results(transmitter_index,receiver_index) = loss;
            total_loss(transmitter_index,receiver_index,1:num_time_steps) = loss.TotalLoss;
            noise_results(transmitter_index,receiver_index,1:numel(noise)) = noise;
            total_noise(transmitter_index,receiver_index,1:num_time_steps) = noise.Total;
            headings(transmitter_index,receiver_index,1:num_time_steps) = current_headings;
            elevations(transmitter_index,receiver_index,1:num_time_steps) = current_elevations;
            ranges(transmitter_index,receiver_index,1:num_time_steps) = current_ranges;
            times(transmitter_index,receiver_index,1:num_time_steps) = current_time;
            elevation_flags(transmitter_index,receiver_index,1:num_time_steps) = current_elevation_flags;
        end

        %record elevation limit of this receiver
        elevation_limits(receiver_index)=receivers(receiver_index).Elevation_Limit;
    end

    %% specifically calculate where all elevation limits are met
    all_elevation_flags = squeeze(all(elevation_flags,[1,2]));
    total_loss_all_elevation_flags = total_loss(:,:,all_elevation_flags);
    total_noise_all_elevation_flags = total_noise(:,:,all_elevation_flags);

    %% Evaluate QKD link
    %prepare memory which is zero outside elevation limits
    secret_key_rate = zeros(1,num_time_steps);
    sifted_key_rate = zeros(1,num_time_steps);
    qber = 0.5*ones(1,num_time_steps);

    %calculate
    [secret_key_rate_elevation_flag, sifted_key_rate_elevation_flag, qber_elevation_flag] = qkd_protocol.Calculate(transmitters, ...
                                                                      receivers, ...
                                                                      total_loss_all_elevation_flags, ...
                                                                      total_noise_all_elevation_flags);
    %transfer to appropriate point in time-domain memory
    secret_key_rate(all_elevation_flags) = secret_key_rate_elevation_flag;
    sifted_key_rate(all_elevation_flags) = sifted_key_rate_elevation_flag;
    qber(all_elevation_flags) = qber_elevation_flag;

     %% store results
     results = repmat(nodes.PassSimulationResult(),[qkd_protocol.num_transmitters,qkd_protocol.num_receivers]);
        for receiver_index = 1:qkd_protocol.num_receivers
            for transmitter_index = 1:qkd_protocol.num_transmitters
                results(transmitter_index,receiver_index) = nodes.PassSimulationResult( ...
                    receivers(receiver_index).Name, transmitters(transmitter_index).Name, ...
                    nodes.Located_Object().SetPosition("Latitude",  transmitters(transmitter_index).Latitude,"Longitude", transmitters(transmitter_index).Longitude,"Altitude",  transmitters(transmitter_index).Altitude), ...
                    nodes.Located_Object().SetPosition( "Latitude",  receivers(receiver_index).Latitude, "Longitude", receivers(receiver_index).Longitude, "Altitude",  receivers(receiver_index).Altitude), ...
                    link_directions(transmitter_index,receiver_index),...
                    headings(transmitter_index,receiver_index,:),...
                    elevations(transmitter_index,receiver_index,:),....
                    ranges(transmitter_index,receiver_index,:),...
                    times(transmitter_index,receiver_index,:), ...
                    elevation_limits(receiver_index),...
                    all_elevation_flags, ...
                    loss_results(transmitter_index,receiver_index),...
                    noise_results(transmitter_index,receiver_index,:), ...
                    sifted_key_rate, secret_key_rate, qber, qkd_protocol.name);
            end
        end
end


function needs_env = map_receivers_and_environments(receiver, options)
    arguments
        receiver { ...
            nodes.mustBeReceiverOrTransmitter(receiver), ...
            nodes.mustHaveDetector(receiver) }
        options.Environment environment.Environment
    end

    n_rx = numel(receiver);
    n_env = 0;
    have_environment = ismember(fieldnames(options), "Environment");
    if have_environment
        n_env = numel(options.Environment);
    end

    needs_env = arrayfun(@(maybe_has_env) isa(maybe_has_env, 'nodes.Ground_Station'), receiver);

    if n_rx >= n_env && n_env > 1 && have_environment
        % convert logical values to indices
        needs_env = needs_env .* cumsum(needs_env);

        % so we can catch them later set "0" values to -1
        needs_env(needs_env == 0) = -1;

        assert(max(needs_env) == numel(options.Environment), ...
            [ ...
            'Number of receivers and environments do not match, either supply ', ...
            'a single environment for all receivers or an environment per receiver' ...
            ])
    end
end


function [min_val, max_val] = extrema(array)
    min_val = min(array);
    max_val = max(array);
end


function loc_time = location_time(tx_idx, rx_idx, direction, heading, elevation, range, elev_limit, elev_mask, time)
    arguments
        tx_idx {mustBeNumeric}
        rx_idx {mustBeNumeric}
        direction nodes.LinkDirection
        heading (1, :) {mustBeNumeric}
        elevation (1, :) {mustBeNumeric}
        range (1, :) {mustBeNumeric}
        elev_limit {mustBeScalarOrEmpty, mustBeNumeric}
        elev_mask (1, :) {mustBeNumericOrLogical}
        time (1, :) {mustBeA(time, "datetime")}
    end

    loc_time = struct( ...
        "tx_idx", tx_idx, ...
        "rx_idx", rx_idx, ...
        "direction", direction, ...
        "heading", heading, ...
        "elevation", elevation, ...
        "range", range, ...
        "elevation_limit", elev_limit, ...
        "elevation_mask", elev_mask, ...
        "time", time);
end


function tt = timetable_for_elevation_window(rel_loc, elev_limit)
    elev_mask = rel_loc.elevation > elev_limit;
    if sum(elev_mask) < 1
        tt = [];
        return
    end
    [t_min, t_max] = extrema(rel_loc.time(elev_mask));
    tt = timetable([t_min; t_max]);
end


function [single_link_idx, double_link_idx] = find_links(receivers, transmitters)

    arguments
        receivers { ...
            nodes.mustBeReceiverOrTransmitter(receivers), ...
            nodes.mustHaveDetector(receivers) }
        transmitters { ...
            nodes.mustBeReceiverOrTransmitter(transmitters), ...
            nodes.mustHaveSource(transmitters) }
    end

    single_link_idx = {};
    double_link_idx = {};

    n_receivers = numel(receivers);

    loc_time = struct( ...
        "tx_idx", 0, ...
        "rx_idx", 0, ...
        "direction", nodes.LinkDirection.Downlink, ...
        "heading", [], ...
        "elevation", [], ...
        "range", [], ...
        "elevation_limit", 0, ...
        "elevation_mask", [], ...
        "time", []);

    % relative_locations = createArray(1, n_receivers, Like=loc_time(0, 0, [], [], [], [], []));
    % relative_locations = {};

    for T = 1:numel(transmitters)
        tx = transmitters(T);
        i = 1;
        valid_links = zeros(1, n_receivers); % for current transmitter
        elevation_limits = zeros(1, n_receivers);

        % relative_locations = createArray(1, n_receivers, ...
        %     Like=loc_time(0, 0, 0, [], [], [], 0, [], []));

        relative_locations = createArray(1, n_receivers, Like=loc_time);
        for R = 1:numel(receivers)
            rx = receivers(R);
            direction = nodes.LinkDirection.DetermineLinkDirection(rx, tx);

            switch direction
                case nodes.LinkDirection.Downlink
                    [h, e, r] = tx.RelativeHeadingAndElevation(rx);
                    limit = rx.Elevation_Limit;
                    elevation_limits(i) = limit;
                    elevation_limit_mask = e > elevation_limits(i);
                    rel_loc = location_time(T, R, direction, h, e, r, limit, elevation_limit_mask, tx.Times);

                case nodes.LinkDirection.Uplink
                    [h, e, r] = rx.RelativeHeadingAndElevation(tx);
                    limit = tx.Elevation_Limit;
                    elevation_limits(i) = limit;
                    elevation_limit_mask = e > elevation_limits(i);
                    rel_loc = location_time(T, R, direction, h, e, r, limit, elevation_limit_mask, rx.Times);
            end

            % elevation_limit_mask = relative_locations(i).elevation > elevation_limits(i);
            % if sum(elevation_limit_mask) > 0
            if sum(rel_loc.elevation_mask) > 0
                valid_links(i) = 1;
                single_link_count = numel(single_link_idx) + 1;
                single_link_idx{single_link_count} = rel_loc;
                %relative_locations_count = numel(relative_locations) + 1;
                % relative_locations{relative_locations_count} = rel_loc;
                relative_locations(R) = rel_loc;
            end

            i = i + 1;
        end

        relative_locations = relative_locations(arrayfun(@(rl) ~isempty(rl.elevation), relative_locations));

        %if sum(valid_links) < 2
        if numel(relative_locations) < 2
            % skip to next transmitter if there is one
            continue
        end

        %n = sum(valid_links);
        n = numel(relative_locations);
        for rx_pairs = nchoosek(linspace(1, n, n), 2)'

            rel_loc_i = relative_locations(rx_pairs(1));
            e_lim = elevation_limits(rx_pairs(1));
            tt_i = timetable_for_elevation_window(rel_loc_i, e_lim);

            rel_loc_j = relative_locations(rx_pairs(2));
            e_lim = elevation_limits(rx_pairs(2));
            tt_j = timetable_for_elevation_window(rel_loc_j, e_lim);

            if any([sum(size(tt_i)) < 1, sum(size(tt_j)) < 1])
                % one of the timetables is empty so it mustn't have seen the satellite
                continue
            end

            if ~overlapsrange(tt_i, tt_j)
                %{
                    skip to next pair
                    eventhough both rx, tx pairs could see each other they
                    couldn't see each other at the same time
                %}
                continue
            end

            dl_idx = numel(double_link_idx) + 1;
            % double_link_idx{dl_idx} = {T, rx_pairs(1), rx_pairs(2)}; % {transmitter, receiver_i, receivers_j}
            double_link_idx{dl_idx} = {[rel_loc_i, rel_loc_j]};
        end

    end
end


function [loss_results, noise] = loss_and_noise_for_channel(transmitter, receiver, qkd_protocol)
    arguments
        transmitter (1,1) { ...
            nodes.mustBeReceiverOrTransmitter(transmitter), ...
            nodes.mustHaveSource(transmitter) }
        receiver (1,1) { ...
            nodes.mustBeReceiverOrTransmitter(receiver), ...
            nodes.mustHaveDetector(receiver) }
        qkd_protocol protocol.proto
    end


    %% get background light data from ground station's environment
    switch class(transmitter)
    case "nodes.Satellite"
        [headings, elevations, ~] = transmitter.RelativeHeadingAndElevation(receiver);
        background_radiance = receiver.Environment.Interp( ...
            "spectral_radiance", headings, elevations, transmitter.Source.Wavelength);
    case "nodes.Ground_Station"
        [headings, elevations, ~] = receiver.RelativeHeadingAndElevation(transmitter);
        background_radiance = transmitter.Environment.Interp( ...
            "spectral_radiance", headings, elevations, transmitter.Source.Wavelength);
    end
        t = receiver.Detector.Spectral_Filter.transmission;
        w = receiver.Detector.Spectral_Filter.wavelengths;
        w_range = w(t ~= 0);
        filter_width = max(w_range) - min(w_range);

        background_counts_per_second = environment.countRateFromRadiance( ...
            background_radiance, ...
            receiver.Telescope.FOV, ...
            receiver.Telescope.Diameter, ...
            filter_width, ...
            1, ...
            receiver.Detector.Wavelength);


    %noise due to detector dark counts
    dark_counts = ones(size(headings)) ...
        .* receiver.Detector.Dark_Count_Rate ...
        .* qkd_protocol.num_detectors;

    %record as noise objects
    noise = [ ...
        environment.Noise("Detector Dark Counts", dark_counts), ...
        environment.Noise("Background Counts", background_counts_per_second), ...
    ];

    %% compute losses
    [loss_results, ~] = nodes.linkLoss('qkd',...
                                receiver,...
                                transmitter,...
                                'apt',...
                                'optical',...
                                'geometric',...
                                'turbulence',...
                                'atmospheric');
end

