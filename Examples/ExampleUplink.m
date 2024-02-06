% a simulation of a decoy BB84 uplink to a satellite

%% 1. Choose parameters
Wavelength=850;                                                            %wavelength is measured in nm
Transmitter_Telescope_Diameter=1;                                        %diameters are measured in m
OrbitDataFileLocation='500kmSSOrbitLLAT.txt';                              %orbits are described by files containing latitude, longitude, altitude and time stamps. These are in the 'orbit modelling resources' folder
Receiver_Telescope_Diameter=0.2;                                           
Time_Gate_Width=1E-9;                                                      %times are measured in s
Spectral_Filter_Width=10;                                                  %consistent with wavelength, spectral width is measured in nm
Repetition_Rate = 1E8;                                                     %source rep rate in Hz
MPNs = [0.7,0.3,0];                                                        %mean photon number (signal, decoy, vacuum)
SPs = [0.75,0.15,0.1];                                                     %state probabilities (signal, decoy, vacuum)
%% 2. Construct components

%2.1 Satellite
%2.1.1 Detector
MPD_BB84_Detector=components.Detector(Wavelength,Repetition_Rate,Time_Gate_Width,Spectral_Filter_Width,"Preset",components.loadPreset("MicroPhotonDevices"));

%2.1.2 Transmitter telescope
Transmitter_Telescope=components.Telescope(Transmitter_Telescope_Diameter);           %do not need to specify wavelength as this will be set by satellite object

%2.1.3 Construct satellite
SimSatellite=nodes.Satellite(Transmitter_Telescope,...
                        'Detector', MPD_BB84_Detector,...
                        'OrbitDataFileLocation',OrbitDataFileLocation);

%2.2 Ground station
%2.2.1 Source
Transmitter_Source=components.Source(Wavelength,...
                                    'Repetition_Rate',Repetition_Rate,...
                                    'MPN_Signal',MPNs(1), ...
                                    'MPN_Decoy', MPNs(2),...
                                    'Probability_Signal',SPs(1),...
                                    'Probability_Decoy',SPs(2));            
%2.2.2 Receiver telescope
Receiver_Telescope=components.Telescope(Receiver_Telescope_Diameter);

%2.2.3 construct ground station, use Heriot-Watt as an example
SimGround_Station=nodes.Ground_Station(Receiver_Telescope,...
                                'Source',Transmitter_Source,...
                                'LLA',[55.909723, -3.319995,10],...
                                'Name','Heriot-Watt');


%% 3 Compose and run the PassSimulation
%3.1 run simulation, first argument is receiver
result = nodes.QkdPassSimulation(SimSatellite, SimGround_Station, protocol.decoyBB84);
%3.2 plot results
figure = plotResult(result,SimSatellite,SimGround_Station);