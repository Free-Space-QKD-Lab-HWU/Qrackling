%% preamble
clear all
close all
clc

%% Build Atmosphere
output_atmosphere_path = '/home/bp38/Documents/MATLAB/test_atmosphere_2.mat';
atmosphere = Atmosphere(output_atmosphere_path);

%% Satellite Pass

circAreaFromDiameter = @(d) pi * (d / 2)^2;
obscurationRatio = @(d, obs) 1 - (circAreaFromDiameter(d*obs) / circAreaFromDiameter(d));

OrbitDataFileLocation= '500kmSSOrbitLLAT.txt';

wvl = 808;
wvl = 785;

if 808 == wvl
    eta_back = 0.9;
    eta_back = 0.81;
elseif 785 == wvl
    eta_back = 0.935;
    eta_back = 0.81;
else
    eta_back = 1;
end

time_gate = 10^-9;
spectral_filter = 1;
dcr = 1000; % optionally 200

central_obscuration_ratio_rx = 0.3;
diameter_tx = 0.08;
diameter_rx = 0.7;

protocol = Protocol(qkd_protocols.DecoyBB84);

source = Source(wvl, ...
                Repetition_Rate = 50e6, ...
                Mean_Photon_Number = [0.8, 0.3, 0], ...
                State_Prep_Error = 0.025, ...
                State_Probabilities = [0.7,0.2,0.1] );

detector = Excelitas_Detector(wvl, 50e6, time_gate, ...
                              spectral_filter, Dead_Time = 1e-6);

telescope_tx = Telescope(diameter_tx, Wavelength = wvl);
telescope_rx = Telescope(diameter_rx, Wavelength = wvl);

telescope_rx.Optical_Efficiency = eta_back ...
                                  * obscurationRatio(diameter_rx, ...
                                                     central_obscuration_ratio_rx);

ogs = Errol_OGS(detector, telescope_rx);

satellite = Satellite(source, telescope_tx, ...
                      'OrbitDataFileLocation', OrbitDataFileLocation);

decoybb84_pass = PassSimulation(satellite, protocol, ogs, Visibility='clear');
decoybb84_pass = Simulate(decoybb84_pass);


%% Conditions
choice = 'Difuse_tilted_irradiance';
conditions = atmosphere.satellitePassConditions(decoybb84_pass, wvl, choice);

%% Plot
cf = atmosphere.plotContourForField(decoybb84_pass, wvl, choice)
sf = atmosphere.plotSurfaceForField(decoybb84_pass, wvl, choice)
csf = atmosphere.plotSurfaceForCondition(conditions)

%% Many Conditions
conditions = atmosphere.satellitePassConditions(decoybb84_pass, [400, wvl, 1550], choice);

conditions = atmosphere.satellitePassConditions(decoybb84_pass, 400, choice);
csf = atmosphere.plotSurfaceForCondition(conditions)

atmosphere.plotField(choice)
