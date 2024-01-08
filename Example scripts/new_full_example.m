%% A full worked example of a satellite pass simulation
% there are 4 key steps to any simulation:
% 1. a transmitter  (here, a satellite)
% 2. a receiver     (here, a ground station)
% 3. run simulations
% 4. plot results


%% 1. construct a transmitter (satellite)
% to do this, we need lots of details about the satellite, including 
% 1.1 quantum transmitter details
% 1.2 beacon details (optional)
% 1.3 orbit details
% then we can:
% 1.4 construct satellite

% 1.1.1 source
% for details see
% "Design and test of optical payload for polarization encoded QKD for 
% Nanosatellites"
% by Sagar, Jaya, Hastings, Elliott, Zhang, Piede, Stefko, Milan, Lowndes, 
% David, Oi, Daniel, Rarity, John, Joshi, Siddarth K.
%--------------------------------------------------------------------------
% source wavelength (nm)
QKD_wavelength = 785;
% source mean photon numbers (unitless)
source_MPNs = [0.8,0.3,0];
% source state probabilities (unitless)
source_probs = [0.75,0.25,0.25];
% source pulse rate in Hz
source_rep_rate = 1E8;
% source g2 (unitless)
source_g2 = 0.01;
% source efficiency (unitless). 1 is the default
source_efficiency = 1;
% source state preparation error probability (unitless). this value is
% default
source_state_prep_error = 0.0025;
% create source
source = components.Source(QKD_wavelength,...
    'Mean_Photon_Number', source_MPNs,...
    'State_Probabilities', source_probs,...
    'Repetition_Rate', source_rep_rate,...
    'g2', source_g2,...
    'Efficiency', source_efficiency,...
    'State_Prep_Error', source_state_prep_error);

% 1.1.2 Telescope
% for details (and details of downlink beacon) see
% Quarc: Quantum research cubesat—a constellation for quantum communication
% Mazzarella, Luc, Lowe, Christopher, Lowndes, David, Joshi, Siddarth Koduru
% Greenland, Steve
% McNeil, Doug, Mercury, Cassandra, Macdonald, Malcolm, Rarity, John, Oi,
% Daniel Kuan Li
%--------------------------------------------------------------------------
% telescope diameter in m
scope_diameter = 0.08;
% telescope optical efficiency (unitless)
scope_efficiency = 1;
% telescope rms pointing error in rads
pointing_jitter = 1E-6;
% create telescope (also requires wavelength)
OGS_telescope = components.Telescope(scope_diameter,...
    'Wavelength', QKD_wavelength,...
    'Optical_Efficiency', scope_efficiency,...
    'Pointing_Jitter', pointing_jitter);



% 1.2.1 downlink beacon laser details
% see the above paper for beacon details. beacon simulations are optional
% and do not affect quantum channel performance (as pointing performance is
% specified by a jitter value)
%--------------------------------------------------------------------------
% beacon optical power in w
downlink_beacon_power = 2;
% beacon wavelength in nm
downlink_beacon_wavelength = 685;
% beacon optical efficiency (unitless)
downlink_beacon_efficiency = 1;
% beacon pointing precision (coarse pointing precision) in rads
% note that to make this calculation worst-case, this should be the
% open-loop pointing precision before acquisition
downlink_beacon_pointing_precision = 1E-3;
% beacon telescope diameter (m)
downlink_beacon_telescope_diameter = 0.01;
% beacon telescope field of view (rads)
downlink_beacon_telescope_fov = deg2rad(0.4);
% create a beacon telescope object
downlink_beacon_telescope = components.Telescope( ...
    downlink_beacon_telescope_diameter, ...
    'FOV', downlink_beacon_telescope_fov, ...
    'Wavelength', downlink_beacon_wavelength,...
    'Optical_Efficiency',downlink_beacon_efficiency,...
    'Pointing_Jitter',downlink_beacon_pointing_precision);
% then include this telescope in the beacon object. This uses a flat-top
% beacon profile but a gaussian beacon is also available
link_beacon = beacon.Flat_Top_Beacon(downlink_beacon_telescope, downlink_beacon_power, downlink_beacon_wavelength);

