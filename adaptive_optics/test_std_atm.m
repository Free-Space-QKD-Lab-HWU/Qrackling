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
