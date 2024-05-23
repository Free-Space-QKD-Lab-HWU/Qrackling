%% 1. Choose parameters
% wavelength is measured in nm
wavelength = 780;

% diameters are measured in m
transmitter_telescope_diameter = 0.1;

% orbits are described by files containing latitude, longitude, altitude and
% time stamps. These are in the 'orbit modelling resources' folder
orbit_data_file_location = '100kmSSOrbitLLAT.txt';

receiver_telescope_diameter = 1;

% times are measured in s
time_gate_width = 1E-9;

% consistent with wavelength, spectral width is measured in nm
spectral_filter_width = 10;


%% 2. Construct components

%2.1.1 Source
source = components.Source( ...
    wavelength,...
   'Repetition_Rate', 1E8,...
   'MPN_Signal', 0.1); % we use default values to simplify this example

%2.1.2 Detector
% Need to provide repetition rate in order to compute QBER and loss due to
% time gating
detector = components.Detector( ...
    wavelength, ...
    source.Repetition_Rate, ...
    time_gate_width, ...
    spectral_filter_width, ...
    'Preset', components.loadPreset("PerkinElmer"));

%2.1.3 Transmitter telescope
% Do not need to specify wavelength as this will be set by satellite object
transmitter_telescope = components.Telescope(transmitter_telescope_diameter);

%2.1.4 Receiver telescope
receiver_telescope = components.Telescope( ...
    receiver_telescope_diameter, ...
    'FOV', 10E-6,...
    'Wavelength', wavelength);

%2.2.1 Construct satellite
sim_satellite = nodes.Satellite( ...
    transmitter_telescope, ...
    'Source', source,...
    'Detector', detector, ...
    'OrbitDataFileLocation', orbit_data_file_location);

%2.2.2 construct ground station, use Heriot-Watt as an example
sim_ground_station_edi = nodes.Ground_Station( ...
    receiver_telescope,...
    'Detector', detector,...
    'LLA', [55.909723, -3.319995,10],...
    'Name', 'Heriot-Watt');

sim_ground_station_inv = nodes.Ground_Station( ...
    receiver_telescope,...
    'Detector', detector,...
    'LLA', [57.4778, -4.2247, 10],...
    'Name', 'Inverness');

sim_ground_station_paris = nodes.Ground_Station( ...
    receiver_telescope,...
    'Detector', detector,...
    'LLA', [48.856667, 2.352222, 10],...
    'Name', 'Inverness');

%% double link

% result = nodes.QkdPassSimulation( ...
%     [sim_ground_station, sim_ground_station], ...
%     sim_satellite, ...
%     protocol.bbm92)

rx = [sim_ground_station, sim_ground_station];
tx = sim_satellite;

if isscalar(rx) && isscalar(tx)
    direction = nodes.LinkDirection.DetermineLinkDirection(rx, tx);
elseif isscalar(rx) && ~isscalar(tx)
    direction = createArray(1, 2, Like=nodes.LinkDirection.Downlink);
    for i = 1:numel(tx)
        direction(i) = nodes.LinkDirection.DetermineLinkDirection(rx, tx(i));
    end
elseif isscalar(tx) && ~isscalar(rx)
    direction = createArray(1, 2, Like=nodes.LinkDirection.Downlink);
    for i = 1:numel(rx)
        direction(i) = nodes.LinkDirection.DetermineLinkDirection(rx(i), tx);
    end
end
disp(direction)

%{
    NOTE: what is the problem to be solved here?
    - For a set of transmitters and receivers we want to find {tx, rx} pairs
        that have line-of-sight of eachother.
    - Then, for each pair we want to perform the qkd simulation
%}

%{
    NOTE: Next problem...
    - We need to go over all pairs
    - So, how about an array of combinations of tx and rx but only of their
        indices in their arrays
%}

tx_rx_pairs = {}
[h, e, r] = tx.RelativeHeadingAndElevation(rx(1))
e_mask = e > rx(1).Elevation_Limit
if sum(e_mask) > 0
    tx_rx_pairs{numel(tx_rx_pairs) + 1} = {tx, rx(1)}
