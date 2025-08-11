%% an example script demonstrating how to simulate the current HOGS model and Quantum comms hub satellite


%which channel should be modelled?
%Wavelength = 785;    
Wavelength = 808;
%Wavelength = 1550;

assert(ismember(Wavelength,[785,808,1550]),'Wavelength must be one of the intended channels: 785,850 or 1550')


%% model HOGS
OGS=HOGS(Wavelength,'BeaconCamera','Fine');%current HOGS model

%% model hub satellite
%can run using default times
%Sat=SPOQC;
% or using custom start, stop and interval times

%best case pass: 0423 to 0426 31 jan 2023, 50km visibility
%{
StartTime = datetime(2000,5,20,18,0,0);
StopTime = datetime(2000,5,21,6,0,0);
Env = environment.Environment.Load("Examples\Data\atmospheric transmittance\Dark Environment 50km.mat");
Env.turbulence_model = environment.Turbulence_Model('Preset','HV10-10');
%}
%ok pass: 0610 to 0655 christmas day 2022, 10km visibility
%{
StartTime = datetime(2000,5,17,18,0,0);
StopTime = datetime(2000,5,18,6,0,0);
Env = environment.Environment.Load("Examples\Data\atmospheric transmittance\Dark Environment 10km.mat");
Env.turbulence_model = environment.Turbulence_Model('Preset','HV5-7');
%}

%worst case pass: 0330 to 0333 4 feb 2023, 5km visibility
%%{
StartTime = datetime(2000,5,14,18,0,0);
StopTime = datetime(2000,5,15,6,0,0);
Env = environment.Environment.load("Examples\Data\atmospheric transmittance\Dark Environment 5km.mat");
Env.turbulence_model = environment.TurbulenceModel('Preset','2HV5-7');
%}

Sat=SPOQC(Wavelength,...
    'StartTime',StartTime,'StopTime',StopTime);
OGS.environment = Env;

%% simulate a pass
PassResult = nodes.qkdPassSimulation(OGS,Sat,protocol.DecoyBB84);
DownlinkBeaconResults = beacon.beaconSimulation(OGS,Sat);
UplinkBeaconResults = beacon.beaconSimulation(Sat,OGS);

%% plot a pass
plot(PassResult,'x_axis','Time','mask','Elevation');
plot(DownlinkBeaconResults,"mask","Elevation");
plot(UplinkBeaconResults,"mask","Elevation");