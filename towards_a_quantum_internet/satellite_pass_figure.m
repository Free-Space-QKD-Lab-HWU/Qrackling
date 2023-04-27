%% Generate figure 1 of tqi report
close all
clear all

%% Ensure that latex mode is properly enabled
list_factory = fieldnames(get(groot,'factory'));
index_interpreter = find(contains(list_factory,'Interpreter'));
for i = 1:length(index_interpreter)
    default_name = strrep(list_factory{index_interpreter(i)},'factory','default');
    set(groot, default_name,'latex');
end

%% Pick 500km sun synchronous orbit
orbit_data_root = adduserpath([ ...
    '~/Projects/QKD_Sat_Link/libRadTran/', ...
    'orbit modelling resources/orbit LLAT files/']);
OrbitDataFileLocation = '500kmSSOrbitLLAT.txt';

%% Configure
wavelength = 850;

transmitter_telescope_diameter = 0.1;
receiver_telescope_diameter = 1;

time_gate_width = 1E-9;
Spectral_filter_width = 1;

transmitter_source = decoyBB84_Source(wavelength);
bb84_protocol = decoyBB84_Protocol;
mpd_bb84_detector = MPD_Detector( ...
    wavelength, ...
    transmitter_source.Repetition_Rate, ...
    time_gate_width, ...
    Spectral_filter_width);
%mpd_bb84_detector = mpd_bb84_detector.SetDetectionEfficiency(1);
% %%wavelength = 1550;
%mpd_bb84_detector = mpd_bb84_detector.SetWavelength(wavelength);

transmitter_telescope = Telescope(transmitter_telescope_diameter);
%transmitter_telescope.Optical_Efficiency = 1;
sim_satellite = Satellite( ...
    transmitter_telescope, ...
    Source = transmitter_source, ...
    OrbitDataFileLocation = OrbitDataFileLocation);

receiver_telescope = Telescope(receiver_telescope_diameter);
receiver_telescope = receiver_telescope.SetWavelength(wavelength);
%receiver_telescope.Optical_Efficiency = 1;
sim_ground_station = Errol_OGS( ...
    receiver_telescope, ...
    Detector = mpd_bb84_detector);

pass_sim = PassSimulation( ...
    sim_satellite, ...
    decoyBB84_Protocol, ...
    sim_ground_station);

pass_result = Simulate(pass_sim);
plot(pass_result);

%% Save figure
exportgraphics(gcf, ...
    adduserpath('~/Documents/tqi_review_march_2023/src/figures/nominal_pass.pdf'), ...
    ContentType = 'vector')