% 1.2.2 downlink beacon camera details
% the satellite requires a camera to image and track the uplink beacon
%--------------------------------------------------------------------------
% camera telescope diameter (m)
uplink_beacon_camera_scope_diameter = 0.08;
% camera telescope focal length (m)
uplink_beacon_camera_scope_focal_length = 0.86;
% camera telescope optical efficiency (1 is the default)
uplink_beacon_camera_scope_optical_efficiency = 1;
% camera pointing precision (this is likely tied to the satellite's body
% pointing precision)
uplink_beacon_camera_pointing_precision = 1E-3;
% wavelength of uplink beacon channel
uplink_beacon_wavelength = 850;
% create a telescope for the camera (in reality this is a focussing lens)
uplink_beacon_camera_telescope = components.Telescope(uplink_beacon_camera_scope_diameter,...
    'Wavelength', uplink_beacon_wavelength,...
    'Optical_Efficiency', uplink_beacon_camera_scope_optical_efficiency,...
    'Focal_Length', uplink_beacon_camera_scope_focal_length,...
    'Pointing_Jitter', uplink_beacon_camera_pointing_precision);
% camera exposure time in s
uplink_beacon_exposure_time = 0.001;
% spectral filter width in nm
uplink_beacon_camera_spectral_filter_width = 10;
% there are many properties to every camera, which determine SNR and
% efficiency. to avoid specifying these, we will load a camera
% implementation which is pre-packaged.
uplink_beacon_camera = CVM4000(uplink_beacon_camera_telescope, uplink_beacon_exposure_time, uplink_beacon_camera_spectral_filter_width);

% 1.3 orbit details
% there are many parameters which describe an orbit. we choose to use
% keplerian parameters. as well as these, we must also provide a time
% window to simulate (ideally, the satellite would pass the ground station
% in this time)
%--------------------------------------------------------------------------
% orbital parameters- these conform to the MATLAB satellite communications
% toolbox keplerian set of orbital parameters

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
start_time = pass_time - duration/2;
stop_time = pass_time + duration/2;

% 1.4 construct satellite
spoqc = nodes.Satellite(OGS_telescope,...
    'Name', 'SPOQC',...
    'Source', source,...
    'Beacon', link_beacon,...
    'Camera', uplink_beacon_camera,...
    'SemiMajorAxis', semimajor_axis,...
    'eccentricity', eccentricity,...
    'inclination', inclination,...
    'rightAscensionOfAscendingNode', right_ascension_of_ascending_node,...
    'argumentOfPeriapsis', argument_of_periapsis,...
    'trueAnomaly', true_anomaly,...
    'StartTime', start_time,...                           %start of simulation
    'StopTime', stop_time,...                             %end of simulation
    'sampleTime', sample_time);                           %simulation interval in s


%% 2. construct a receiver (ground station)
% to do this, we need lots of details about the ground station
% 2.1 quantum receiver details
% 2.2 beacon details (optional)
% 2.3 location details
% then we can:
% 2.4 construct ground station

% 2.1 quantum receiver details
% the quantum receiver comprises a telescope and a detector. the detector
% also requires a spectral filter

% 2.1.1 telescope
% the ground station telescope is likely to be much larger than the satellite's, but
% is constructed in the same way
%--------------------------------------------------------------------------
% ground station telescope diameter (m)
OGS_telescope_diameter = 0.7;
% ground station telescope focal length (m)
OGS_telescope_focal_length = 8.4;
% ground station telescope eye piece focal length (m)
OGS_telescope_eyepiece_focal_length = 0.076;
% ground station optical efficiency (1 is the default)
OGS_optical_efficiency = 1;
% ground station rms pointing error (rads)(after beacon)
OGS_telescope_pointing_jitter = 1E-6;
% construct a telescope
OGS_telescope = components.Telescope( ...
    OGS_telescope_diameter, ...
    'Pointing_Jitter', OGS_telescope_pointing_jitter,...
    'Optical_Efficiency', OGS_optical_efficiency,...
    'Focal_Length', OGS_telescope_focal_length,...
    'Eyepiece_Focal_Length', OGS_telescope_eyepiece_focal_length);

% 2.1.2 spectral filter
% the spectral filter provides details of how noise is filtered out at the
% receiver
%--------------------------------------------------------------------------
% provide a file which describes filter spectral performance. an example is
% given here. nativePathFrom provides path conversion for different OSs
filter_file = utilities.nativePathFrom('Example Data/spectral filters/FBH780-10.xlsx');
spectral_filter = SpectralFilter('input_file', filter_file);
% alternatively, a dummy spectral filter can be created which has a
% brick-wall spectral response using
% spectral_filter = IdeadBPFilter(centre_wavelength, spectral_width)

