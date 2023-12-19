% a simulation of a decoy BB84 satellite pass which implements beacon simulations
% alongside the quantum channel

%% 1. Choose parameters
Wavelength=785;                                                            %wavelength is measured in nm
Transmitter_Telescope_Diameter=0.1;                                        %diameters are measured in m
OrbitDataFileLocation='500kmSSOrbitLLAT.txt';                              %orbits are described by files containing latitude, longitude, altitude and time stamps. These are in the 'orbit modelling resources' folder
Receiver_Telescope_Diameter=1;                                           
Time_Gate_Width=1E-9;                                                      %times are measured in s
Spectral_Filter_Width=10;                                                  %consistemt with wavelength, spectral width is measured in nm
Repetition_Rate = 1E9;                                                     %repetition rate in Hz
Beacon_Power = 1;                                                           %beacon power in W
Beacon_Wavelength = 850;                                                    %beacon wavelength in nm
Downlink_Beacon_Divergence = 1E-3;                                         %beacon divergence in rads
Open_Loop_Pointing_Precision = 1E-3;                                 %rms pointing error in rads
COmpensa_Beacon_Divergence = 1E-5;                                           %beacon divergence in rads
Closed_Loop_Pointing_Precision = 1E-6;                                   %rms pointing error in rads
OGS_Camera_Scope_Diameter = 0.4;                                                %camera telescope diameter in m
Camera_Exposure_Time = 0.001;                                              %exposure time of beacon cameras in s
Beacon_Camera_Filter_Width = 10;                                           %camera spectral filter width in nm
%% 2. Construct components

%2.1 Satellite
%2.1.1 Source
Transmitter_Source=components.Source(Wavelength,...
                                    "Repetition_Rate",Repetition_Rate,...
                                    'Mean_Photon_Number',[0.7,0.1,0],...
                                    'State_Probabilities',[0.75,0.15,0.1]);                                       %we use default values to simplify this example

%2.1.2 Transmitter telescope
Transmitter_Telescope=components.Telescope(Transmitter_Telescope_Diameter,...
                                           "Wavelength",Wavelength,...
                                           'Pointing_Jitter',Closed_Loop_Pointing_Precision); %do not need to specify wavelength as this will be set by satellite object

%2.1.3 Satellite downlink beacon
Downlink_Beacon_Telescope = SetWavelength(Transmitter_Telescope,Beacon_Wavelength);
Downlink_Beacon = beacon.Gaussian_Beacon(Downlink_Beacon_Telescope,...
                                        Beacon_Power,...
                                        Beacon_Wavelength,...
                                        'Divergence_Half_Angle',Downlink_Beacon_Divergence/2,...
                                        'Pointing_Jitter',Open_Loop_Pointing_Precision);

%2.1.4 add a beacon camera to the satellite
Uplink_Cam = CVM4000(Transmitter_Telescope, ...
                     Camera_Exposure_Time,...
                     Beacon_Camera_Filter_Width);

%2.1.5 Construct satellite
SimSatellite=nodes.Satellite(Transmitter_Telescope,...
                            'OrbitDataFileLocation',OrbitDataFileLocation,...
                            'Source',Transmitter_Source,...
                            'Beacon',Downlink_Beacon,...
                            'Camera',Uplink_Cam);

%2.2 Ground station
%2.2.1 Detector
Det=components.Detector(Wavelength, ...
             Repetition_Rate,...
             Time_Gate_Width,...
             Spectral_Filter_Width,...
             'Preset',components.loadPreset("MicroPhotonDevices"));
%need to provide repetition rate in order to compute QBER and loss due to
%time gating

%2.2.2 Receiver telescope
Receiver_Telescope=components.Telescope(Receiver_Telescope_Diameter,...
                                        "Wavelength",Wavelength,...
                                        'Pointing_Jitter',Closed_Loop_Pointing_Precision);

%2.2.3 add a beacon camera to the ground station
Downlink_Camera_Scope = components.Telescope(OGS_Camera_Scope_Diameter,'Wavelength',Beacon_Wavelength);
Downlink_Cam = ATIK(Downlink_Camera_Scope,...
                    Camera_Exposure_Time,...
                    Beacon_Camera_Filter_Width);

%2.2.4 Ground station uplink beacon
Uplink_Beacon_Scope = SetWavelength(Receiver_Telescope,Beacon_Wavelength);
Uplink_Beacon = beacon.Gaussian_Beacon(Uplink_Beacon_Scope,...
                                       Beacon_Power,...
                                       Beacon_Wavelength,...
                                       'Divergence_Half_Angle',Uplink_Beacon_Divergence,...
                                       'Pointing_Jitter',Closed_Loop_Pointing_Precision);

%2.2.5 construct ground station, use Heriot-Watt as an example
SimGround_Station = nodes.Ground_Station(Receiver_Telescope,...
                                       'Detector',Det,...
                                       'LLA',[55.909723, -3.319995,10],...
                                       'Name','Heriot-Watt',...
                                       'Beacon',Uplink_Beacon,...
                                       'Camera',Downlink_Cam);

%% 3 Compose and run the PassSimulation
%3.1 run simulation
Result = nodes.QkdPassSimulation(SimGround_Station,SimSatellite,"DecoyBB84");
DownlinkBeaconResults = beacon.beaconSimulation(SimGround_Station,SimSatellite);
UplinkBeaconResults = beacon.beaconSimulation(SimSatellite,SimGround_Station);
%3.2 plot results
plotResult(Result,SimSatellite.Times,'Time',SimGround_Station,SimSatellite);
%plot(DownlinkBeaconResults,SimSatellite.Times,'Time');
%plot(UplinkBeaconResults,SimSatellite.Times,'Time');

