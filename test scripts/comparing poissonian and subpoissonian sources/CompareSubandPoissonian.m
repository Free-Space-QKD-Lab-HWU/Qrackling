%% this script simulates a poissonian decoy BB84 satellite pass. Then it outputs the loss and BCR data to be used for the subpoissonian model and plots both models for comparison

%% decoy BB84 satellite model
% parameters
Transmitter_Diameter=0.08;
Receiver_Diameter=0.7;
OrbitDataFileLocation='100kmOrbitLLAT.txt';
Time_Gate_Width=10^-9;
Repetition_Rate=10^9;
Spectral_Filter_Width=1;
Wavelength=850;
Excelitas_Detector_Factory=Excelitas_Detector_Factory();

%create components
Transmitter_Telescope=Telescope(Transmitter_Diameter,Wavelength);
Receiver_Telescope=Telescope(Receiver_Diameter,Wavelength);
BB84_S=decoyBB84_Source(Wavelength);
BB84_D=Generic_Detector(Wavelength,'decoyBB84',Time_Gate_Width,Spectral_Filter_Width,Repetition_Rate);
BB84_P=decoyBB84_Protocol();
SimSatellite=Satellite(OrbitDataFileLocation,BB84_S,Transmitter_Telescope);
SimGround_Station=Errol_OGS(BB84_D,Receiver_Telescope);

%make passsimulation
PoissonianDecoyPass=PassSimulation(SimSatellite,BB84_P,SimGround_Station,[]);
PoissonianDecoyPass=Simulate(PoissonianDecoyPass);

%% output loss and BCR
Pass_Loss=GetLinkLossdB(PoissonianDecoyPass);
BCR=GetBCR(PoissonianDecoyPass);
P_Dark_Count=1-exp(-BCR*Time_Gate_Width);
Times=GetTimes(PoissonianDecoyPass);


%% plot performance of poissonian pass
plot(PoissonianDecoyPass);
%then add in subpoissonian results

