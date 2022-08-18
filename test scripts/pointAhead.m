%%Point ahead: OGS -> Sat (UPLINK)
close all;
clc;
clear all;

startTime = datetime(2020,6,02,8,23,0);
stopTime = startTime + hours(5);
sampleTime = 360;
numSamples = 10;

scenario = satelliteScenarioWrapper(startTime, stopTime, ...
                                    'numSamples', numSamples);
% scenario = satelliteScenarioWrapper(startTime, stopTime, ...
%                                     'sampleTime', sampleTime);

transmitterDiameter=0.08;
receiverDiameter=0.7;
timeGateWidth=10^-9;
repetitionRate=10^9;
spectralFilterWidth=1;
wavelength=850;

transmitterTelescope = Telescope(transmitterDiameter);
receiverTelescope = Telescope(receiverDiameter);

bb84S=BB84_Source(wavelength);
bb84Detector = MPD_Detector(wavelength, bb84S.Repetition_Rate, ...
                            timeGateWidth, spectralFilterWidth);

[errol, scenario] = Ground_Station(bb84Detector, receiverTelescope, ...
                       'scenario', scenario, ...
                       'latitude', 56.40555555, 'longitude', -3.18833333, ...
                       'altitude', 10, 'name', 'Errol');

sma = 6878e3;
ecc = 1.34229e-15;
inc = 60;
raan = 0;
aop = 0;
ta = 133.242;

[sat, scenario] = Satellite(bb84S, transmitterTelescope, 'scenario', scenario, ...
               'KeplerElements', [sma, ecc, inc, raan, aop, ta]);

[a, e, r] = aer(scenario.GroundStations(1), scenario.Satellites(1))

c = 3e8;

[p, v, t] = states(scenario.Satellites(1));

[alphaPA, betaPA] = alpha_beta(a, e, r, t);

paCoarseX = -alphaPA .* cosd(betaPA);
paCoarseY = -betaPA;

coarseAngle = 
