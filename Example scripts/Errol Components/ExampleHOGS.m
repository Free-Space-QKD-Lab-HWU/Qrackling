%% an example script demonstrating how to simulate the current HOGS model and Quantum comms hub satellite

%% model HOGS
HOGS=HOGS();%current HOGS model

%% model hub satellite
%can run using default times
%Sat=NOTQUARC();
% or using custom start, stop and interval times
StartTime = datetime(2022,12,25,6,40,0);%0610 to 0655 christmas day 2022, with 1 second simulation interval
StopTime = datetime(2022,12,25,7,20,0);
SampleTime = seconds(1);
Sat=NOTQUARC(StartTime,StopTime,SampleTime);
%use decoy BB84
Protocol=decoyBB84_Protocol();
%create SMARTS atmospheric sim
SMARTS_Config=solar_background_errol_fast('executable_path','C:\Git\SMARTS\',...
                                     'stub','C:\Git\QKD_Sat_Link\SMARTS_connection\SMARTS cache\');

%% simulate a pass
Pass=PassSimulation(Sat,Protocol,HOGS,'SMARTS',SMARTS_Config);
Pass=Simulate(Pass);
plot(Pass);
