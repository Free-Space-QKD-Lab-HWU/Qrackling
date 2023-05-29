%% run
clear all
close all
clc

stdatm = StandardAtmosphere()

N = 1000;
A = linspace(0, 100, N);
mask = stdatm.StepMask(A);
H = stdatm.height(mask);
T = stdatm.temperature(mask);
L = stdatm.temperature_gradient(mask);
P = stdatm.pressure(mask);

g = 9.8;
R = 287.053;

expo = -g .* L ./ R;

T = ppval(stdatm.temperature_lerp, A);
P = ppval(stdatm.pressure_lerp, A);
p = P .* exp(-(A-H) .* g ./ (R .* T));

% figure
% hold on
% plot(p, A)
% xlim([-50, 800])
% 
% figure
% hold on
% plot(T, A)

n = stdatm.RefractiveIndex(840, A, WavelengthUnit=OrderOfMagnitude.nano);
figure
hold on
plot((n-1) .* (1e5), A)
set(gca, 'xdir', 'reverse')
