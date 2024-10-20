function results = QkdPassSimulation(receiver, transmitter, qkd_protocol, options)
    arguments
        receiver { ...
            nodes.mustBeReceiverOrTransmitter(receiver), ...
            nodes.mustHaveDetector(receiver) }
        transmitter { ...
            nodes.mustBeReceiverOrTransmitter(transmitter), ...
            nodes.mustHaveSource(transmitter) }
        qkd_protocol protocol.proto
        options.Environment environment.Environment
    end

    protocol_name = class(qkd_protocol);

    if isscalar(receiver)
        receiver = {receiver};
    end

    if isscalar(transmitter)
        transmitter = {transmitter};
    end

    have_environment = any(ismember(fieldnames(options), "Environment"));

    % check length of needs_env to pick route
    needs_env = have_environment;
    if have_environment
        needs_env = map_receivers_and_environments(receiver, "Environment", options.Environment);
    end

    supports_double_link = string(qkd_protocol.method) == "entanglement";

    [single_links, double_links] = find_links(receiver, transmitter);

    args = {{}, {}, qkd_protocol};
    if have_environment
        args{end + 1} = "Environment";
        args{end + 1} = options.Environment(1);
    end

    loss_dict = dictionary;
    dark_counts_dict = dictionary;
    background_counts_dict = dictionary;

    result_dim = [1, numel(single_links) + numel(double_links)];
    results = createArray(result_dim, "nodes.PassSimulationResult");

    r = 1;
    for s = [single_links{:}]
        args{1} = receiver{s.rx_idx};
        args{2} = transmitter{s.tx_idx};
        if have_environment
            args{end} = options.Environment(s.rx_idx);
        end
        [loss, noise] = loss_and_noise_for_channel(args{:});
        key = [num2str(s.rx_idx), ' ', num2str(s.tx_idx)];
        loss_dict(key) = loss;
        dark_counts_dict(key) = noise(1);
        background_counts_dict(key) = noise(2);

        elev_mask = s.elevation_mask;
        dim = size(elev_mask);
        secret_key_rate = zeros(size(dim));
        sifted_key_rate = zeros(size(dim));
        qber = zeros(size(dim));

        loss_array = loss.TotalLoss("probability").values(elev_mask);
        noise_array = noise(2).values(elev_mask);

        [skr, kr, q] = qkd_protocol.Calculate( ...
            transmitter{s.tx_idx}, ...
            receiver{s.rx_idx}, ...
            loss_array, "probability", ...
            noise_array);
        
        secret_key_rate(elev_mask) = skr;
        sifted_key_rate(elev_mask) = kr;
        qber(elev_mask) = q;

        rx_loc = nodes.Located_Object().SetPosition( ...
            "Latitude",  receiver{s.rx_idx}.Latitude, ...
            "Longitude", receiver{s.rx_idx}.Longitude, ...
            "Altitude",  receiver{s.rx_idx}.Altitude);
        tx_loc = nodes.Located_Object().SetPosition( ...
            "Latitude",  transmitter{s.tx_idx}.Latitude, ...
            "Longitude", transmitter{s.tx_idx}.Longitude, ...
            "Altitude",  transmitter{s.tx_idx}.Altitude);

        results(r) = nodes.PassSimulationResult( ...
            receiver{s.rx_idx}, transmitter{s.tx_idx}, ...
            tx_loc, rx_loc, ...
            s.direction, s.heading, s.elevation, s.range, s.time, ...
            s.elevation_limit, s.elevation_mask, ...
            loss, noise, ...
            sifted_key_rate, secret_key_rate, qber, protocol_name);
        r = r + 1;
    end

    if ~supports_double_link
        % return here if not capable of double link
        results = results(1:numel(single_links));
        return
    end

    for d = [double_links{:}]
        % disp(d{1})
        l1 = d{1}(1);
        l2 = d{1}(2);

        assert(l1.tx_idx == l2.tx_idx, "Must be addressing same transmitter");
        assert(l1.rx_idx ~= l2.rx_idx, "Must be addressing different receivers");

        elev_mask = l1.elevation_mask & l2.elevation_mask;

        key1 = [num2str(l1.rx_idx), ' ', num2str(l1.tx_idx)];
        key2 = [num2str(l2.rx_idx), ' ', num2str(l2.tx_idx)];

        loss_1 = loss_dict(key1).TotalLoss("probability").values(elev_mask);
        loss_2 = loss_dict(key2).TotalLoss("probability").values(elev_mask);

        noise_1 = background_counts_dict(key1).values(elev_mask);
        noise_2 = background_counts_dict(key2).values(elev_mask);

        dim = size(elev_mask);
        secret_key_rate = zeros(size(dim));
        sifted_key_rate = zeros(size(dim));
        qber = zeros(size(dim));

        [skr, kr, q] = qkd_protocol.Calculate( ...
            transmitter{l1.tx_idx}, ...
            {receiver{l1.rx_idx}, receiver{l2.rx_idx}}, ...
            [loss_1; loss_2], "probability", ...
            [noise_1; noise_2]);

        secret_key_rate(elev_mask) = skr;
        sifted_key_rate(elev_mask) = kr;
        qber(elev_mask) = q;

        rx_loc = createArray(1, 2, "nodes.Located_Object");
        rx_loc(1) = nodes.Located_Object().SetPosition( ...
            "Latitude",  receiver{l1.rx_idx}.Latitude, ...
            "Longitude", receiver{l1.rx_idx}.Longitude, ...
            "Altitude",  receiver{l1.rx_idx}.Altitude);
        rx_loc(2) = nodes.Located_Object().SetPosition( ...
            "Latitude",  receiver{l2.rx_idx}.Latitude, ...
            "Longitude", receiver{l2.rx_idx}.Longitude, ...
            "Altitude",  receiver{l2.rx_idx}.Altitude);
        tx_loc = nodes.Located_Object().SetPosition( ...
            "Latitude",  transmitter{l1.tx_idx}.Latitude, ...
            "Longitude", transmitter{l1.tx_idx}.Longitude, ...
            "Altitude",  transmitter{l1.tx_idx}.Altitude);

        results(r) = nodes.PassSimulationResult( ...
            {receiver{l1.rx_idx}, receiver{l2.rx_idx}}, transmitter{l1.tx_idx}, ...
            tx_loc, rx_loc, ...
            [l1.direction, l2.direction], ...
            [l1.heading; l2.heading], ...
            [l1.elevation; l2.elevation], ...
            [l1.range; l2.range], ...
            [l1.time, l2.time], ...
            [l1.elevation_limit, l2.elevation_limit], ...
            elev_mask, ...
            [loss_dict(key1), loss_dict(key2)], ...
            [[dark_counts_dict(key1), dark_counts_dict(key2)]; ...
            [background_counts_dict(key1), background_counts_dict(key2)]], ...
            sifted_key_rate, secret_key_rate, qber, protocol_name);
        r = r + 1;
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

    needs_env = cellfun(@(maybe_has_env) isa(maybe_has_env, 'nodes.Ground_Station'), receiver);

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
        tx = transmitters{T};
        i = 1;
        valid_links = zeros(1, n_receivers); % for current transmitter
        elevation_limits = zeros(1, n_receivers);

        % relative_locations = createArray(1, n_receivers, ...
        %     Like=loc_time(0, 0, 0, [], [], [], 0, [], []));

        relative_locations = createArray(1, n_receivers, Like=loc_time);
        for R = 1:numel(receivers)
            rx = receivers{R};
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


