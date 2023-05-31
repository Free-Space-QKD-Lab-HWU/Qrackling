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
clc

stdatm = StandardAtmosphere();

N = 10;
A = linspace(0, 85, N);
A = [0, 5, 7, 11, 15, 20, 32, 47, 51, 71, 84.8];
A = [5, 7, 11, 15, 20, 32, 47, 51, 71, 84.8];

o = OrderOfMagnitude.nano;
n = stdatm.AtmosphericRefractiveIndex(840, A, WavelengthUnit=o);
n = ([27340, 14660, 11142, 6141, 3268, 1485, 235, 34, 21, 1, 0.1] ./ (1e8)) + 1;
n = ([14660, 11142, 6141, 3268, 1485, 235, 34, 21, 1, 0.1] ./ (1e8)) + 1;
Z = deg2rad(45);
A_sat = 400;


details = PathElongation(Z, A, 400, n);
disp(['Lengths: -> ', num2str(details.Length)])
disp(['Length in vacuum: -> ', num2str(details.Length_N)])
(sum(details.Length) + details.Length_N) / details.SlantRange

%%


details.SlantRange
details.Length
details.Length(1)

disp(['Length of arrays', newline, 'Name', char(9), 'X, Y'])
for fn = fieldnames(details)'
    disp([fn{1}, char(9), num2str(size(details.(fn{1})))])
end

(sum(details.Length) + details.Length_N) / details.SlantRange





