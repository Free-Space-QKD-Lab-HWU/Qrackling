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
Transmitter_Source=components.Source(Wavelength,...
                          'Repetition_Rate',Repetition_Rate,...
                          'State_Probabilities',SPs);        %we use default values to simplify this example

%2.1.2 Transmitter telescope
Transmitter_Telescope=components.Telescope(Transmitter_Telescope_Diameter);           %do not need to specify wavelength as this will be set by satellite object

%2.1.3 Construct satellite
SimSatellite=nodes.Satellite(Transmitter_Telescope,...
                        'Source',Transmitter_Source,...
                        'OrbitDataFileLocation',OrbitDataFileLocation);

%2.2 Ground station
%2.2.1 Detector
Generic_COW_Detector=components.Detector(Wavelength,Transmitter_Source.Repetition_Rate,Time_Gate_Width,Spectral_Filter_Width,...
    'Preset',components.loadPreset("Excelitas"));
%TODO: need a detector object preset with visibility
%need to provide repetition rate in order to compute QBER and loss due to
%time gating
%NOTE only detectors with the 'Visibility' property can be used for COW

%2.2.2 Receiver telescope
Receiver_Telescope=components.Telescope(Receiver_Telescope_Diameter);

%2.2.3 construct ground station, use Heriot-Watt as an example
SimGround_Station=nodes.Ground_Station(Receiver_Telescope,...
                                'Detector',Detector,...
                                'LLA',[55.909723, -3.319995,10],...
                                'Name','Heriot-Watt');

%% 3 Compose and run the PassSimulation
%3.1 compose passsimulation object
Results = QkdPassSimulation(SimGround_Station,SimSatellite,"COW");
%3.2 plot results
plotResult(Results,SimGround_Station,SimSatellite);
