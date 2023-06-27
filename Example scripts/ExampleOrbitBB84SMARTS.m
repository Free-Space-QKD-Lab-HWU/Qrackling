%% implement a simulation of a satellite in a 100km orbit over a ground station using the conventional BB84 protocol
%% First, we must construct the components of a simulation. Then we form them all into a single PassSimulation object.
%% Then we simulate the pass and plot the results.


%% THIS EXAMPLE CURRENTLY DOES NOT WORK DUE TO SMARTS INTEGRATION PROBLEMS


%% 1. Choose parameters
Wavelength=600;                                                            %wavelength is measured in nm
Transmitter_Telescope_Diameter=0.1;                                        %diameters are measured in m
OrbitDataFileLocation='100kmSSOrbitLLAT.txt';                              %orbits are described by files containing latitude, longitude, altitude and time stamps. These are in the 'orbit modelling resources' folder
Receiver_Telescope_Diameter=1;                                           
Time_Gate_Width=1E-9;                                                      %times are measured in s
Spectral_Filter_Width=1;                                                %consistemt with wavelength, spectral width is measured in nm
Repetition_Rate = 100E6;                                                   %source repetition rate in Hz
%% 2. Construct components

%2.1 Satellite
%2.1.1 Source
Transmitter_Source=Source(Wavelength,'Repetition_Rate',Repetition_Rate);        %we use default values to simplify this example

%2.1.2 Transmitter telescope
Transmitter_Telescope=Telescope(Transmitter_Telescope_Diameter);           %do not need to specify wavelength as this will be set by satellite object

%2.1.3 Construct satellite
SimSatellite=Satellite(Transmitter_Telescope,'OrbitDataFileLocation',OrbitDataFileLocation,...
                            'Source',Transmitter_Source);

%2.2 Ground station
%2.2.1 Detector
MPD_BB84_Detector=Detector(Wavelength,Transmitter_Source.Repetition_Rate,Time_Gate_Width,Spectral_Filter_Width,'Preset',DetectorPresets.MicroPhotonDevices.LoadPreset());
%need to provide repetition rate in order to compute QBER and loss due to
%time gating

%2.2.2 Receiver telescope
Receiver_Telescope=Telescope(Receiver_Telescope_Diameter);

%2.2.3 construct ground station, use Errol as an example
SimGround_Station=Errol_OGS(Receiver_Telescope,...
                                'Detector',MPD_BB84_Detector);

%2.3 protocol
BB84_protocol=Protocol.BB84;

%2.4 SMARTS atmospheric modelling config
SMARTS_Config = solar_background_errol_fast('executable_path','C:\Git\SMARTS\','stub','C:\Git\QKD_Sat_Link\SMARTS_connection\SMARTS cache\');

%% 3 Compose and run the PassSimulation
%3.1 compose passsimulation object
Pass=PassSimulation(SimSatellite,BB84_protocol,SimGround_Station,'SMARTS',SMARTS_Config);
%3.2 run simulation
Pass=Simulate(Pass);
%3.3 plot results
plot(Pass);
