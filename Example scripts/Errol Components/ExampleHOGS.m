%% an example script demonstrating how to simulate the current HOGS model and Quantum comms hub satellite

%% model HOGS
HOGS=HOGS();%current HOGS model

%% model hub satellite
%can run using default times
%Sat=HubSat();
% or using custom start, stop and interval times
StartTime = datetime(2022,12,25,6,10,0);                                         %5am to 6am christmas day 2022, with 1 second simulation interval
StopTime = datetime(2022,12,25,6,55,0);
SampleTime = seconds(15);
Sat=HubSat(StartTime,StopTime,SampleTime);
%use decoy BB84
Protocol=decoyBB84_Protocol();
%create SMARTS atmospheric sim at the middle of the pass
SMARTS_Config=solar_background_errol_fast('executable_path','C:\Git\SMARTS\',...
                                     'stub','C:\Git\QKD_Sat_Link\SMARTS_connection\SMARTS cache\');

%% simulate a pass
Pass=PassSimulation(Sat,Protocol,HOGS,'SMARTS',SMARTS_Config);
Pass=Simulate(Pass);
plot(Pass);
