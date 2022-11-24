%% reading a csv

close all
clear all

%data = readtable('perkin_elmer_efficiency.csv');
%data = readtable('MPD_efficiency.csv');
%data = readtable('LaserComponents_efficiency.csv');
%data = readtable('excelitas_efficiency.csv');
%data = readtable('Hamamatsu_efficiency.csv');
%data = readtable('quantum_opus_1550.csv');
data = readtable('quantum_opus_840.csv');
wavelengths = data.Var1 .* (1e3);
efficiency = data.Var2;
% if max(efficiency) > 1
%     efficiency = efficiency ./ 100;
% end

disp(wavelengths)
disp(efficiency)

figure
plot(wavelengths, efficiency)

a = 700;
b = 985;
wvl = linspace(a, b, b - a +1);
pw_poly = interp1(wavelengths, efficiency, 'cubic', 'pp');
interpolated = ppval(pw_poly, wvl);
% first = max(wvl((wvl < mean(wvl)) & (interpolated < 0)));
% final = min(wvl((wvl > mean(wvl)) & (interpolated < 0)));
% mask = (wvl > first) & (wvl < final)

size(wvl)
figure
%plot(wavelengths, efficiency)
plot(wvl, interpolated, 'red')

wavelengths = wvl;
efficiency = interpolated;
save('/home/bp38/Documents/MATLAB/quantum_opus_840_efficiency.mat', 'wavelengths', 'efficiency')

%% picking efficiency
data = load('MPD_efficiency.mat')
figure
plot(data.wavelengths, data.efficiency)

wvl = 780.4;
in_range = sum(data.wavelengths == wvl);

if ~in_range
    pw_poly = interp1(data.wavelengths, data.efficiency, 'cubic', 'pp');
    eff = ppval(pw_poly, wvl);
end
disp(eff)


