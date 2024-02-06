% a simulation of a differential phase shift protocol satellite pass

%% 1. Choose parameters
Wavelength=780;                                                            %wavelength is measured in nm
Transmitter_Telescope_Diameter=0.1;                                        %diameters are measured in m
Receiver_Telescope_Diameter=1;                                           
Time_Gate_Width=1E-10;                                                      %times are measured in s
Spectral_Filter_Width=1;                                                  %consistemt with wavelength, spectral width is measured in nm
Repetition_Rate = 1E8;  
SPs = [0.9,0.1];
MPN = 0.9;
%% 2. Construct components

%2.1 Satellite
%2.1.1 Source
Transmitter_Source=components.Source(Wavelength,...
                          'Repetition_Rate',Repetition_Rate,...
                          'MPN_Signal',MPN,...
                          'Probability_Signal',SPs(1),...
                          'Probability_Decoy',SPs(2));        %we use default values to simplify this example

%2.1.2 Transmitter telescope
Transmitter_Telescope=components.Telescope(Transmitter_Telescope_Diameter);           %do not need to specify wavelength as this will be set by satellite object

%2.1.3 Construct satellite
StartTime = datetime(2022,12,25,6,0,0);
StopTime = datetime(2022,12,25,7,0,0);
SampleTime = 1;
SimSatellite=nodes.Satellite(Transmitter_Telescope,...
                        'Source',Transmitter_Source,...
                        'SemiMajorAxis',600E3 + earthRadius,...             %mean orbital radius = Altitude + Earth radius
                        'eccentricity',0,...                                %measure of ellipticity of the orbit, for circular, =0
                        'inclination',9.7065055549e+01,...                  %inclination of orbit in deg- set by sun synchronicity
                        'rightAscensionOfAscendingNode',-1.5,...            %measure of location of orbit in longitude
                        'argumentOfPeriapsis',0,...                         %measurement of location of ellipse nature of orbit in longitude, irrelevant for circular orbits
                        'trueAnomaly',0,...                                 %initial position through orbit of satellite
                        'StartTime',StartTime,...                           %start of simulation
                        'StopTime',StopTime,...                             %end of simulation
                        'sampleTime',SampleTime);                           %simulation interval in s

%2.2 Ground station
%2.2.1 Detector
DPS_Detector=components.Detector(Wavelength,Transmitter_Source.Repetition_Rate,Time_Gate_Width,Spectral_Filter_Width,...
    "Preset",components.loadPreset("MicroPhotonDevices"));
%need to provide repetition rate in order to compute QBER and loss due to
%time gating
%NOTE only detectors with the 'Visibility' property can be used for COW

%2.2.2 Receiver telescope
Receiver_Telescope=components.Telescope(Receiver_Telescope_Diameter);

%2.2.3 construct ground station, use Chilbolton as an example
SimGround_Station=nodes.Ground_Station(Receiver_Telescope,...
                                'Detector',DPS_Detector,...
                                'LLA',[55.909723, -3.319995,10],...
                                'Name','Heriot-Watt');



%% 3 Compose and run the PassSimulation
SimResults = nodes.QkdPassSimulation(SimGround_Station,SimSatellite,protocol.dps);
plotResult(SimResults,SimGround_Station,SimSatellite);