end
tx_rx_pairs

% [s,g] = tx_rx_pairs{1}{:} % I'll be using this later

tx_rx_pairs = {}
for i = 1:numel(direction)
    switch direction(i)
    case nodes.LinkDirection.Downlink
        [headings, elevations, ranges] = tx.RelativeHeadingAndElevation(rx(i));
        elevation_limit_mask = elevations > rx(i).Elevation_Limit;
        if sum(elevation_limit_mask) > 0
            total_pairs = numel(tx_rx_pairs) + 1;
            tx_rx_pairs{total_pairs} = {tx, rx(i)};
        end

    case nodes.LinkDirection.Downlink
        [headings, elevations, ranges] = rx.RelativeHeadingAndElevation(tx(i));
        elevation_limit_mask = elevations > tx(i).Elevation_Limit;
        if sum(elevation_limit_mask) > 0
            total_pairs = numel(tx_rx_pairs) + 1;
            tx_rx_pairs{total_pairs} = {tx(i), rx};
        end

    case nodes.LinkDirection.Intersatellite
        error("UNIMPLEMENTED")
    case nodes.LinkDirection.Terrestrial
        error("UNIMPLEMENTED")
    end
end

tx_rx_pairs

%% The following allows for finding all single links
receivers = {sim_ground_station_edi, sim_ground_station_inv, sim_ground_station_paris};
transmitters = {sim_satellite};
[Receivers, Transmitters] = meshgrid(receivers, transmitters);
Receivers = {Receivers{:}};
Transmitters = {Transmitters{:}};

assert(numel(Receivers) == numel(Transmitters));

valid_links = zeros(1, numel(Receivers));
directions = createArray(1, numel(Receivers), Like=nodes.LinkDirection.Downlink);

Location = @(heading, elevation, range) ...
    struct("heading", heading, "elevation", elevation, "range", range);

relative_locations = createArray(1, numel(Receivers), Like=Location([], [], []));

for i = 1:numel(Receivers)
    rx = Receivers{i};
    tx = Transmitters{i};
    directions(i) = nodes.LinkDirection.DetermineLinkDirection(rx, tx);

    switch directions(i)

    case nodes.LinkDirection.Downlink
        [h, e, r] = tx.RelativeHeadingAndElevation(rx);
        elevation_limit_mask = e > rx.Elevation_Limit;
        if sum(elevation_limit_mask) > 0
            valid_links(i) = 1;
        end

    case nodes.LinkDirection.Uplink
        [h, e, r] = rx.RelativeHeadingAndElevation(tx);
        elevation_limit_mask = e > tx.Elevation_Limit;
        if sum(elevation_limit_mask) > 0
            valid_links(i) = 1;
        end

    end
    relative_locations(i) = Location(h, e, r);
end

valid_links
directions

relative_locations

for r = relative_locations
    disp(numel(r.elevation))
end

%% Now how do we take care of dual links?

receivers = {sim_ground_station_edi, sim_ground_station_inv, sim_ground_station_paris};
transmitters = {sim_satellite};
Receivers = {receivers{:}};
Transmitters = {transmitters{:}};

% assert(numel(Receivers) == numel(Transmitters));

LocationTime = @(heading, elevation, range, time) ...
    struct("heading", heading, ...
           "elevation", elevation, ...
           "range", range, ...
           "time", time);

Extrema = @(arr) [min(arr), max(arr)];

double_link_idx = {};

