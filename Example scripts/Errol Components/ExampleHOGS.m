%% an example script demonstrating how to simulate the current HOGS model and Quantum comms hub satellite

%% model HOGS
HOGS=HOGS();%current HOGS model

%% model hub satellite
%can run using default times
%Sat=NOTQUARC();
% or using custom start, stop and interval times
%poor pass: 0610 to 0655 christmas day 2022
%good pass: 0423 to 0426 31 jan 2023
StartTime = datetime(2023,1,31,4,0,0);
StopTime = datetime(2023,1,31,5,0,0);
SampleTime = seconds(1);
Sat=NOTQUARC(StartTime,StopTime,SampleTime);
%use decoy BB84
Protocol=decoyBB84_Protocol();


%create SMARTS atmospheric sim- this is not needed if an atmosphere cache is
%used
%SMARTS_Config=solar_background_errol_fast('executable_path','C:\Git\SMARTS\',...
%                                     'stub','C:\Git\QKD_Sat_Link\SMARTS_connection\SMARTS cache\');



%% simulate a pass
Pass=PassSimulation(Sat,Protocol,HOGS);
Pass=Simulate(Pass);
plot(Pass);
%Play(Pass);
