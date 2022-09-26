% a standard simulation used for testing


%% Declare common values
Transmitter_Diameter=0.3;
Receiver_Diameter=0.7;
OrbitDataFileLocation='100kmOrbitLLAT.txt';
Wavelength=850;
Time_Gate_Width=10^-9;
Spectral_Filter_Width=1;
Repetition_Rate=10^9;

%% declare common components
Transmitter_Telescope=Telescope(Transmitter_Diameter,Wavelength);
Receiver_Telescope=Telescope(Receiver_Diameter,Wavelength);

%% background light sources (uncomment as appropriate
Sun=load("Light Reflection implementations\Sun.mat");
Sun=Sun.Sun;
Cities=load('Cities.mat');
Cities=Cities.Cities;
Background_Sources=[Sun,Cities];


%% BB84 simple
%declare specific components
BB84_S=BB84_Source(Wavelength);
BB84_P=BB84_Protocol();
BB84_D=MPD_Detector(Wavelength,Repetition_Rate,Time_Gate_Width,Spectral_Filter_Width);

%make generic components
SimSatellite=Satellite(OrbitDataFileLocation,BB84_S,Transmitter_Telescope);
SimGround_Station=Chilbolton_OGS(BB84_D,Receiver_Telescope);
%make passsimulation
BB84_Simple_Pass=PassSimulation(SimSatellite,BB84_P,SimGround_Station,Background_Sources);
BB84_Simple_Pass=Simulate(BB84_Simple_Pass);
plot(BB84_Simple_Pass,'Elevation');
