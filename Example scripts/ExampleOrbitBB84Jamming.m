%% implement a simulation of a satellite in a 500km orbit over a ground station using the conventional BB84 protocol
%% First, we must construct the components of a simulation, this time including a jamming source.
%% Then we form them all into a single PassSimulation object.
%% Then we simulate the pass and plot the results.

%% 1. Choose parameters
Wavelength=600;                                                                 %wavelength is measured in nm
Transmitter_Telescope_Diameter=0.1;                                             %diameters are measured in m
OrbitDataFileLocation='500kmSSOrbitLLAT.txt';                                   %orbits are described by files containing latitude, longitude, altitude and time stamps. These are in the 'orbit modelling resources' folder
Receiver_Telescope_Diameter=1;                                           
Time_Gate_Width=1E-10;                                                           %times are measured in s
Spectral_Filter_Width=1;                                                       %consistemt with wavelength, spectral width is measured in nm
Repetition_Rate = 1E8;                                                          %repetition rate in Hz

% extra parameters for jamming
Jamming_Diameter=0.1;
Jamming_Coordinates=[33,-6, 100];                                               %coordintes of jammer (lat lon alt)
Jamming_Power=1;                                                                %power in W
Jamming_Spectral_Width=10;
%% 2. Construct components

%2.1 Satellite
%2.1.1 Source
Transmitter_Source=Source(Wavelength,...
                          'Repetition_Rate',Repetition_Rate);                   %we use default values to simplify this example

%2.1.2 Transmitter telescope
Transmitter_Telescope=Telescope(Transmitter_Telescope_Diameter);           %do not need to specify wavelength as this will be set by satellite object

%2.1.3 Construct satellite
SimSatellite=Satellite(Transmitter_Telescope,...
    'OrbitDataFileLocation',OrbitDataFileLocation,...
    'Surface',Black_Anodised_Aluminium(4),...
    'Source',Transmitter_Source);

%2.2 Ground station
%2.2.1 Detector
MPD_BB84_Detector=MPD_Detector(Wavelength,Transmitter_Source.Repetition_Rate,Time_Gate_Width,Spectral_Filter_Width);
%need to provide repetition rate in order to compute QBER and loss due to
%time gating

%2.2.2 Receiver telescope
Receiver_Telescope=Telescope(Receiver_Telescope_Diameter);

%2.2.3 construct ground station, use Errol as an example
SimGround_Station=Errol_OGS(Receiver_Telescope,'Detector',MPD_BB84_Detector);

%2.3 protocol
BB84_protocol=Protocol.BB84;

%2.4 jamming source
Jamming_Source=Jamming_Laser(Wavelength,Jamming_Diameter,Jamming_Coordinates,Jamming_Power,Jamming_Spectral_Width);

%% 3 Compose and run the PassSimulation
%3.1 compose passsimulation object
Pass=PassSimulation(SimSatellite,BB84_protocol,SimGround_Station,'Background_Sources',Jamming_Source);
%3.2 run simulation
Pass=Simulate(Pass);
%3.3 plot results
plot(Pass);