for t = 1:numel(Transmitters)
    tx = Transmitters{t};
    directions = createArray(1, numel(Receivers), Like=nodes.LinkDirection.Downlink);
    i = 1;
    valid_links = zeros(1, numel(Receivers)); % for current transmitter
    relative_locations = createArray(1, numel(Receivers), Like=LocationTime([], [], [], []));
    for r = 1:numel(Receivers)
        rx = Receivers{r};
        directions(i) = nodes.LinkDirection.DetermineLinkDirection(rx, tx);

        switch directions(i)

        case nodes.LinkDirection.Downlink
            [h, e, r] = tx.RelativeHeadingAndElevation(rx);
            relative_locations(i) = LocationTime(h, e, r, tx.Times);
            elevation_limit_mask = e > rx.Elevation_Limit;
            if sum(elevation_limit_mask) > 0
                valid_links(i) = 1;
            end

        case nodes.LinkDirection.Uplink
            [h, e, r] = rx.RelativeHeadingAndElevation(tx);
            relative_locations(i) = LocationTime(h, e, r, rx.Times);
            elevation_limit_mask = e > tx.Elevation_Limit;
            if sum(elevation_limit_mask) > 0
                valid_links(i) = 1;
            end

        end
        i = i + 1;
    end

    if sum(valid_links) < 2
        % skip to next transmitter if there is one
        continue
    end

    n = numel(valid_links);
    for rx_pairs = nchoosek(linspace(1, n, n), 2)'
        i = rx_pairs(1);
        j = rx_pairs(2);
        tt_i = timetable(Extrema(relative_locations(i).time(relative_locations(i).elevation > 30))');
        tt_j = timetable(Extrema(relative_locations(j).time(relative_locations(j).elevation > 30))');
        if ~overlapsrange(tt_i, tt_j)
            % skip to next pair
            continue
        end
        dl_idx = numel(double_link_idx) + 1;
        double_link_idx{dl_idx} = {t, i, j}; % {transmitter, receiver_i, receivers_j}
    end

end

disp(double_link_idx)
l_idx = 1;
disp(double_link_idx{l_idx})
choice_tx = Transmitters{double_link_idx{l_idx}{1}};
choice_rx_i = Receivers{double_link_idx{l_idx}{2}};
choice_rx_j = Receivers{double_link_idx{l_idx}{3}};

link_loss_args = {
    "qkd", Receiver, Transmitter, ...
    "apt", "optical", "geometric", "turbulence" ...
};
background_counts_per_second = zeros(size(headings));

% if ismember(fieldnames(options), "Environment")
if false
    link_loss_args{numel(link_loss_args)} = "atmospheric";
    link_loss_args{numel(link_loss_args)} = "environment";
    link_loss_args{numel(link_loss_args)} = options.Environment;
    % TODO: check length of environment if present, if single assume all use it
    % if not then must have environment per rx

    switch class(choice_tx)
    case "nodes.Satellite"
        [headings, elevations, ~] = choice_tx.RelativeHeadingAndElevation(choice_rx_i);
    case "nodes.Ground_Station"
        [headings, elevations, ~] = choice_tx.RelativeHeadingAndElevation(choice_rx_i);
    end

    background_radiance = options.Environment.Interp( ...
        "spectral_radiance", abs(headings), abs(elevations), choice_tx.Source.Wavelength);

    t = choice_rx_i.Detector.Spectral_Filter.transmission;
    w = choice_rx_i.Detector.Spectral_Filter.wavelengths;
    w_range = w(t ~= 0);
    filter_width = max(w_range) - min(w_range);

    background_counts_per_second = environment.countRateFromRadiance( ...
        background_radiance, ...
        choice_rx_i.Telescope.FOV, ...
        choice_rx_i.Telescope.Diameter, ...
        filter_width, ...
        1, ...
        choice_rx_i.Detector.Wavelength);
end


terminals = {sim_ground_station_edi, sim_satellite, sim_ground_station_paris}
n_rx = numel(terminals);
temp = cellfun(@(maybe_ogs) isa(maybe_ogs, 'nodes.Ground_Station'), terminals)
temp .* cumsum(temp)


isnumeric( relative_locations(1).time )

isdatetime( relative_locations(1).time)

isa(relative_locations(1).time, "datetime")

size(relative_locations(1).time)

%% testing new QkdPassSimulation
receivers = {sim_ground_station_edi, sim_ground_station_inv, sim_ground_station_paris};
transmitters = {sim_satellite};
[~] = nodes.QkdPassSimulationNext(receivers, transmitters, protocol.bbm92)
