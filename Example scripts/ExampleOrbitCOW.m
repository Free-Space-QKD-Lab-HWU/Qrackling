%% implement a simulation of a satellite in a 500km sun synchronous orbit over a ground station using the COW protocol
%% First, we must construct the components of a simulation. Then we form them all into a single PassSimulation object.
%% Then we simulate the pass and plot the results.

%% 1. Choose parameters
Wavelength=780;                                                            %wavelength is measured in nm
Transmitter_Telescope_Diameter=0.1;                                        %diameters are measured in m
OrbitDataFileLocation='500kmSSOrbitLLAT.txt';                              %orbits are described by files containing latitude, longitude, altitude and time stamps. These are in the 'orbit modelling resources' folder
Receiver_Telescope_Diameter=1;                                           
Time_Gate_Width=1E-10;                                                      %times are measured in s
Spectral_Filter_Width=1;                                                  %consistemt with wavelength, spectral width is measured in nm
Repetition_Rate = 1E8;  
SPs = [0.9,0.1];
%% 2. Construct components

%2.1 Satellite
%2.1.1 Source
Transmitter_Source=Source(Wavelength,...
                          'Repetition_Rate',Repetition_Rate,...
                          'State_Probabilities',SPs);        %we use default values to simplify this example

%2.1.2 Transmitter telescope
Transmitter_Telescope=Telescope(Transmitter_Telescope_Diameter);           %do not need to specify wavelength as this will be set by satellite object

%2.1.3 Construct satellite
SimSatellite=Satellite(Transmitter_Telescope,...
                        'Source',Transmitter_Source,...
                        'OrbitDataFileLocation',OrbitDataFileLocation);

%2.2 Ground station
%2.2.1 Detector
Generic_COW_Detector=Detector(Wavelength,Transmitter_Source.Repetition_Rate,Time_Gate_Width,Spectral_Filter_Width,...
    Preset=DetectorPresets.MicroPhotonDevices.LoadPreset());
%need to provide repetition rate in order to compute QBER and loss due to
%time gating
%NOTE only detectors with the 'Visibility' property can be used for COW

%2.2.2 Receiver telescope
Receiver_Telescope=Telescope(Receiver_Telescope_Diameter);

%2.2.3 construct ground station, use Chilbolton as an example
SimGround_Station=Chilbolton_OGS(Receiver_Telescope,...
                                    'Detector',Generic_COW_Detector);

%2.3 protocol
COW_protocol=Protocol.COW;

%% 3 Compose and run the PassSimulation
%3.1 compose passsimulation object
Pass=PassSimulation(SimSatellite,COW_protocol,SimGround_Station);
%3.2 run simulation
Pass=Simulate(Pass);
%3.3 plot results
plot(Pass);
