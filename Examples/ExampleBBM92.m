% A simulation of a BBM92 based pass.
% Here, a 100km orbit is used


%% 1. Construct components

%1.1.1 Source
Transmitter_Source = components.Source( ...
    780,... %emission wavelength in nm
   'Repetition_Rate', 1E8,... %overriding default repetition rate in Hz
   'MPN_Signal', 0.1); %overriding default MPN

%1.1.2 Detector
% Need to provide repetition rate in order to compute QBER and loss due to
% time gating
Detector = components.Detector( ...
    Transmitter_Source.Wavelength,... %need to specify wavelength in nm for efficiency calculation
    Transmitter_Source.Repetition_Rate,... %need to provide rep rate so that jitter can be calculated
    1E-9,... %Time gate width of detector in s
    10,... % spectral filter width applied to detector (can also replace with more complex Spectral_Filter object)
    'Preset', 'PerkinElmer'); %using Perkin Elmer preset for jitter and efficiency graphs

%1.1.3 Transmitter telescope
Transmitter_Telescope = components.Telescope(0.1); % diameter of telescope in m
%using default 1urad for pointing jtter and calculating diffraction-limited FOV 

%1.1.4 Receiver telescope
Receiver_Telescope = components.Telescope( ...
    1, ... %diameter of telescope in m
    'FOV', 10E-6,... %choosing to specify FOV here. pointing error is 1urad by default
    'Wavelength', Transmitter_Source.Wavelength); %specifying FOV requires specifying wavelength

%1.2.1 Construct satellite
SimSatellite=nodes.Satellite( ...
    Transmitter_Telescope, ...
    'Source', Transmitter_Source,...
    'Detector', Detector, ... %the transmitter satellite needs an on-detector for the BBM92 protocol
    'OrbitDataFileLocation', '100kmSSOrbitLLAT.txt'); %specifying a preset orbit to avoid having to faff with keplerian orbital description

%1.2.2 construct ground station, use Heriot-Watt as an example
SimGround_Station=nodes.Ground_Station( ...
    Receiver_Telescope,...
    'Detector', Detector,...
    'LLA', [55.909723, -3.319995,10],...
    'Name', 'Heriot-Watt');


%% 2 run and plot simulation
%2.1 run simulation
Result = nodes.QkdPassSimulation(SimGround_Station, SimSatellite, protocol.bbm92);

%2.2 plot results
Result.plot()
