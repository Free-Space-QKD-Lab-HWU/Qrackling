%% A full worked example
clear all
close all
clc

%% make a ground station

telescope = components.Telescope( ...
    0.7, ...
    'Pointing_Jitter', 1e-6,...
    'Optical_Efficiency', (1-0.3^2)*10^(-1.1/10),...
    'Focal_Length', 8.4,...
    'Eyepiece_Focal_Length', 0.076);

filter_file = '~/Projects/QKD_Sat_Link/adaptive_optics/Example Data/spectral filters';
        channel_wavelength = 785;
        repetition_rate = 1E8;
        time_gate = 2E-9;
        spectral_filter = SpectralFilter('input_file',[filter_file, filesep(),'FBH780-10.xlsx']);

detector = components.Detector( channel_wavelength, repetition_rate, ...
    time_gate, spectral_filter, ...
    "Preset", components.loadPreset("Excelitas") );

camera_telescope = components.Telescope( 0.4, ...
    'Wavelength', 685, ...
    'Optical_Efficiency', 1 - 0.39^2, ...
    'Focal_Length', 2.72, ...
    'Pointing_Jitter', 1e-3);

exposure_time = 0.01;
spectral_filter_width = 10;
camera = AC4040(camera_telescope, exposure_time, spectral_filter_width);

beacon_power = 40E-3;
beacon_wavelength = 850;
beacon_pointing_precision = 1E-6;
beacon_beam_divergence = 0.0070;
beacon_telescope = SetWavelength(telescope, beacon_wavelength);
beacon_telescope = SetFOV(beacon_telescope, beacon_beam_divergence);
beacon_efficiency = 1;
gaussian_beacon = beacon.Gaussian_Beacon( ...
    beacon_telescope, beacon_power, beacon_wavelength,...
    beacon_pointing_precision, beacon_efficiency);

sky_brightness = '~/Projects/QKD_Sat_Link/adaptive_optics/Example Data/orbit modelling resources/background count rate files/Errol_Experimental_Sky_Brightness_Store.mat';

hogs = nodes.Ground_Station(telescope,...
    'Detector', detector,...
    'Camera', camera, ...
    'Beacon', gaussian_beacon, ...
    'Sky_Brightness_Store_Location', sky_brightness, ...
    'LLA', [55.909723, -3.319995,10],...
    'name', 'Heriot Watt');


%% make a satellite

example_times = '25/12/2022, 08:44, 14:50, 16:22, 17:55';
elems = strsplit(example_times);
date_str = replace([elems{1}, '-', elems{2}], ',', '');
pass = datetime(date_str, InputFormat = "dd/MM/yyyy-HH:mm");
start_time = pass - minutes(30);
stop_time = pass + minutes(30);

start_time = datetime(2022,12,25,6,0,0);
stop_time = datetime(2022,12,25,7,0,0);

sample_time = seconds(1);

%Telescope
%for details (and details of downlink beacon) see
% Quarc: Quantum research cubesat—a constellation for quantum communication
%Mazzarella, Luc, Lowe, Christopher, Lowndes, David, Joshi, Siddarth Koduru, Greenland, Steve
%McNeil, Doug, Mercury, Cassandra, Macdonald, Malcolm, Rarity, John, Oi, Daniel Kuan Li

%telescope diameter in m
hub_sat_scope_diameter = 0.08;

%telescope optical efficiency (unitless)
hub_sat_scope_efficiency = 1;

%telescope pointing error in rads
hub_sat_pointing_jitter = 1E-6;

wavelength = 785;

telescope = components.Telescope(hub_sat_scope_diameter,...
    'Wavelength', wavelength,...
    'Optical_Efficiency', hub_sat_scope_efficiency,...
    'Pointing_Jitter', hub_sat_pointing_jitter);

%source
%for details see
% "Design and test of optical payload for polarization encoded QKD for Nanosatellites"
% by Sagar, Jaya, Hastings, Elliott, Zhang, Piede, Stefko, Milan, Lowndes, David, Oi, Daniel, Rarity, John, Joshi, Siddarth K.

%source mean photon numbers (unitless)
hub_sat_source_mp_ns = [0.8,0.3,0];

