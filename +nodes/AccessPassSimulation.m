function access_table = AccessPassSimulation(satellite, ground_station, options)
% AccessPassSimulation
%
% Use the MATLAB Satellite Communications Toolbox to determine when
% link access is available between a satellite and a ground station.
%
% Syntax:
% access_table = AccessPassSimulation(satellite, ground_station, options)
%
% Inputs:
% satellite      - nodes.Satellite object
% ground_station - nodes.Ground_Station object
% options.start_time - datetime, start of simulation (default: now)
% options.stop_time  - datetime, end of simulation (default: now + 1 day)
% options.sample_time - duration, time step for simulation (default: 1 second)
% options.show       - logical, whether to display scenario viewer (default: false)
%
% Output:
% access_table   - table of access intervals between satellite and ground station

    arguments
        satellite nodes.Satellite
        ground_station nodes.Ground_Station
        options.start_time datetime = datetime('now')
        options.stop_time datetime = datetime('now') + days(1)
        options.sample_time duration = seconds(1)
        options.show logical = false()
    end


    %% Create satellite scenario
    scenario = satelliteScenario(options.start_time, ...
                                 options.stop_time, ...
                                 seconds(options.sample_time));

    % Add satellite
    [scenario, scenario_satellite] = satellite.AddSimulatorSatellite(scenario);

    % Add ground station
    [scenario, scenario_ogs] = ground_station.AddSimulatorOGS(scenario);


    %% Determine access intervals
    access_obj = access(scenario_satellite, scenario_ogs);
    access_table = accessIntervals(access_obj);


    %% Show scenario viewer if requested
    if options.show
        scenario.play();
    end
end