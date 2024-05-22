function results = QkdPassSimulationNext(receiver, transmitter, qkd_protocol, options)
    arguments
        receiver { ...
            mustBeA(receiver, ["nodes.Satellite", "nodes.Ground_Station"]), ...
            nodes.mustHaveDetector(receiver)}
        transmitter { ...
            mustBeA(transmitter, ["nodes.Satellite", "nodes.Ground_Station"]), ...
            nodes.mustHaveSource(transmitter)}
        qkd_protocol protocol.proto
        options.Environment environment.Environment
    end

    have_environment = ismember(fieldnames(options), "Environment");

    % check length of needs_env to pick route
    needs_env = have_environment;
    if have_environment
        needs_env = map_receivers_and_environments(receiver, "Environment", options.Environment);
    end
end


function needs_env = map_receivers_and_environments(receiver, options)
    arguments
        receiver { ...
            mustBeA(receiver, ["nodes.Satellite", "nodes.Ground_Station"]), ...
            nodes.mustHaveDetector(receiver)}
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


function loc_time = location_time(heading, elevation, range, time)
    arguments
        heading (1, :) {mustBeNumeric}
        elevation (1, :) {mustBeNumeric}
        range (1, :) {mustBeNumeric}
        time (1, :) {mustBeA(time, "datetime")}
    end

    loc_time = struct( ...
        "heading", heading, ...
        "elevation", elevation, ...
        "range", range, ...
        "time", time);
end


function tt = timetable_for_elevation_window(rel_loc, elev_limit)
    elev_mask = rel_loc.elevation > elev_limit;
    tt = timetable(extrema(elev_mask)');
end


function links = find_double_links(receivers, transmitters)
    arguments
        receivers { ...
            mustBeA(receivers, ["nodes.Satellite", "nodes.Ground_Station"]), ...
            nodes.mustHaveDetector(receivers)}
        transmitters { ...
            mustBeA(transmitters, ["nodes.Satellite", "nodes.Ground_Station"]), ...
            nodes.mustHaveSource(transmitters)}
    end

    double_link_idx = {};

    for T = 1:numel(transmitters)
        tx = transmitters{T};
        directions = createArray(1, numel(receivers), Like=nodes.LinkDirection.Downlink);
        i = 1;
        valid_links = zeros(1, numel(receivers)); % for current transmitter
        relative_locations = createArray(1, numel(receivers), Like=LocationTime([], [], [], []));
        elevation_limits = zeros(1, numel(receivers));
        for R = 1:numel(receivers)
            rx = receivers{R};
            directions(i) = nodes.LinkDirection.DetermineLinkDirection(rx, tx);

            switch directions(i)
                case nodes.LinkDirection.Downlink
                    [h, e, r] = tx.RelativeHeadingAndElevation(rx);
                    relative_locations(i) = LocationTime(h, e, r, tx.Times);
                    elevation_limits(i) = rx.Elevation_Limit;

                case nodes.LinkDirection.Uplink
                    [h, e, r] = rx.RelativeHeadingAndElevation(tx);
                    relative_locations(i) = LocationTime(h, e, r, rx.Times);
                    elevation_limits(i) = tx.Elevation_Limit;
            end

            elevation_limit_mask = relative_locations(i).elevation > elevation_limits(i);
            if sum(elevation_limit_mask) > 0
                valid_links(i) = 1;
            end

            i = i + 1;
        end

        if sum(valid_links) < 2
            % skip to next transmitter if there is one
            continue
        end

        n = numel(valid_links);
        for rx_pairs = nchoosek(linspace(1, n, n), 2)'

            tt_i = timetable_for_elevation_window( ...
                relative_locations(rx_pairs(1)), ...
                elevation_limits(rx_pairs(1)));

            tt_j = timetable_for_elevation_window( ...
                relative_locations(rx_pairs(2)), ...
                elevation_limits(rx_pairs(2)));

            if ~overlapsrange(tt_i, tt_j)
                % skip to next pair
                continue
            end

            dl_idx = numel(double_link_idx) + 1;
            double_link_idx{dl_idx} = {t, rx_pairs(1), rx_pairs(2)}; % {transmitter, receiver_i, receivers_j}
        end

    end

    links = double_link_idx;
end


function [loss, noise] = loss_and_noise_for_channel(receiver, transmitter, options)
    arguments
        receiver { ...
            mustBeA(receiver, ["nodes.Satellite", "nodes.Ground_Station"]), ...
            nodes.mustHaveDetector(receiver)}
        transmitter { ...
            mustBeA(transmitter, ["nodes.Satellite", "nodes.Ground_Station"]), ...
            nodes.mustHaveSource(transmitter)}
        options.Environment environment.Environment
    end

    link_loss_args = {
        "qkd", Receiver, Transmitter, ...
        "apt", "optical", "geometric", "turbulence" ...
    };
    background_counts_per_second = zeros(size(headings));
end