%source state probabilities (unitless)
hub_sat_source_probs = [0.75,0.25,0.25];

%source pulse rate in Hz
hub_sat_source_rep_rate = 1E8;

%source g2 (unitless)
hub_sat_source_g2 = 0.01;

%source efficiency (unitless)
hub_sat_source_efficiency = 1;

%source state preparation error probability (unitless)
hub_sat_source_state_prep_error = 0.0025;

source = components.Source(wavelength,...
    'Mean_Photon_Number', hub_sat_source_mp_ns,...
    'State_Probabilities', hub_sat_source_probs,...
    'Repetition_Rate', hub_sat_source_rep_rate,...
    'g2', hub_sat_source_g2,...
    'Efficiency', hub_sat_source_efficiency,...
    'State_Prep_Error', hub_sat_source_state_prep_error);

%beacon
%beacon optical power in w
beacon_power = 2;

%beacon wavelength in nm
beacon_wavelength = 685;

%beacon optical efficiency (unitless)
beacon_efficiency = 1;

%beacon pointing precision (coarse pointing precision) in rads
beacon_pointing_precision = 1E-3;

beacon_telescope_diameter = 0.01;

beacon_telescope_fov = 0.4*pi/180;
%initially, uncertainty in satellite position is 5km and range is roughly
%downlink beacon has 10mm diameter and 0.4 degrees cone angle
beacon_telescope = components.Telescope( ...
    beacon_telescope_diameter, ...
    'FOV', beacon_telescope_fov, ...
    'Wavelength', beacon_wavelength);

link_beacon = beacon.Flat_Top_Beacon(beacon_telescope, beacon_power, beacon_wavelength);

%camera
camera_scope_diameter = 0.08;
camera_scope_focal_length = 0.86;
camera_scope_optical_efficiency = 1;
camera_pointing_precision = 1E-3;
camera_telescope = components.Telescope(camera_scope_diameter,...
    'Wavelength', 850,...
    'Optical_Efficiency', camera_scope_optical_efficiency,...
    'Focal_Length', camera_scope_focal_length,...
    'Pointing_Jitter', camera_pointing_precision);

%camera exposure time in s
exposure_time = 0.001;

%spectral filter width in nm
spectral_filter_width = 10;

%until we have a better idea, this will have to do for the uplink camera
camera = CVM4000(camera_telescope, exposure_time, spectral_filter_width);

%% construct satellite with correct orbital parameters
spoqc = nodes.Satellite(telescope,...
    'Name', 'SPOQC',...
    'Source', source,...
    'Beacon', link_beacon,...
    'Camera', camera,...
    'Surface', Satellite_Foil_Surface(0.01), ...          %correctly set reflevctive surface proporties and area
    'SemiMajorAxis', 600E3 + earthRadius,...             %mean orbital radius = Altitude + Earth radius
    'eccentricity', 0,...                                %measure of ellipticity of the orbit, for circular, =0
    'inclination', 9.7065055549e+01,...                  %inclination of orbit in deg- set by sun synchronicity
    'rightAscensionOfAscendingNode', -1.5,...            %measure of location of orbit in longitude
    'argumentOfPeriapsis', 0,...                         %measurement of location of ellipse nature of orbit in longitude, irrelevant for circular orbits
    'trueAnomaly', 0,...                                 %initial position through orbit of satellite
    'StartTime', start_time,...                           %start of simulation
    'StopTime', stop_time,...                             %end of simulation
    'sampleTime', sample_time);                           %simulation interval in s


%% collect some result

% QKD simulation, downlink
result = nodes.QkdPassSimulation(hogs, spoqc, "DecoyBB84");
fig = result.plotResult(spoqc.Times, "Time (s)", hogs, spoqc, "mask", "Elevation");

% beacon simulation, downlink
beacon_loss_down = beacon.beaconSimulation(hogs, spoqc);
beacon_loss_down.plot(spoqc.Times, "time (s)", "mask", result.within_elevation_limit)

% beacon simulation, up
beacon_loss_up = beacon.beaconSimulation(spoqc, hogs);
beacon_loss_up.plot(spoqc.Times, "time (s)", "mask", result.within_elevation_limit)