% 2.1.3 detector
% we provide details of some preset detectors. custom detectors can also be
% instantiated by providing their details. As well as performance data, the
% detector requires channel information to compute QBER.
%--------------------------------------------------------------------------
% time gate width in s
time_gate = 2E-9;
% we also need wavelength and repetition rate, which have both already been
% declared
% construct detector
detector = components.Detector(QKD_wavelength, source_rep_rate, ...
    time_gate, spectral_filter, ...
    "Preset", components.loadPreset("Excelitas") );

% 2.2 beacon details
% we need to provide the other end of both beacon links. an uplink beacon
% laser and a downlink beacon camera

% 2.2.1 downlink beacon camera
% the camera also requires a telescope
%--------------------------------------------------------------------------
% downlink beacon camera telescope diameter (m)
downlink_beacon_camera_telescope_diameter = 0.4;
% downlink beacon camera telescope efficiency (1 is default)
downlink_beacon_camera_telescope_efficiency = 1;
% downlink beacon camera telescope focal length (m)
downlink_beacon_camera_telescope_focal_length = 2.72;
% downlink beacon camera rms pointing error (rad)
downlink_beacon_camera_pointing_jitter = 1E-3;
% construct downlink beacon camera telescope
downlink_beacon_camera_telescope = components.Telescope(...
     downlink_beacon_camera_telescope_diameter, ...
    'Wavelength', downlink_beacon_wavelength, ...
    'Optical_Efficiency', downlink_beacon_camera_telescope_efficiency, ...
    'Focal_Length', downlink_beacon_camera_telescope_focal_length, ...
    'Pointing_Jitter', downlink_beacon_camera_pointing_jitter);
% again, we must provide some camera parameters link exposure time and
% spectral filtering. once more it is simpler to use a sample camera object
% exposure time (s)
downlink_beacon_camera_exposure_time = 0.01;
downlink_beacon_camera_spectral_filter_width = 10;
uplink_beacon_camera = AC4040(downlink_beacon_camera_telescope,...
                              downlink_beacon_camera_exposure_time,...
                              downlink_beacon_camera_spectral_filter_width);

% 2.2.2 uplink beacon laser
%--------------------------------------------------------------------------
% power of uplink beacon (W)
uplink_beacon_power = 40E-3;
% we can specify beam divergence manually (in rads) rather than approximate
% it
uplink_beacon_divergence = 0.007;
% construct telescope. since in this example the telescope is the same as
% the downlink beacon camera, we can modify the existing telescope
uplink_beacon_telescope = SetWavelength(downlink_beacon_camera_telescope,uplink_beacon_wavelength);
uplink_beacon_telescope = SetFOV(uplink_beacon_telescope,uplink_beacon_divergence);
% construct beacon
uplink_beacon = beacon.Gaussian_Beacon( ...
                    downlink_beacon_telescope, ...
                    uplink_beacon_power, ...
                    uplink_beacon_wavelength,...
                    "Power_Efficiency", downlink_beacon_efficiency, ...
                    "Pointing_Jitter", downlink_beacon_pointing_precision);
% 2.3 construct a ground station
%constructing a ground station requires details of the background light
%around it. this can be provided using a sky brightness store
%--------------------------------------------------------------------------
%sky brightness store for the ground station
sky_brightness = 'Example Data/orbit modelling resources/background count rate files/Errol_Experimental_Sky_Brightness_Store.mat';
sky_brightness = utilities.nativePathFrom(sky_brightness);
%construct ground station
hogs = nodes.Ground_Station(OGS_telescope,...
    'Detector', detector,...
    'Camera', uplink_beacon_camera, ...
    'Beacon', uplink_beacon, ...
    'Sky_Brightness_Store_Location', sky_brightness, ...
    'LLA', [55.909723, -3.319995,10],...
    'name', 'Heriot Watt');


%% 3 perform simulations
%simulations are run by using the *Simulation functions. the first argument
%is the receiver and the second the transmitter. For QKD, the protocol ca n
%also be selected
result = nodes.QkdPassSimulation(hogs, spoqc, "DecoyBB84");
beacon_result_down = beacon.beaconSimulation(hogs, spoqc);
beacon_result_up = beacon.beaconSimulation(spoqc, hogs);

%% plot results
% each simulation result object has a plotResult method which plots a
% standard dashboard of results. Otherwise, results can be accessed from
% these objects as read-only properties

QKD_figure = result.plotResult(hogs, spoqc, "mask", "Elevation");
beacon_down_figure = beacon_result_down.plot("mask", "Elevation");
beacon_up_figure = beacon_result_up.plot("mask", "Elevation");
