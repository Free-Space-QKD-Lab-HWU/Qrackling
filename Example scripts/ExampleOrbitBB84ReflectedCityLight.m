%% implement a simulation of a satellite in a 500km orbit over a ground station using the decoy BB84 protocol
%% First, we must construct the components of a simulation, this time including background light sources (which in this case are cities).
%% Then we form them all into a single PassSimulation object.
%% Then we simulate the pass and plot the results.

%% 1. Choose parameters
Wavelength=850;                                                            %wavelength is measured in nm
Transmitter_Telescope_Diameter=0.1;                                        %diameters are measured in m
OrbitDataFileLocation='100kmOrbitLLAT.txt';                                %orbits are described by files containing latitude, longitude, altitude and time stamps. These are in the 'orbit modelling resources' folder
Receiver_Telescope_Diameter=1;                                           
Time_Gate_Width=1E-9;                                                      %times are measured in s
Spectral_Filter_Width=10;                                                  %consistemt with wavelength, spectral width is measured in nm
%% 2. Construct components

%2.1 Satellite
%2.1.1 Source
Transmitter_Source=BB84_Source(Wavelength);                                %we use default values to simplify this example

%2.1.2 Transmitter telescope
Transmitter_Telescope=Telescope(Transmitter_Telescope_Diameter);           %do not need to specify wavelength as this will be set by satellite object

%2.1.3 Construct satellite
SimSatellite=Satellite(Transmitter_Source,Transmitter_Telescope,'OrbitDataFileLocation',OrbitDataFileLocation);

%2.2 Ground station
%2.2.1 Detector
MPD_BB84_Detector=MPD_Detector(Wavelength,Transmitter_Source.Repetition_Rate,Time_Gate_Width,Spectral_Filter_Width);
%need to provide repetition rate in order to compute QBER and loss due to
%time gating

%2.2.2 Receiver telescope
Receiver_Telescope=Telescope(Receiver_Telescope_Diameter);

%2.2.3 construct ground station, use Errol as an example
SimGround_Station=Errol_OGS(MPD_BB84_Detector,Receiver_Telescope);

%2.3 protocol
BB84_protocol=BB84_Protocol;

%2.4 background light cities
Cities_Struct=load("Light Reflection implementations\Cities.mat");
Cities=Cities_Struct.Cities;                                           %these are a set of cities whose light pollution has been estimated from the online light pollution map

%% 3 Compose and run the PassSimulation
%3.1 compose passsimulation object
Pass=PassSimulation(SimSatellite,BB84_protocol,SimGround_Station,'Background_Sources',Cities);
%3.2 run simulation
Pass=Simulate(Pass);
%3.3 plot results
plot(Pass);