%% implement a simulation of a satellite in a 100km orbit over a ground station using the conventional BB84 protocol
%% First, we must construct the components of a simulation. Then we form them all into a single PassSimulation object.
%% Then we simulate the pass and plot the results. In this simulation, the uplink configuration is used

%% 1. Choose parameters
Wavelength=650;                                                            %wavelength is measured in nm
Transmitter_Telescope_Diameter=0.1;                                        %diameters are measured in m
OrbitDataFileLocation='500kmSSOrbitLLAT.txt';                              %orbits are described by files containing latitude, longitude, altitude and time stamps. These are in the 'orbit modelling resources' folder
Receiver_Telescope_Diameter=1;                                           
Time_Gate_Width=1E-9;                                                      %times are measured in s
Spectral_Filter_Width=10;                                                  %consistent with wavelength, spectral width is measured in nm
Repetition_Rate = 1E8;                                                     %source rep rate in Hz
%% 2. Construct components

%2.1 Satellite
%2.1.1 Detector
MPD_BB84_Detector=MPD_Detector(Wavelength,Repetition_Rate,Time_Gate_Width,Spectral_Filter_Width);

%2.1.2 Transmitter telescope
Transmitter_Telescope=Telescope(Transmitter_Telescope_Diameter);           %do not need to specify wavelength as this will be set by satellite object

%2.1.3 Construct satellite
SimSatellite=Satellite(Transmitter_Telescope,...
                        'Detector', MPD_BB84_Detector,...
                        'OrbitDataFileLocation',OrbitDataFileLocation);

%2.2 Ground station
%2.2.1 Source
Transmitter_Source=Source(Wavelength,'Repetition_Rate',Repetition_Rate);                %we use default values to simplify this example

%need to provide repetition rate in order to compute QBER and loss due to
%time gating

%2.2.2 Receiver telescope
Receiver_Telescope=Telescope(Receiver_Telescope_Diameter);

%2.2.3 construct ground station, use Errol as an example
SimGround_Station=Errol_OGS(Receiver_Telescope,...
                            'Source',Transmitter_Source);

%2.3 protocol
BB84_protocol=Protocol(qkd_protocols.BB84);

%% 3 Compose and run the PassSimulation
%3.1 compose passsimulation object
Pass=PassSimulation(SimGround_Station,BB84_protocol,SimSatellite);
%3.2 run simulation
Pass=Simulate(Pass);
%3.3 plot results
plot(Pass);
