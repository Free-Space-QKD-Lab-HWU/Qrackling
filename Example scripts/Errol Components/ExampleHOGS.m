%% an example script demonstrating how to simulate the current HOGS model and Quantum comms hub satellite


%which channel should be modelled?
%Wavelength = 785;    
Wavelength = 808;
%Wavelength = 1550;

assert(ismember(Wavelength,[785,808,1550]),'Wavelength must be one of the intended channels: 785,850 or 1550')


%% model HOGS
OGS=HOGS(Wavelength);%current HOGS model

%% model hub satellite
%can run using default times
%Sat=NOTQUARC();
% or using custom start, stop and interval times

%best case pass: 0423 to 0426 31 jan 2023, 50km visibility
%%{
StartTime = datetime(2022,12,25,6,0,0);
StopTime = datetime(2022,12,25,7,0,0);
VisString = '50km';
TurbulenceString = 'HV10-10';
%}
%ok pass: 0610 to 0655 christmas day 2022, 10km visibility
%{
StartTime = datetime(2023,2,6,3,0,0);
StopTime = datetime(2023,2,6,5,0,0);
VisString = '10km';
TurbulenceString = 'HV5-7';
%}

%worst case pass: 0330 to 0333 4 feb 2023, 2km visibility
%{
StartTime = datetime(2023,1,31,4,0,0);
StopTime = datetime(2023,1,31,5,0,0);
VisString = '2km';
TurbulenceString = '2HV5-7';
%}
SampleTime = seconds(1);
Sat=NOTQUARC(Wavelength,StartTime,StopTime,SampleTime);
%use decoy BB84, or CV if wavelength is 1550
if Wavelength==1550
Prot = Protocol.CV;
else
Prot=Protocol.DecoyBB84;
end

%create SMARTS atmospheric sim- this is not needed if an atmosphere cache is
%used
%SMARTS_Config=solar_background_errol_fast('executable_path','C:\Git\SMARTS\',...
%                                     'stub','C:\Git\QKD_Sat_Link\SMARTS_connection\SMARTS cache\');


%% simulate a pass
Pass=PassSimulation(Sat,Prot,OGS,'Visibility',VisString,'Turbulence',TurbulenceString);
Pass=Simulate(Pass);
plot(Pass,'Range','Elevation','XAxis','Time') %plot elevation window only
%Play(Pass);
