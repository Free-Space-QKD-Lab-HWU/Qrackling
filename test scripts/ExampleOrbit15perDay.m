%% implement a simulation of a satellite in a 500km orbit over a ground station using the decoy BB84 protocol
%% First, we must construct the components of a simulation. Then we form them all into a single PassSimulation object.
%% Then we simulate the pass and plot the results.

%% 1. Choose parameters
Wavelength=780;                                                            %wavelength is measured in nm
Transmitter_Telescope_Diameter=0.1;                                        %diameters are measured in m
OrbitDataFileLocation='500kmSSOrbitLLAT.txt';                              %orbits are described by files containing latitude, longitude, altitude and time stamps. These are in the 'orbit modelling resources' folder
Receiver_Telescope_Diameter=1;                                           
Time_Gate_Width=1E-9;                                                      %times are measured in s
Spectral_Filter_Width=10;                                                  %consistemt with wavelength, spectral width is measured in nm
%% 2. Construct components

%2.1 Satellite
%2.1.1 Source
Transmitter_Source=components.Source(Wavelength,...
                    'Mean_Photon_Number',[0.7,0.2,0.1],...
                    'State_Probabilities',[0.75,0.25,0.25]);                    %we use default values to simplify this example

%2.1.2 Transmitter telescope
Transmitter_Telescope=components.Telescope(Transmitter_Telescope_Diameter,...
                                'Wavelength',Wavelength);           %do not need to specify wavelength as this will be set by satellite object

%2.1.3 Construct satellite
SimSatellite=SunSynch15perDaySat();
SimSatellite.Source = Transmitter_Source;
SimSatellite.Telescope = Transmitter_Telescope;

%2.2 Ground station
%2.2.1 Detector
Detector=Detector(Wavelength,Transmitter_Source.Repetition_Rate,Time_Gate_Width,Spectral_Filter_Width,'Preset',DetectorPresets.MicroPhotonDevices.LoadPreset());
%need to provide repetition rate in order to compute QBER and loss due to
%time gating

%2.2.2 Receiver telescope
Receiver_Telescope=Telescope(Receiver_Telescope_Diameter,'Wavelength',Wavelength);

%2.2.3 construct ground station, use Errol as an example
SimGround_Station=Errol_OGS(Receiver_Telescope,'Detector',Detector);

%2.3 protocol
Decoy_BB84_Protocol=Protocol.DecoyBB84;

%% 3 Compose and run the PassSimulation
%3.1 compose passsimulation object
Pass=PassSimulation(SimSatellite,Decoy_BB84_Protocol,SimGround_Station);
%3.2 run simulation
Pass=Simulate(Pass);
%3.3 plot results
plot(Pass);