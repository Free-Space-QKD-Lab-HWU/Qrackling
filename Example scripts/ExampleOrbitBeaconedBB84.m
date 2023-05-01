%% implement a simulation of a satellite in a 100km orbit over a ground station using the conventional BB84 protocol
%% with the presence of a simulated beacon
%% First, we must construct the components of a simulation. Then we form them all into a single PassSimulation object.
%% Then we simulate the pass and plot the results.

%% 1. Choose parameters
Wavelength=850;                                                            %wavelength is measured in nm
Transmitter_Telescope_Diameter=0.1;                                        %diameters are measured in m
OrbitDataFileLocation='500kmSSOrbitLLAT.txt';                                %orbits are described by files containing latitude, longitude, altitude and time stamps. These are in the 'orbit modelling resources' folder
Receiver_Telescope_Diameter=1;                                           
Time_Gate_Width=1E-9;                                                      %times are measured in s
Spectral_Filter_Width=10;                                                  %consistemt with wavelength, spectral width is measured in nm

Beacon_Power = 1;                                                           %beacon power in W
Beacon_Wavelength = 650;                                                    %beacon wavelength in nm
OGS_Camera_Scope_Diameter = 0.1;                                                %camera telescope diameter in m
%% 2. Construct components

%2.1 Satellite
%2.1.1 Source
Transmitter_Source=Source(Wavelength);                                       %we use default values to simplify this example

%2.1.2 Transmitter telescope
Transmitter_Telescope=Telescope(Transmitter_Telescope_Diameter);           %do not need to specify wavelength as this will be set by satellite object

%2.1.3 Satellite downlink beacon
Downlink_Beacon = Gaussian_Beacon(Transmitter_Telescope,Beacon_Power,Beacon_Wavelength);

%2.1.4 add a beacon camera to the satellite
Uplink_Cam = Camera(Transmitter_Telescope);

%2.1.5 Construct satellite
SimSatellite=Satellite(Transmitter_Telescope,...
                        'OrbitDataFileLocation',OrbitDataFileLocation,...
                        'Source',Transmitter_Source,...
                        'Beacon',Downlink_Beacon,...
                        'Camera',Uplink_Cam);

%2.2 Ground station
%2.2.1 Detector
MPD_BB84_Detector=MPD_Detector(Wavelength,Transmitter_Source.Repetition_Rate,Time_Gate_Width,Spectral_Filter_Width);
%need to provide repetition rate in order to compute QBER and loss due to
%time gating

%2.2.2 Receiver telescope
Receiver_Telescope=Telescope(Receiver_Telescope_Diameter);

%2.2.3 add a beacon camera to the ground station
Downlink_Camera_Scope = Telescope(OGS_Camera_Scope_Diameter,'Wavelength',Beacon_Wavelength);
Downlink_Cam = Camera(Downlink_Camera_Scope);

%2.2.4 Ground station uplink beacon
Uplink_Beacon = Gaussian_Beacon(Receiver_Telescope,Beacon_Power,Beacon_Wavelength);

%2.2.5 construct ground station, use Errol as an example
SimGround_Station=Errol_OGS(Receiver_Telescope,...
                            'Detector',MPD_BB84_Detector,...
                            'Camera',Downlink_Cam,...
                            'Beacon',Uplink_Beacon);

%2.3 protocol
BB84_protocol=Protocol(qkd_protocols.BB84);

%2.4 SMARTS atmospheric modelling config
SMARTS_Config = solar_background_errol_fast('executable_path','C:\Git\SMARTS\','stub','C:\Git\QKD_Sat_Link\SMARTS_connection\SMARTS cache\');

%% 3 Compose and run the PassSimulation
%3.1 compose passsimulation object
Pass=PassSimulation(SimSatellite,BB84_protocol,SimGround_Station,'SMARTS',SMARTS_Config,'Visibility','20km');

%3.2 run simulation
Pass=Simulate(Pass);
%3.3 plot results
plot(Pass);
