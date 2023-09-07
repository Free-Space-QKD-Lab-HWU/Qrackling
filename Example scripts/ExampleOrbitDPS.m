%% implement a simulation of a satellite in a 500km sun synchronous orbit over a ground station using the COW protocol
%% First, we must construct the components of a simulation. Then we form them all into a single PassSimulation object.
%% Then we simulate the pass and plot the results.

%% 1. Choose parameters
Wavelength=780;                                                            %wavelength is measured in nm
Transmitter_Telescope_Diameter=0.1;                                        %diameters are measured in m
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
StartTime = datetime(2022,12,25,6,0,0);
StopTime = datetime(2022,12,25,7,0,0);
        SampleTime = 0.01;
SimSatellite=Satellite(Transmitter_Telescope,...
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
Generic_DPS_Detector=Detector(Wavelength,Transmitter_Source.Repetition_Rate,Time_Gate_Width,Spectral_Filter_Width,...
    Preset=DetectorPresets.MicroPhotonDevices.LoadPreset());
%need to provide repetition rate in order to compute QBER and loss due to
%time gating
%NOTE only detectors with the 'Visibility' property can be used for COW

%2.2.2 Receiver telescope
Receiver_Telescope=Telescope(Receiver_Telescope_Diameter);

%2.2.3 construct ground station, use Chilbolton as an example
SimGround_Station=Chilbolton_OGS(Receiver_Telescope,...
                                    'Detector',Generic_DPS_Detector);

%2.3 protocol
DPS_protocol=Protocol.DPS;

%% 3 Compose and run the PassSimulation
%3.1 compose passsimulation object
Pass=PassSimulation(SimSatellite,DPS_protocol,SimGround_Station);
%3.2 run simulation
Pass=Simulate(Pass);
%3.3 plot results
plot(Pass.Satellite.Times(Pass.Elevation_Limit_Flags),Pass.QKD_Receiver.Detector.Visibility,...
    Pass.Satellite.Times(Pass.Elevation_Limit_Flags),Pass.QBERs(Pass.Elevation_Limit_Flags))
xlabel('Time during elevation window')
legend('Visibility','QBER')