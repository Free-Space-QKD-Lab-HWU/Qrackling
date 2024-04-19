function [SatScenario,AccessIntervals] = OrbitVisual(Satellite, Ground_Station,options)
%ORBITVISUAL a function which compiles a MATLAB satellite communications
%toolbox scenario containing the given satellite and ground station

arguments
    Satellite (1,1) nodes.Satellite
    Ground_Station (1,1) nodes.Ground_Station
    options.AutoPlay (1,1) logical = true
    options.StartTime datetime {mustBeScalarOrEmpty} = datetime.empty 
    options.StopTime datetime {mustBeScalarOrEmpty}  = datetime.empty
    options.SampleTime duration {mustBeScalarOrEmpty} = duration.empty % we take sample time as a duration, later this is converted to a double value in s
end

%% 1 create a satellite scenario

%1.1 first, need start and stop time if not provided
if isempty(options.StopTime)
    options.StartTime = Satellite.Times(1);
end
if isempty(options.StopTime)
    options.StopTime = Satellite.Times(end);
end
if isempty(options.SampleTime)
    options.SampleTime = seconds(options.StopTime - options.StartTime)/(numel(Satellite.Times)-1);
else
    options.SampleTime = seconds(options.SampleTime);
end

%1.2 now can create satellite scenario
SatScenario = satelliteScenario(options.StartTime,options.StopTime,options.SampleTime);

%% 2 add satellites
[SatScenario,sat] = AddSimulatorSatellite(Satellite,SatScenario);

%% 3 add OGSs
[SatScenario,ogs] = AddSimulatorOGS(Ground_Station,SatScenario);

%% 4 determine access intervals
Access = access(sat,ogs);
AccessIntervals = accessIntervals(Access);

%% 5 if wanted, play
if options.AutoPlay
    SatScenario.play()
end


