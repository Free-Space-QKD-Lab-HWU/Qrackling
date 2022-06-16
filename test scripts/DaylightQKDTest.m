%% simulate an E91 QKD pass with the sun above

%% Declare common values
Transmitter_Diameter=0.08;                                                 %satellite telescope diameter
Receiver_Diameter=0.7;                                                     %receiver telescope diameter
OrbitDataFileLocation='500kmOrbitLLAT.txt';                                %orbit position file. 500km sun sync orbit
Time_Gate_Width=10^-9;                                                     %receiver time gate width
Repetition_Rate=10^9;                                                      %transmitter rep rate
Spectral_Filter_Width=1;                                                   %1nm spectral filter width
Wavelength=850;                                                            %850nm wavelength
Excelitas_Detector_Factory=Excelitas_Detector_Factory();                   %excelitas SPAD

%% declare common components
Transmitter_Telescope=Telescope(Transmitter_Diameter,Wavelength);
Receiver_Telescope=Telescope(Receiver_Diameter,Wavelength);

%% import sun object
Sun=getfield(load('Sun.mat'),'Sun');
%% E91
%declare specific components
E91_S=E91_Source(Wavelength);
E91_D=CreateDetector(Generic_Detector_Factory,Wavelength,'E91',Time_Gate_Width,Spectral_Filter_Width,Repetition_Rate);
E91_P=E91_Protocol();
%make generic components
SimSatellite=Satellite(OrbitDataFileLocation,E91_S,Transmitter_Telescope);
SimGround_Station=Errol_OGS(E91_D,Receiver_Telescope);
%make passsimulation
E91_Pass=PassSimulation(SimSatellite,E91_P,SimGround_Station,Sun);
E91_Pass=Simulate(E91_Pass);
plot(E91_Pass)