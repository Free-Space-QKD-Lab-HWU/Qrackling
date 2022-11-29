%% Decoy testing
clear all
% close all
clc

%% declare lambdas...
circAreaFromDiameter = @(d) pi * (d / 2)^2;
obscurationRatio = @(d, obs) 1 - (circAreaFromDiameter(d*obs) ...
                                  / circAreaFromDiameter(d));

%% Set Params and Simulate
close all

OrbitDataFileLocation= '500kmSSOrbitLLAT.txt';

wvl = 808;
wvl = 785;
n_ph_opts = linspace(0.3, 0.8, 6);
n_ph = n_ph_opts(1);
reprate = 50e6;
%reprate = 200e6;
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

detector_dv = Excelitas_Detector(wvl, reprate, time_gate, spectral_filter);

%detector_dv = MPD_Detector(wvl, reprate, time_gate, spectral_filter);

telescope_tx = Telescope(diameter_tx, Wavelength = wvl);
telescope_rx = Telescope(diameter_rx, Wavelength = wvl);

telescope_rx.Optical_Efficiency = obscurationRatio(diameter_rx, ...
                                                central_obscuration_ratio_rx);
satellite = Satellite(source_dv, telescope_tx, ...
                      'OrbitDataFileLocation',OrbitDataFileLocation);

ogs = Errol_OGS(detector_dv, telescope_rx);

decoybb84_pass = PassSimulation(satellite, protocol, ogs, Visibility='50km');
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

pos = get (gcf, 'position');
set(0, 'DefaultFigurePosition', pos)

%% Loss plot

elevation_cut_off = 10; % degrees

index = decoybb84_pass.Elevations > elevation_cut_off;
headings = decoybb84_pass.Headings(index);
elevations = decoybb84_pass.Elevations(index);

all_fields = fieldnames(decoybb84_pass.Link_Model);

losses = struct_of_arrays( ...
            decoybb84_pass.Link_Model, [1, sum(index)], ...
            mask = index, ...
            restrict_to = all_fields(contains(all_fields, 'dB')) );

% close all
figure
hold on
index = linspace(1, numel(elevations), numel(elevations));
lim = index(elevations == max(elevations));
loss_fields = fieldnames(losses);
loss_fields = loss_fields(~contains(loss_fields, 'Link_Loss'));
[~, field_order] = sort(cellfun(@(X) sum(losses.(X)), loss_fields), 'descend');
loss_fields = loss_fields(field_order);
a = losses.Geometric_Loss_dB(1:lim);
Elevations = linspace(min(elevations)*2, 180 - min(elevations), numel(elevations));
for i = 1 : numel(loss_fields)
    if any(isnan(losses.(loss_fields{i})))
        continue
    end
    offset = numel(loss_fields) - i + 1;
    b = sum_fields(losses, loss_fields(1:offset));
    area(elevations(1:lim), b(1:lim));
    % area(Elevations, b);
    a = b;
end
xlim([20, 90])
legend(...
    cellfun(@(X) replace(X, '_', ' '), flipud(loss_fields), UniformOutput=false), ...
    Location='southwest')
title(sprintf('Stack Plot of Errors in Satellite Pass (%.3g nm)', wvl))
xlabel('Elevation (\circ)')
ylabel('Loss (dB)');

%% SKR plot
qindex = false(1, numel(decoybb84_pass.Elevations));
qindex(decoybb84_pass.QBERs > min(decoybb84_pass.QBERs)) = true;
[~, max_idx] = max(decoybb84_pass.Elevations);
qindex(max_idx + 1 : end) = false;
figure
hold on
yyaxis left
plot(decoybb84_pass.Elevations(qindex), decoybb84_pass.QBERs(qindex)*100)
ylabel('QBER (%)')
yyaxis right
plot(decoybb84_pass.Elevations(qindex), decoybb84_pass.Secret_Key_Rates(qindex))
ylabel('Secret Key Rate (Bits / s)')
xlabel('Elevation (\circ)')
title(sprintf('QBER & SKR in Satellite Pass (%.3g nm)', wvl))




%% set figure position
pos = get (gcf, 'position');
set(0, 'DefaultFigurePosition', pos)


