%% A full worked example of a satellite pass simulation
% there are 4 key steps to any simulation: 
%% 
% # a transmitter (here, a satellite)
% # a receiver (here, a ground station)
% # run simulations
% # plot results
%% 1. construct a transmitter (satellite)
% to do this, we need lots of details about the satellite, including:
%% 
% * 1.1 quantum transmitter details
% * 1.2 beacon details (optional)
% * 1.3 orbit details then we can
% * 1.4 construct satellite
% 1.1.1 source
% for details see "Design and test of optical payload for polarization encoded 
% QKD for Nanosatellites" by Sagar, Jaya, Hastings, Elliott, Zhang, Piede, Stefko, 
% Milan, Lowndes, David, Oi, Daniel, Rarity, John, Joshi, Siddarth K.



% source wavelength (nm)
QKD_wavelength = 785;

% create source
source = components.Source( ...
    QKD_wavelength,       ...
    'MPN_Signal',         0.8,   ...
    'MPN_Decoy',          0.3,   ...
    'Probability_Signal', 0.5,   ...
    'Probability_Decoy',  0.25,  ...
    'Repetition_Rate',    1e8,   ...
    'g2',                 0.01,  ...
    'Efficiency',         1,     ...
    'State_Prep_Error',   0.0025 ...
);
% 1.1.2 Telescope
% for details (and details of downlink beacon) see Quarc: Quantum research cubesat—a 
% constellation for quantum communication Mazzarella, Luc, Lowe, Christopher, 
% Lowndes, David, Joshi, Siddarth Koduru Greenland, Steve McNeil, Doug, Mercury, 
% Cassandra, Macdonald, Malcolm, Rarity, John, Oi, Daniel Kuan Li


% create telescope (also requires wavelength)
OGS_telescope = components.Telescope( ...
    0.08,                      ... % telescope diameter in m
    'Wavelength',         QKD_wavelength, ...
    'Optical_Efficiency', 1,   ... % telescope optical efficiency (unitless)
    'Pointing_Jitter',    1e-6 ... % telescope rms pointing error in rads
);
% 1.2.1 
% downlink beacon laser details see the above paper for beacon details. beacon 
% simulations are optional and do not affect quantum channel performance (as pointing 
% performance is specified by a jitter value)

% beacon wavelength in nm
downlink_beacon_wavelength = 685;


% create a beacon telescope object
downlink_beacon_telescope = components.Telescope( ...
    0.01,                                             ...
    'FOV',                deg2rad(0.4),               ...
    'Wavelength',         downlink_beacon_wavelength, ...
    'Optical_Efficiency', 1,                          ...
    'Pointing_Jitter',    1e-3);

% beacon optical power in w
downlink_beacon_power = 2;

% then include this telescope in the beacon object. This uses a flat-top beacon profile but a gaussian beacon is also available
downlink_beacon = beacon.Flat_Top_Beacon(downlink_beacon_telescope, downlink_beacon_power, downlink_beacon_wavelength);


% 1.2.2 downlink beacon camera details
% the satellite requires a camera to image and track the uplink beacon

% wavelength of uplink beacon channel
uplink_beacon_wavelength = 850;

