function access_table = AccessPassSimulation(satellite, ground_station,options)
%%ACCESSPASSSIMULATION use the MATLAB satcomms toolbox to determine
%when link access will be available between a satellite and a ground
%station
arguments
    satellite nodes.Satellite
    ground_station nodes.Ground_Station
    options.start_time datetime = datetime('now')
    options.stop_time datetime = datetime('now') + days(1)
    options.sample_time duration = seconds(1)
    options.show logical = false()
end    

%% create satellite scenario
scenario = satelliteScenario(options.start_time,options.stop_time,seconds(options.sample_time));
%add satellite
[scenario,scenarioSatellite] = satellite.AddSimulatorSatellite(scenario);
%add OGS
[scenario,scenarioOGS] = ground_station.AddSimulatorOGS(scenario);

%% determine access
a = access(scenarioSatellite,scenarioOGS);
%print to terminal
access_table = accessIntervals(a)

%% show in viewer if requested
if options.show
    scenario.play()
end