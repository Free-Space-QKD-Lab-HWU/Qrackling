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

%2.1.1 Detector
% Need to provide repetition rate in order to compute QBER and loss due to
% time gating
detector = components.Detector( ...
    wavelength, ...
    source.Repetition_Rate, ...
    time_gate_width, ...
    spectral_filter_width, ...
    'Preset', components.loadPreset("PerkinElmer"));

%2.1.2 Source
source = components.Source( ...
    wavelength,...
   'Repetition_Rate', 1E8,...
   'MPN_Signal', 0.1); % we use default values to simplify this example

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
receivers = {sim_ground_station_edi, sim_ground_station_inv};
transmitters = {sim_satellite, sim_satellite};
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
        elevation_limit_mask = elevations > rx.Elevation_Limit;
        if sum(elevation_limit_mask) > 0
            valid_links(i) = 1;
        end

    case nodes.LinkDirection.Uplink
        [h, e, r] = rx.RelativeHeadingAndElevation(tx);
        elevation_limit_mask = elevations > tx.Elevation_Limit;
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

receivers = {sim_ground_station_edi, sim_ground_station_inv};
transmitters = {sim_satellite};
Receivers = {receivers{:}};
Transmitters = {transmitters{:}};

% assert(numel(Receivers) == numel(Transmitters));

for t = 1:numel(Transmitters)
    tx = Transmitters{t};
    directions = createArray(1, numel(Receivers), Like=nodes.LinkDirection.Downlink);
    i = 1;
    valid_links = zeros(1, numel(Receivers));
    for r = 1:numel(Receivers)
        rx = Receivers{r};
        directions(i) = nodes.LinkDirection.DetermineLinkDirection(rx, tx);

        switch directions(i)

        case nodes.LinkDirection.Downlink
            [h, e, r] = tx.RelativeHeadingAndElevation(rx);
            elevation_limit_mask = elevations > rx.Elevation_Limit;
            if sum(elevation_limit_mask) > 0
                valid_links(i) = 1;
            end

        case nodes.LinkDirection.Uplink
            [h, e, r] = rx.RelativeHeadingAndElevation(tx);
            elevation_limit_mask = elevations > tx.Elevation_Limit;
            if sum(elevation_limit_mask) > 0
                valid_links(i) = 1;
            end

        end
        i = i + 1;
    end
    disp(valid_links)
    disp(directions)
end
