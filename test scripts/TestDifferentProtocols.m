% run a simulation of all protocols which have implementations from a
% satellite downlink

%% Declare common values
Transmitter_Diameter=0.08;
Receiver_Diameter=0.7;
OrbitDataFileLocation='500kmOrbitLLAT.txt';
Time_Gate_Width=10^-9;
Repetition_Rate=10^9;
Spectral_Filter_Width=1;
Wavelength=850;

%% declare common components
Transmitter_Telescope=Telescope(Transmitter_Diameter,Wavelength);
Receiver_Telescope=Telescope(Receiver_Diameter,Wavelength);

%% BB84 simple
%declare specific components
BB84_S=BB84_Source(Wavelength);
BB84_D=MPD_Detector(Wavelength,Repetition_Rate,Time_Gate_Width,Spectral_Filter_Width);
BB84_P=BB84_Protocol();
%make generic components
SimSatellite=Satellite(OrbitDataFileLocation,BB84_S,Transmitter_Telescope);
SimGround_Station=Errol_OGS(BB84_D,Receiver_Telescope);
%make passsimulation
BB84_Simple_Pass=PassSimulation(SimSatellite,BB84_P,SimGround_Station,[]);
BB84_Simple_Pass=Simulate(BB84_Simple_Pass);
plot(BB84_Simple_Pass);

%% E91
%declare specific components
E91_S=E91_Source(Wavelength);
E91_D=MPD_Detector(Wavelength,Repetition_Rate,Time_Gate_Width,Spectral_Filter_Width);
E91_P=E91_Protocol();
%make generic components
SimSatellite=Satellite(OrbitDataFileLocation,E91_S,Transmitter_Telescope);
SimGround_Station=Errol_OGS(E91_D,Receiver_Telescope);
%make passsimulation
E91_Pass=PassSimulation(SimSatellite,E91_P,SimGround_Station,[]);
E91_Pass=Simulate(E91_Pass);
plot(E91_Pass)

%% decoy BB84
%declare specific components
decoyBB84_S=decoyBB84_Source(Wavelength,[0.7,0.1,0],[0.8,0.1,0.1],0.01);
decoyBB84_D=MPD_Detector(Wavelength,Repetition_Rate,Time_Gate_Width,Spectral_Filter_Width);
decoyBB84_P=decoyBB84_Protocol();
%make generic components
SimSatellite=Satellite(OrbitDataFileLocation,decoyBB84_S,Transmitter_Telescope);
SimGround_Station=Errol_OGS(decoyBB84_D,Receiver_Telescope);
%make passsimulation
decoyBB84_Pass=PassSimulation(SimSatellite,decoyBB84_P,SimGround_Station,[]);
decoyBB84_Pass=Simulate(decoyBB84_Pass);
plot(decoyBB84_Pass);

%% COW
%declare specific components
COW_S=COW_Source(Wavelength);
COW_D=Generic_Detector(Wavelength,Repetition_Rate,Time_Gate_Width,Spectral_Filter_Width);
COW_P=COW_Protocol();
%make generic components
SimSatellite=Satellite(OrbitDataFileLocation,COW_S,Transmitter_Telescope);
SimGround_Station=Errol_OGS(COW_D,Receiver_Telescope);
%make passsimulation
COW_Pass=PassSimulation(SimSatellite,COW_P,SimGround_Station,[]);
COW_Pass=Simulate(COW_Pass);
plot(COW_Pass)

%% DPS
%declare specific components
DPS_S=DPS_Source(Wavelength);
DPS_D=Generic_Detector(Wavelength,Repetition_Rate,Time_Gate_Width,Spectral_Filter_Width);
DPS_P=DPS_Protocol();
%make generic components
SimSatellite=Satellite(OrbitDataFileLocation,DPS_S,Transmitter_Telescope);
SimGround_Station=Errol_OGS(DPS_D,Receiver_Telescope);
%make passsimulation
DPS_Pass=PassSimulation(SimSatellite,DPS_P,SimGround_Station,[]);
DPS_Pass=Simulate(DPS_Pass);
plot(DPS_Pass)