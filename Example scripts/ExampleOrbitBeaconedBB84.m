%% implement a simulation of a satellite in a 100km orbit over a ground station using the conventional BB84 protocol
%% with the presence of a simulated beacon
%% First, we must construct the components of a simulation. Then we form them all into a single PassSimulation object.
%% Then we simulate the pass and plot the results.

%% 1. Choose parameters
Wavelength=850;                                                            %wavelength is measured in nm
Transmitter_Telescope_Diameter=0.1;                                        %diameters are measured in m
OrbitDataFileLocation='100kmSSOrbitLLAT.txt';                                %orbits are described by files containing latitude, longitude, altitude and time stamps. These are in the 'orbit modelling resources' folder
Receiver_Telescope_Diameter=1;                                           
Time_Gate_Width=1E-9;                                                      %times are measured in s
Spectral_Filter_Width=10;                                                  %consistemt with wavelength, spectral width is measured in nm

Beacon_Power = 3;                                                           %beacon power in W
Beacon_Wavelength = 650;                                                    %beacon wavelength in nm
Beacon_Divergence_Half_Angle = 1E-3;                                        %gaussian beacon divergence half angle
Camera_Collecting_Area = (pi/4)*0.25^2;                                     %collecting area of the beacon camera used (m^2)
%% 2. Construct components

%2.1 Satellite
%2.1.1 Source
Transmitter_Source=Source(Wavelength);                                       %we use default values to simplify this example

%2.1.2 Transmitter telescope
Transmitter_Telescope=Telescope(Transmitter_Telescope_Diameter);           %do not need to specify wavelength as this will be set by satellite object

%2.1.3 Satellite downlink beacon
Beacon = Gaussian_Beacon(Beacon_Power,Beacon_Wavelength,Beacon_Divergence_Half_Angle);

%2.1.4 Construct satellite
SimSatellite=Satellite(Transmitter_Source,Transmitter_Telescope,...
                        'OrbitDataFileLocation',OrbitDataFileLocation,...
                        'Beacon',Beacon);

%2.2 Ground station
%2.2.1 Detector
MPD_BB84_Detector=MPD_Detector(Wavelength,Transmitter_Source.Repetition_Rate,Time_Gate_Width,Spectral_Filter_Width);
%need to provide repetition rate in order to compute QBER and loss due to
%time gating

%2.2.2 Receiver telescope
Receiver_Telescope=Telescope(Receiver_Telescope_Diameter);

%2.2.3 add a beacon camera to the ground station
Cam = Camera(Camera_Collecting_Area);

%2.2.4 construct ground station, use Errol as an example
SimGround_Station=Errol_OGS(MPD_BB84_Detector,Receiver_Telescope,...
                            'Camera',Cam);

%2.3 protocol
BB84_protocol=BB84_Protocol;

%% 3 Compose and run the PassSimulation
%3.1 compose passsimulation object
Pass=PassSimulation(SimSatellite,BB84_protocol,SimGround_Station);
%3.2 run simulation
Pass=Simulate(Pass);
%3.3 plot results
plot(Pass);