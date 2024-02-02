%a simulation in which a pass is reflectively jammed

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
Transmitter_Source=components.Source(Wavelength,...
                          'Repetition_Rate',Repetition_Rate);                   %we use default values to simplify this example

%2.1.2 Transmitter telescope
Transmitter_Telescope=components.Telescope(Transmitter_Telescope_Diameter);           %do not need to specify wavelength as this will be set by satellite object

%2.1.3 Construct satellite
SimSatellite=nodes.Satellite(Transmitter_Telescope,...
    'OrbitDataFileLocation',OrbitDataFileLocation,...
    'Surface',Black_Anodised_Aluminium(4),...
    'Source',Transmitter_Source);

%2.2 Ground station
%2.2.1 Detector
Detector=components.Detector(Wavelength,Transmitter_Source.Repetition_Rate,Time_Gate_Width,Spectral_Filter_Width,'Preset',components.loadPreset("MicroPhotonDevices"));
%need to provide repetition rate in order to compute QBER and loss due to
%time gating

%2.2.2 Receiver telescope
Receiver_Telescope=components.Telescope(Receiver_Telescope_Diameter);

%2.2.3 construct ground station, use Heriot-Watt as an example
SimGround_Station=nodes.Ground_Station(Receiver_Telescope,...
                                'Detector',Detector,...
                                'LLA',[55.909723, -3.319995,10],...
                                'Name','Heriot-Watt');

%2.4 jamming source
Jamming_Source=Jamming_Laser(Wavelength,Jamming_Diameter,Jamming_Coordinates,Jamming_Power,Jamming_Spectral_Width);

%% 3 run and plot simulation
%3.1 run simulation
Result=nodes.QkdPassSimulation(SimGround_Station,SimSatellite,"BB84",'Background_Sources',Jamming_Source);
%3.2 plot results
plotResult(Result,SimGround_Station,SimSatellite)