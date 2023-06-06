%% run
clear all
close all
clc

stdatm = StandardAtmosphere()

N = 1000;
A = linspace(0, 85, N);

p = stdatm.Pressure(A);
figure
hold on
plot(p, A)
xlim([-50, 800])

o = OrderOfMagnitude.nano;
n = stdatm.AtmosphericRefractiveIndex(840, A, WavelengthUnit=o);
refr = (n-1) .* (1e5);
figure
hold on
plot(refr, A)
xlim([-1, max(refr)])
set(gca, 'xdir', 'reverse')

n = stdatm.AltitudeDependentRefractiveIndex(840, A, WavelengthUnit=o);
refr = (n-1) .* (1e5);
figure
hold on
plot(refr, A)
xlim([-1, max(refr)])
set(gca, 'xdir', 'reverse')

zenith_deg = linspace(0, 90, 10);
zenith = deg2rad(zenith_deg);

n = stdatm.AtmosphericRefractiveIndex(840, A, WavelengthUnit=o);
r = PathElongation.BendingAngle(deg2rad(45), n, A);
figure
hold on
plot(A(1:numel(r)), r)
xlim([-1, A(end)])

n = stdatm.AtmosphericRefractiveIndex(840, A, WavelengthUnit=o);
r = PathElongation.BendingAngle2(deg2rad(45), n, A);
figure
hold on
plot(A(2:end), r)
xlim([-1, A(end)])

figure
hold on
b = PathElongation.Beta(deg2rad(45), n, A);
plot(A(1:end-1), tan(b(2:end)) - tan(b(1:end-1)))

[n_1, dndh, kernel] = PathElongation.BendingAngle(deg2rad(45), n, A);

figure
plot(n_1)

figure
plot(dndh)

figure
plot(kernel)


size(dndh)
size(kernel)
figure
plot(n_1(1:996) .* A(1:996), dndh(1:996) ./ kernel)


%% new
close all
clear all

stdatm = StandardAtmosphere();

N = 10;
A = [5, 7, 11, 15, 20, 32, 47, 51, 71, 84.8];
% A = linspace(0, 84.8, 10);

o = OrderOfMagnitude.nano;
% n = stdatm.AtmosphericRefractiveIndex(840, A, WavelengthUnit=o);
% n = ([27340, 14660, 11142, 6141, 3268, 1485, 235, 34, 21, 1, 0.1] ./ (1e8)) + 1;
n = ([14660, 11142, 6141, 3268, 1485, 235, 34, 21, 1, 0.1] ./ (1e8)) + 1;

satellite_altitudes = [400, 780, 1200]; % km
% zeniths = linspace(-90, 90, 100);
N = 1000;
zeniths = linspace(0, 90, N);
% zeniths = linspace(45, 90, 100);
zeniths_rad = deg2rad(zeniths);

labels = {};
figure
hold on
i = 1;
for a_sat = satellite_altitudes;
    epsilon = PathElongation.PathElongationFactors(zeniths_rad, A, a_sat, n);
    labels{i} = [num2str(a_sat), 'km'];
    l1 = plot(zeniths, epsilon);
    i = i + 1;
    epsilon = PathElongation.PathElongationFactors(zeniths_rad, A, a_sat, n, UseApparentZenith=false);
    labels{i} = [num2str(a_sat), 'km (True zenith)'];
    plot(zeniths, epsilon, color=l1.Color , LineStyle='--')
    i = i + 1;
end
legend(labels);
ylim([0.95,1.35])
%ylim([0.8,max(epsilon)])

labels = {};
figure
hold on
for i = 1:numel(satellite_altitudes)
    a_sat = satellite_altitudes(i);
    epsilon = PathElongation.PathElongationFactors(zeniths_rad, A, a_sat, n, UseApparentZenith=false);
    labels{i} = [num2str(a_sat), 'km'];
    plot(zeniths, epsilon)
end
legend(labels);
ylim([0.95,1.35])

% need to compare PathElongation.PathLength against PathElongation.SlantRange
% and ensure that for angles in PathLength close to zenith they overlap

%%
re = PathElongation.Earth_Radius;
hn = A(end);
ha = A_sat;

zeniths = linspace(0, 90, 100);

lv = sqrt( ...
    ((re + hn) .^ 2) ...
    + ((re + ha) .^ 2) ...
    - (2 .* (re + hn) .* (re + ha) .* cosd(zeniths)));

lr = slant_range(ha, zeniths, earth_radius=re);

figure
hold on
plot(zeniths, lv)
plot(zeniths, lr)
legend('vacuum', 'range')
%ylim([0,max([max(lv), max(lr)])])
