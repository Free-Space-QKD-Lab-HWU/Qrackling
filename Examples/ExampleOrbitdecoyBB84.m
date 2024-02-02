% a simulation of a decoy BB84 satellite pass

%% 1. Choose parameters
Wavelength=780;                                                            %wavelength is measured in nm
Transmitter_Telescope_Diameter=0.1;                                        %diameters are measured in m
OrbitDataFileLocation='500kmSSOrbitLLAT.txt';                              %orbits are described by files containing latitude, longitude, altitude and time stamps. These are in the 'orbit modelling resources' folder
Receiver_Telescope_Diameter=1;                                           
Time_Gate_Width=1E-9;                                                      %times are measured in s
Spectral_Filter_Width=10;                                                  %consistemt with wavelength, spectral width is measured in nm
MPNs = [0.7,0.1,0];                                                        %mean photon numbers
SPs = [0.75,0.25,0.25];                                                    %state probabilities

%% 2. Construct components
%2.1 Satellite
%2.1.1 Source
Transmitter_Source=components.Source(Wavelength,...
                          'Mean_Photon_Number',MPNs,...
                          'State_Probabilities',SPs);                                       %we use default values to simplify this example

%2.1.2 Transmitter telescope
Transmitter_Telescope=components.Telescope(Transmitter_Telescope_Diameter);           %do not need to specify wavelength as this will be set by satellite object

%2.1.3 Construct satellite
SimSatellite=nodes.Satellite(Transmitter_Telescope,...
    'OrbitDataFileLocation',OrbitDataFileLocation,...
    'Source',Transmitter_Source);

%2.2 Ground station
%2.2.1 Detector
Detector=components.Detector(Wavelength,Transmitter_Source.Repetition_Rate,Time_Gate_Width,Spectral_Filter_Width,'Preset',components.loadPreset("Excelitas"));
%need to provide repetition rate in order to compute QBER and loss due to
%time gating

%2.2.2 Receiver telescope
Receiver_Telescope=components.Telescope(Receiver_Telescope_Diameter,'Wavelength',Wavelength);

%2.2.3 construct ground station, use Heriot-Watt as an example
SimGround_Station=nodes.Ground_Station(Receiver_Telescope,...
                                'Detector',Detector,...
                                'LLA',[55.909723, -3.319995,10],...
                                'Name','Heriot-Watt');

%% 3 run and plot simulation
%3.1 run simulation
Result=nodes.QkdPassSimulation(SimGround_Station,SimSatellite,"DecoyBB84");
%3.2 plot results
plotResult(Result,SimGround_Station,SimSatellite)