% create a telescope for the camera (in reality this is a focussing lens)
uplink_beacon_camera_telescope = components.Telescope( ...
    0.08,                                           ...
    'Wavelength',         uplink_beacon_wavelength, ...
    'Optical_Efficiency', 1,                        ...
    'Focal_Length',       0.86,                     ...
    'Pointing_Jitter',    1e-3); % pointing precision (this is likely tied to the
                                 % satellite's body pointing precision)
%% 
% there are many properties to every camera, which determine SNR and efficiency. 
% to avoid specifying these, we will load a camera implementation which is pre-packaged.

uplink_beacon_camera = CVM4000( ...
    uplink_beacon_camera_telescope, ...
    0.001,                          ... % camera exposure time in s
    10);                                % spectral filter width in nm
% 1.3 orbit details
% there are many parameters which describe an orbit. we choose to use keplerian 
% parameters. as well as these, we must also provide a time window to simulate 
% (ideally, the satellite would pass the ground station in this time)

% orbital parameters- these conform to the MATLAB satellite communications toolbox keplerian set of orbital parameters

% orbital altitude (km) is used to compute semimajor axis for a circular
% orbit
altitude = 600E3;
semimajor_axis = altitude + earthRadius();
% eccentricity is 0 for a circular orbit. this is a measure of how
% elliptical an orbit is
eccentricity = 0;
% for a sun-synchronous circular orbit, inclination is a function of
% altitude only. we provide a function which can compute the requires
% inclination
inclination = SunSynchronousPolarOrbit(altitude/1000);
% these parameters control the orbit's orientation wrt the earth's surface
right_ascension_of_ascending_node = -1.5;
argument_of_periapsis = 0;
% true anomaly describes where the satellite lies in its orbit
true_anomaly = 0;

% simulation time window- most LEO orbits have more than 1 viable pass per
% day. pick one!
pass_time = datetime(2022,12,25,6,56,0);
%pass_time = datetime(2022,12,25,16,19,0);
%pass_time = datetime(2022,12,25,17,54,0);
% simulation duration. an hour is plenty to cover a full pass inlcuding
% acquisition
duration = minutes(60);
% sample time. 1s samples is the default. longer samples will give better
% performance
sample_time = seconds(1);
% we need to pass a start and stop time
start_time = pass_time - duration / 2;
stop_time = pass_time + duration / 2;

% 1.4 construct satellite
spoqc = nodes.Satellite( ...
    OGS_telescope,                   ...
    'Name',                          'SPOQC',                           ...
    'Source',                        source,                            ...
    'Beacon',                        downlink_beacon,                   ...
    'Camera',                        uplink_beacon_camera,              ...
    'SemiMajorAxis',                 semimajor_axis,                    ...
    'eccentricity',                  eccentricity,                      ...
    'inclination',                   inclination,                       ...
    'rightAscensionOfAscendingNode', right_ascension_of_ascending_node, ...
    'argumentOfPeriapsis',           argument_of_periapsis,             ...
    'trueAnomaly',                   true_anomaly,                      ...
    'StartTime',                     start_time,                        ... % start of simulation
    'StopTime',                      stop_time,                         ... % end of simulation
    'sampleTime',                    sample_time);                          % simulation interval in s
%% 2. construct a receiver (ground station)
% to do this, we need lots of details about the ground station:
%% 
% * 2.1 quantum receiver details
% * 2.2 beacon details (optional)
% * 2.3 location details then we can
% * 2.4 construct ground station
% 2.1 quantum receiver details
% the quantum receiver comprises a telescope and a detector. the detector also 
% requires a spectral filter
% 2.1.1 telescope
% the ground station telescope is likely to be much larger than the satellite's, 
% but is constructed in the same way

% construct a telescope
OGS_telescope = components.Telescope( ...
    0.7,                           ... % telescope diameter (m)
    'Pointing_Jitter',       1e-6, ... % rms pointing error (rads)(after beacon)
    'Optical_Efficiency',    1,    ... % optical efficiency (1 is the default)
    'Focal_Length',          0.4,  ... % telescope focal length (m)
    'Eyepiece_Focal_Length', 0.076 ... % telescope eye piece focal length (m)
);
% 2.1.2 spectral filter
% the spectral filter provides details of how noise is filtered out at the receiver
% 
% provide a file which describes filter spectral performance. an example is 
% given here. nativePathFrom provides path conversion for different OSs filter_file 
% = utilities.nativePathFrom('Example Data/spectral filters/FBH780-10.xlsx'); 
% spectral_filter = components.SpectralFilter('input_file', filter_file); alternatively, 
% a dummy spectral filter can be created which has a brick-wall spectral response 
% using

spectral_filter = components.IdealBPFilter(source.Wavelength, 5);
% 2.1.3 detector
% we provide details of some preset detectors. custom detectors can also be 
% instantiated by providing their details. As well as performance data, the detector 
% requires channel information to compute QBER.

% construct detector
detector = components.Detector( ...
    QKD_wavelength,         ...
    source.Repetition_Rate, ...
    2e-9,                   ... % time gate width in s
    spectral_filter,        ...
    "Preset", components.loadPreset("Excelitas") );
% 2.2 beacon details
% we need to provide the other end of both beacon links. an uplink beacon laser 
% and a downlink beacon camera
% 2.2.1 downlink beacon camera
% the camera also requires a telescope


% construct downlink beacon camera telescope
downlink_beacon_camera_telescope = components.Telescope(...
     0.4,                                             ... % telescope diameter (m)
    'Wavelength',         downlink_beacon.Wavelength, ...
    'Optical_Efficiency', 1,                          ... % telescope efficiency (1 is default)
    'Focal_Length',       2.72,                       ... % telescope focal length (m)
    'Pointing_Jitter',    1e-3);                          % rms pointing error (rad)
%% 
% again, we must provide some camera parameters link exposure time and spectral 
% filtering. once more it is simpler to use a sample camera object

downlink_beacon_camera = AC4040( ...
    downlink_beacon_camera_telescope, ...
    0.01,                             ... % exposure time (s)
    10);                                  % filter width in n, )
