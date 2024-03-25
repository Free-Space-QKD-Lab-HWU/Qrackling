%% an example script demonstrating how to simulate the current HOGS model and Quantum comms hub satellite


%which channel should be modelled?
Wavelength = 785;    
%Wavelength = 808;
%Wavelength = 1550;

assert(ismember(Wavelength,[785,808,1550]),'Wavelength must be one of the intended channels: 785,850 or 1550')


%% model HOGS
OGS=HOGS(Wavelength);%current HOGS model

%% model hub satellite
%can run using default times
%Sat=SPOQC;
% or using custom start, stop and interval times

%best case pass: 0423 to 0426 31 jan 2023, 50km visibility
%{
StartTime = datetime(2022,12,25,6,0,0);
StopTime = datetime(2022,12,25,7,0,0);
Env = environment.Environment.Load("Examples\Data\atmospheric transmittance\varying elevation MODTRAN data 3\Dark Environment 50km.mat");
TurbulenceString = 'HV10-10';
%}
%ok pass: 0610 to 0655 christmas day 2022, 10km visibility
%{
StartTime = datetime(2023,2,6,3,0,0);
StopTime = datetime(2023,2,6,5,0,0);
Env = environment.Environment.Load("Examples\Data\atmospheric transmittance\varying elevation MODTRAN data 3\Dark Environment 10km.mat");
TurbulenceString = 'HV5-7';
%}

%worst case pass: 0330 to 0333 4 feb 2023, 2km visibility
%%{
StartTime = datetime(2023,1,31,4,0,0);
StopTime = datetime(2023,1,31,5,0,0);
Env = environment.Environment.Load("Examples\Data\atmospheric transmittance\varying elevation MODTRAN data 3\Dark Environment 5km.mat");
TurbulenceString = '2HV5-7';
%}
SampleTime = seconds(1);
Sat=SPOQC(Wavelength,StartTime,StopTime,SampleTime);


%% simulate a pass
PassResult = nodes.QkdPassSimulation(OGS,Sat,protocol.decoyBB84,'Environment',Env);
DownlinkBeaconResults = beacon.beaconSimulation(OGS,Sat);
UplinkBeaconResults = beacon.beaconSimulation(Sat,OGS);

%% plot a pass
plotResult(PassResult,OGS,Sat,'x_axis','Time');
plot(DownlinkBeaconResults,"mask","Line of sight");
plot(UplinkBeaconResults,"mask","Line of sight");