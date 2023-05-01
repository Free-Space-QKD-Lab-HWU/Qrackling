% run a simulation of all protocols which have implementations from a
% satellite downlink

%% Declare common values
Transmitter_Diameter=0.08;
Receiver_Diameter=0.7;
OrbitDataFileLocation='100kmSSOrbitLLAT.txt';
Time_Gate_Width=10^-9;
Repetition_Rate=10^9;
Spectral_Filter_Width=1;
Wavelength=850;

%% declare common components
Transmitter_Telescope=Telescope(Transmitter_Diameter,"Wavelength",Wavelength);
Receiver_Telescope=Telescope(Receiver_Diameter,"Wavelength",Wavelength);

%% BB84 simple
%declare specific components
BB84_S=Source(Wavelength);
BB84_D=MPD_Detector(Wavelength,Repetition_Rate,Time_Gate_Width,Spectral_Filter_Width);
BB84_P=Protocol(qkd_protocols.DecoyBB84);
%make generic components
SimSatellite=Satellite(BB84_S,Transmitter_Telescope,'OrbitDataFileLocation',OrbitDataFileLocation);
SimGround_Station=Errol_OGS(BB84_D,Receiver_Telescope);
%make passsimulation
BB84_Simple_Pass=PassSimulation(SimSatellite,BB84_P,SimGround_Station);
BB84_Simple_Pass=Simulate(BB84_Simple_Pass);
plot(BB84_Simple_Pass);

%% E91
%declare specific components
E91_S=Source(Wavelength);
E91_D=MPD_Detector(Wavelength,Repetition_Rate,Time_Gate_Width,Spectral_Filter_Width);
E91_P=Protocol(qkd_protocols.E91);
%make generic components
SimSatellite=Satellite(E91_S,Transmitter_Telescope,'OrbitDataFileLocation',OrbitDataFileLocation);
SimGround_Station=Errol_OGS(E91_D,Receiver_Telescope);
%make passsimulation
E91_Pass=PassSimulation(SimSatellite,E91_P,SimGround_Station);
E91_Pass=Simulate(E91_Pass);
plot(E91_Pass)

%% decoy BB84
%declare specific components
decoyBB84_S=Source(Wavelength,'Mean_Photon_Number',[0.7,0.1,0],'State_Probabilities',[0.8,0.1,0.1],'State_Prep_Error',0.01);
decoyBB84_D=MPD_Detector(Wavelength,Repetition_Rate,Time_Gate_Width,Spectral_Filter_Width);
decoyBB84_P = Protocol(qkd_protocols.DecoyBB84);
%make generic components
SimSatellite=Satellite(decoyBB84_S,Transmitter_Telescope,'OrbitDataFileLocation',OrbitDataFileLocation);
SimGround_Station=Errol_OGS(decoyBB84_D,Receiver_Telescope);
%make passsimulation
decoyBB84_Pass=PassSimulation(SimSatellite,decoyBB84_P,SimGround_Station);
decoyBB84_Pass=Simulate(decoyBB84_Pass);
plot(decoyBB84_Pass);

%% COW
%declare specific components
COW_S=Source(Wavelength,'Mean_Photon_Number',0.06,'State_Probabilities',[0.9,0.1],'State_Prep_Error',0.01);
COW_D=Generic_Detector(Wavelength,Repetition_Rate,Time_Gate_Width,Spectral_Filter_Width);
COW_P=Protocol(qkd_protocols.COW);
%make generic components
SimSatellite=Satellite(COW_S,Transmitter_Telescope,'OrbitDataFileLocation',OrbitDataFileLocation);
SimGround_Station=Errol_OGS(COW_D,Receiver_Telescope);
%make passsimulation
COW_Pass=PassSimulation(SimSatellite,COW_P,SimGround_Station);
COW_Pass=Simulate(COW_Pass);
plot(COW_Pass)

%% DPS
%declare specific components
DPS_S=Source(Wavelength);
DPS_D=Generic_Detector(Wavelength,Repetition_Rate,Time_Gate_Width,Spectral_Filter_Width);
DPS_P=Protocol(qkd_protocols.DPS);
%make generic components
SimSatellite=Satellite(DPS_S,Transmitter_Telescope,'OrbitDataFileLocation',OrbitDataFileLocation);
SimGround_Station=Errol_OGS(DPS_D,Receiver_Telescope);
%make passsimulation
DPS_Pass=PassSimulation(SimSatellite,DPS_P,SimGround_Station);
DPS_Pass=Simulate(DPS_Pass);
plot(DPS_Pass)