% 2.2.2 uplink beacon laser
% we can specify beam divergence manually (in rads) rather than approximate 
% it construct telescope. since in this example the telescope is the same as the 
% downlink beacon camera, we can modify the existing telescope

uplink_beacon_telescope = SetWavelength(downlink_beacon_camera_telescope, uplink_beacon_wavelength);

% construct beacon
uplink_beacon = beacon.Gaussian_Beacon( ...
    uplink_beacon_telescope,     ...
    40e-3,                       ... % power of uplink beacon (W)
    uplink_beacon_wavelength,    ...
    "Power_Efficiency",       1, ... % power efficiency of the uplink beacon optics
    "Pointing_Jitter",        1e-6); % rms pointing error of uplink beacon

% 2.3 construct a ground station
% constructing a ground station requires details of the background light around 
% it. this can be provided using a sky brightness store


%construct ground station
hogs = nodes.Ground_Station( ...
    OGS_telescope, ...
    'Detector',    detector,                   ...
    'Camera',      downlink_beacon_camera,     ...
    'Beacon',      uplink_beacon,              ...
    'LLA',         [55.909723, -3.319995, 10], ...
    'name',        'Heriot Watt');

%sky brightness store for the ground station
%sky_brightness = 'Example Data/orbit modelling resources/background count rate files/Errol_Experimental_Sky_Brightness_Store.mat';
loc = which("nodes.Satellite");
[path, ~, ~] = fileparts(loc);
elems = strsplit(path, filesep);
path_root = string(join(elems(1:end-2), filesep)) + filesep;
whichSeparator = @(Path, Sep) Sep{cellfun(@(sep) contains(Path, sep), Sep)};
MakePathNative = @(Path) strjoin(strsplit(Path, whichSeparator(Path, {'/', '\'})), filesep);
brightness_data = load(path_root + MakePathNative("Examples/Data/measured background counts/HWU_Experimental_Sky_Brightness.mat")).data;
sky_brightness = permute(brightness_data.Spectral_Pointance,[3,1,2]);


sky_elevations = linspace(0, 90, 46);
sky_headings = linspace(0, 360, 91);

mapped_night_sky = environment.mapToEnvironment( ...
    brightness_data.Headings, ...
    brightness_data.Elevations, ...
    sky_brightness, ... %780nm is at index 1
    sky_headings, ...
    sky_elevations, ...
    "Wavelength", brightness_data.Wavelengths);

loc = which('utilities.readModtranFile');
[path, ~, ~] = fileparts(loc);
elems = strsplit(path, filesep);
path_root = string(join(elems(1:end-1), filesep)) + filesep;
example_path = "Examples/Data/atmospheric transmittance/varying elevation MODTRAN data 2/";
data_path = path_root + MakePathNative(example_path);
paths = dir(data_path);
FilterStrings = @(haystack, needle) haystack(arrayfun(@(h) contains(h, needle), haystack));
csv_files = FilterStrings({paths.name}, ".csv");
disp(csv_files')
%% Preparing files
% The files in this directory following a naming scheme with the folling structure: 
% { data type, visibility, label, zenith label, zenith angle, _, .extensions }. 
% Since we want to read the data in from these files in order of their zenith 
% angles we will have to split their file names into these elements and then sort 
% the array according to zenith angles.

schema = {'data_type', 'visibility', 'visibility_label', 'zenith_label', 'zenith_angle', 'end'};
file_details = cellfun(@(f) cell2struct(split(f, "_"), schema), csv_files);
elevations = sort(str2double(replace({file_details.zenith_angle}, "deg", "")));
sorted_file_names = string( ...
    arrayfun( ...
        @(n) csv_files(contains(csv_files, "_" + num2str(n) + "deg")), ...
        elevations, ...
        UniformOutput=false)');
disp(sorted_file_names)
%% Extracting data
% With the files now in order we can read in the wavelength and transmission 
% data from each and construct a matrix for them. The _utilities.readModtranFile_ 
% function pull these columns from a typical MODTRAN file. The _environment.allSkyTransmission_ 
% function then allows us to convert the transmission data into a matrix with 
% dimensions 
%%
% 
%   [numel(headings), numel(elevations)]
%
%% 
% that we can the plot on polar axes.

wavelengths = [];
transmissions = [];
for f = sorted_file_names'
    [w, t] = utilities.readModtranFile(char(data_path + f));
    wavelengths = [wavelengths, w(~isnan(w))];
    transmissions = [transmissions, t(~isnan(t))];
end
[sky_transmission, headings] = environment.allSkyTransmission(transmissions, wavelengths(:, 1), elevations);
%% Filtering
% Since our files contain data for a range of wavelenths we can construct the 
% following lambda functions to find the correct slice of our transmission matrix 
% for a chosen wavelength.

Extrema = @(arr) [min(arr), max(arr)];
InRange = @(value, bounds) all([any(value >= bounds), any(value <= bounds)]);
Iota = @(x) linspace(0, x, x+1);
Take = @(arr, choices) arr(choices);
IndexOfWavelength = @(wvls, choice) Take(Iota(numel(wvls)), wvls == choice) * InRange(wvls, Extrema(wvls));
DataAtWavelength = @(data, wvls, choice) squeeze(data(IndexOfWavelength(wvls, choice), :, :));
% Picking an example wavelength of 600nm we can then plot the result.

tmp_size = [numel(brightness_data.Wavelengths), size(squeeze(sky_transmission(1, :, :)))];
transmission_at_wavelength = zeros(tmp_size);
for i = 1:numel(brightness_data.Wavelengths)
    wvl = brightness_data.Wavelengths(i);
     transmission_at_wavelength(i, :, :) = ...
         DataAtWavelength(sky_transmission, wavelengths(:, 1), wvl);
end

mapped_transmission = environment.mapToEnvironment( ...
    headings, ...
    elevations, ...
    transmission_at_wavelength, ...
    sky_headings, ...
    sky_elevations, ...
    "Wavelengths", brightness_data.Wavelengths);

Env = environment.Environment(sky_headings, sky_elevations, ...
    brightness_data.Wavelengths, mapped_night_sky, mapped_transmission);
%% 3 perform simulations
% simulations are run by using the *Simulation functions. the first argument 
% is the receiver and the second the transmitter. For QKD, the protocol can also 
% be selected

Protocol = protocol.decoyBB84();
result = nodes.QkdPassSimulation(hogs, spoqc, Protocol, Environment=Env);

beacon_result_down = beacon.beaconSimulation(hogs, spoqc, Environment=Env);
beacon_result_up = beacon.beaconSimulation(spoqc, hogs, Environment=Env);
%% plot results
% each simulation result object has a plotResult method which plots a standard 
% dashboard of results. Otherwise, results can be accessed from these objects 
% as read-only properties

QKD_figure = result.plotResult(hogs, spoqc, "mask", "Elevation");
beacon_down_figure = beacon_result_down.plot("mask", "Elevation");
beacon_up_figure = beacon_result_up.plot("mask", "Elevation");
