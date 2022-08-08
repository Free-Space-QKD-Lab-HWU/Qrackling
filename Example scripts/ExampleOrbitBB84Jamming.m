%% implement a simulation of a satellite in a 500km orbit over a ground station using the conventional BB84 protocol
%% First, we must construct the components of a simulation, this time including a jamming source.
%% Then we form them all into a single PassSimulation object.
%% Then we simulate the pass and plot the results.

%% 1. Choose parameters
Wavelength=780;                                                            %wavelength is measured in nm
Transmitter_Telescope_Diameter=0.1;                                        %diameters are measured in m
OrbitDataFileLocation='500kmSSOrbitLLAT.txt';                                %orbits are described by files containing latitude, longitude, altitude and time stamps. These are in the 'orbit modelling resources' folder
Receiver_Telescope_Diameter=1;                                           
Time_Gate_Width=1E-9;                                                      %times are measured in s
Spectral_Filter_Width=10;                                                  %consistemt with wavelength, spectral width is measured in nm

% extra parameters for jamming
Jamming_Diameter=1;
Jamming_Coordinates=[55.946466,-3.162452, 250];                            %coordintes of arthur's seat (lat, lon, alt)
Jamming_Power=1000;                                                        %power in W
Jamming_Spectral_Width=10;
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

%2.2.3 construct ground station, use Chilbolton as an example
SimGround_Station=Chilbolton_OGS(MPD_BB84_Detector,Receiver_Telescope);

%2.3 protocol
BB84_protocol=BB84_Protocol;

%2.4 jamming source
Jamming_Source=Jamming_Laser(Wavelength,Jamming_Diameter,Jamming_Coordinates,Jamming_Power,Jamming_Spectral_Width);

%% 3 Compose and run the PassSimulation
%3.1 compose passsimulation object
Pass=PassSimulation(SimSatellite,BB84_protocol,SimGround_Station,'Background_Sources',Jamming_Source);
%3.2 run simulation
Pass=Simulate(Pass);
%3.3 plot results
plot(Pass);