function [loss, noise] = loss_and_noise_for_channel(receiver, transmitter, qkd_protocol, options)
    arguments
        receiver { ...
            nodes.mustBeReceiverOrTransmitter(receiver), ...
            nodes.mustHaveDetector(receiver) }
        transmitter { ...
            nodes.mustBeReceiverOrTransmitter(transmitter), ...
            nodes.mustHaveSource(transmitter) }
        qkd_protocol protocol.proto
        options.Environment environment.Environment
    end

    link_loss_args = {
        "qkd", receiver, transmitter, ...
        "apt", "optical", "geometric", "turbulence" ...
    };

    switch class(transmitter)
    case "nodes.Satellite"
        [headings, elevations, ~] = transmitter.RelativeHeadingAndElevation(receiver);
    case "nodes.Ground_Station"
        [headings, elevations, ~] = receiver.RelativeHeadingAndElevation(transmitter);
    end

    background_counts_per_second = zeros(size(headings));

    if ismember(fieldnames(options), "Environment")
        link_loss_args{end + 1} = "atmospheric";
        link_loss_args{end + 1} = "environment";
        link_loss_args{end + 1} = options.Environment;


        background_radiance = options.Environment.Interp( ...
            "spectral_radiance", abs(headings), abs(elevations), transmitter.Source.Wavelength);

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
    end

    [loss, ~] = nodes.linkLoss(link_loss_args{:});

    dark_counts = ones(size(headings)) ...
        .* receiver.Detector.Dark_Count_Rate ...
        .* qkd_protocol.num_detectors;

    noise = [ ...
        environment.Noise("Detector Dark Counts", dark_counts), ...
        environment.Noise("Background Counts", background_counts_per_second), ...
    ];
end

