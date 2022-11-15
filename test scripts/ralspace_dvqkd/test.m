%% Decoy testing
clear all
close all
clc

%% declare lambdas...

circAreaFromDiameter = @(d) pi * (d / 2)^2;
obscurationRatio = @(d, obs) 1 - (circAreaFromDiameter(d*obs) ...
                                  / circAreaFromDiameter(d));

%% Set Params and Simulate
close all

OrbitDataFileLocation= '500kmSSOrbitLLAT.txt';

wvl = 808;
%wvl = 780;
n_ph_opts = linspace(0.3, 0.8, 6);
n_ph = n_ph_opts(1);
reprate = 50e6;
reprate = 200e6;
%reprate = 1e9;
time_gate = 10^-9;
spectral_filter = 1; 
dcr = 1000; % optionally 200

central_obscuration_ratio_rx = 0.3;
diameter_tx = 0.08;
diameter_rx = 0.7;

protocol = decoyBB84_Protocol();

source_dv = Source(wvl, ...
                   Repetition_Rate = reprate, ...
                   Mean_Photon_Number = [n_ph, 1-n_ph,0], ...
                   State_Prep_Error = 0.025, ...
                   State_Probabilities =[0.7,0.2,0.1]);

%detector_dv = test_detector(wvl, reprate, time_gate, spectral_filter, 600);
% detector_dv = detector_dv.SetDetectionEfficiency(eta_det);
% detector_dv = detector_dv.SetDarkCountRate(dcr);
%test_detector(wvl, reprate, time_gate, spectral_filter, 600)

%detector_dv = Excelitas_Detector(wvl, reprate, time_gate, spectral_filter);

detector_dv = MPD_Detector(wvl, reprate, time_gate, spectral_filter);

telescope_tx = Telescope(diameter_tx, Wavelength = wvl);
telescope_rx = Telescope(diameter_rx, Wavelength = wvl);

telescope_rx.Optical_Efficiency = obscurationRatio(diameter_rx, ...
                                                central_obscuration_ratio_rx);
satellite = Satellite(source_dv, telescope_tx, ...
                      'OrbitDataFileLocation',OrbitDataFileLocation, ...
                      'Protocol', protocol);

ogs = Errol_OGS(detector_dv, telescope_rx);

decoybb84_pass = PassSimulation(satellite, protocol, ogs);
decoybb84_pass = Simulate(decoybb84_pass);

%figure
%semilogy(decoybb84_pass.Rates_In(decoybb84_pass.Rates_In ~= 0) ...
%         - decoybb84_pass.Rates_Det(decoybb84_pass.Rates_Det ~= 0))
%title('Dropped')
%
%figure
%semilogy(decoybb84_pass.Rates_In(decoybb84_pass.Rates_In ~= 0))
%semilogy(decoybb84_pass.Rates_Det(decoybb84_pass.Rates_Det ~= 0))
%title('Rates')

decoybb84_pass.plot();
