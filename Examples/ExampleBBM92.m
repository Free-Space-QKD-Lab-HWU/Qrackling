% A simulation of a BBM92 based pass.
% Here, a 100km orbit is used

%% 1. Choose parameters
% wavelength is measured in nm
Wavelength = 780;

% diameters are measured in m
Transmitter_Telescope_Diameter = 0.1;

% orbits are described by files containing latitude, longitude, altitude and
% time stamps. These are in the 'orbit modelling resources' folder
OrbitDataFileLocation = '100kmSSOrbitLLAT.txt';

Receiver_Telescope_Diameter = 1;

% times are measured in s
Time_Gate_Width = 1E-9;

% consistent with wavelength, spectral width is measured in nm
Spectral_Filter_Width = 10;


%% 2. Construct components

%2.1.1 Source
Transmitter_Source = components.Source( ...
    Wavelength,...
   'Repetition_Rate', 1E8,...
   'MPN_Signal', 0.1); % we use default values to simplify this example

%2.1.2 Detector
% Need to provide repetition rate in order to compute QBER and loss due to
% time gating
Detector = components.Detector( ...
    Wavelength,...
    Transmitter_Source.Repetition_Rate,...
    Time_Gate_Width,...
    Spectral_Filter_Width,...
    'Preset', components.loadPreset("PerkinElmer"));

%2.1.3 Transmitter telescope
% Do not need to specify wavelength as this will be set by satellite object
Transmitter_Telescope = components.Telescope(Transmitter_Telescope_Diameter);

%2.1.4 Receiver telescope
Receiver_Telescope = components.Telescope( ...
    Receiver_Telescope_Diameter, ...
    'FOV', 10E-6,...
    'Wavelength', Wavelength);

%2.2.1 Construct satellite
SimSatellite=nodes.Satellite( ...
    Transmitter_Telescope, ...
    'Source', Transmitter_Source,...
    'Detector', Detector, ...
    'OrbitDataFileLocation', OrbitDataFileLocation);

%2.2.2 construct ground station, use Heriot-Watt as an example
SimGround_Station=nodes.Ground_Station( ...
    Receiver_Telescope,...
    'Detector', Detector,...
    'LLA', [55.909723, -3.319995,10],...
    'Name', 'Heriot-Watt');


%% 3 run and plot simulation

%3.1 run simulation
Result = nodes.QkdPassSimulation(SimGround_Station, SimSatellite, protocol.bbm92);

%3.2 plot results
Result.plot()
