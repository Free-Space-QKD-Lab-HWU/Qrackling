%% run
clear all
close all
clc

ContentsOfDirectory = @(DirPath) {dir(adduserpath(DirPath)).name};

FilterFiles = @(DirectoryContents, Query) ...
    {DirectoryContents{cellfun( ...
        @(fp) contains(fp, Query), ...
        DirectoryContents)} ...
    };

in_target_path = '~/Documents/tqi_data/inputs/';

in_radianceFiles = FilterFiles( ...
    ContentsOfDirectory(in_target_path), ...
    '__radiance');

disp(in_radianceFiles')

in_file = strjoin({in_target_path, in_radianceFiles{1}}, '')

rf = radiance_file(in_file)

radiance = rf.pickRadianceForWavelength(1550);
[r, t] = meshgrid(rf.elevations, deg2rad(rf.azimuths - 270));

extrema = @(arraylike) [min(arraylike(:)), max(arraylike(:))];
extrema(radiance)

%% 

radiance ./ 1000

%%
close all
figure
wvl = 1550;
ff = polarpcolor( ...
    rad2deg(rf.elevations), ...
    rf.azimuths, ...
    log10(rf.pickRadianceForWavelength(wvl)) ...
);
title(['Radiance at ', num2str(wvl), 'nm']);

figure
wvl = 780;
ff = polarpcolor( ...
    rad2deg(rf.elevations), ...
    rf.azimuths, ...
    log10(rf.pickRadianceForWavelength(wvl)) ...
);
title(['Radiance at ', num2str(wvl), 'nm']);

%% 

orbit_data_root = adduserpath( ...
    '/Projects/QKD_Sat_Link/smarts_integration/orbit modelling resources/orbit LLAT files/');

% Declare common values
transmitter_diameter = 0.08;
receiver_diameter = 0.7;
orbit_data_file_location = [orbit_data_root, '500kmOrbitLLAT.txt'];
orbit_data_file_location = [orbit_data_root, '500kmSSOrbitLLAT.txt'];
time_gate_width = 10^-9;
%Time_Gate_width = 1;
repetition_rate = 1;
spectral_filter_width = 10e-3;
spectral_filter_width = 1;
% spectral_filter_width_arr = 10 .^ linspace(-4, 0, 25);
% Spectral_filter_width_arr = 10 .^ linspace(0, 0, 1);
wavelength = 850;

%total_skr = zeros(size(Spectral_filter_width_arr));

transmitter_telescope = Telescope( ...
    transmitter_diameter, ...
    Wavelength = wavelength);

receiver_telescope = Telescope( ...
    receiver_diameter, ...
    Wavelength = wavelength);

bb84_s = BB84_Source(wavelength);
bb84_p = BB84_Protocol();
bb84_d = MPD_Detector( ...
    wavelength, ...
    repetition_rate, ...
    time_gate_width, ...
    spectral_filter_width);

sim_satellite = Satellite( ...
    transmitter_telescope, ...
    Source = bb84_s, ...
    OrbitDataFileLocation = orbit_data_file_location);

sim_ground_station = Errol_OGS(receiver_telescope, Detector = bb84_d);

bb84_pass = PassSimulation(sim_satellite, bb84_p, sim_ground_station);
bb84_pass = Simulate(bb84_pass);
is_communicating = bb84_pass.Communicating_Flags == 1;
active_azimuth = bb84_pass.Headings(is_communicating);
active_elevations = bb84_pass.Elevations(is_communicating);

%%


