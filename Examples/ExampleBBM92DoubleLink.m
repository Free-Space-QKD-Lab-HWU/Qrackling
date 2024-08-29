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
   'MPN_Signal', 0.1, ...
   'MPN_Decoy', 0.1, ...
   'Probability_Signal', 0.5, ...
   'Probability_Decoy', 0.3 ); % we use default values to simplify this example

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
    'FOV', 10E-6, ...
    'Wavelength', wavelength);

%2.2.1 Construct satellite
sim_satellite = nodes.Satellite( ...
    transmitter_telescope, ...
    'Source', source,...
    'Detector', detector, ...
    'OrbitDataFileLocation', orbit_data_file_location, ...
    'Name', "SPOQC");

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
    'name', 'Paris');

sim_ground_station_inv = sim_ground_station_inv.SetElevationLimit(30);
sim_ground_station_edi = sim_ground_station_edi.SetElevationLimit(30);

receivers = {sim_ground_station_edi, sim_ground_station_inv, sim_ground_station_paris};
transmitters = sim_satellite;

env_2km = environment.Environment.Load(which("Dark Environment 2km.mat"));
env_5km = environment.Environment.Load(which("Dark Environment 5km.mat"));
env_10km = environment.Environment.Load(which("Dark Environment 10km.mat"));
env_50km = environment.Environment.Load(which("Dark Environment 50km.mat"));

proto = protocol.bbm92;
proto = protocol.decoyBB84;

results = nodes.QkdPassSimulation(receivers, transmitters, proto, ...
    "Environment", [env_50km, env_10km, env_2km]);

for result = results
    result.plot()
end
