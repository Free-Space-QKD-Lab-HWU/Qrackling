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
title('Pressure')
plot(p, A)
xlim([-50, 800])

o = OrderOfMagnitude.nano;
n = stdatm.AtmosphericRefractiveIndex(840, A, WavelengthUnit=o);
refr = (n-1) .* (1e5);
figure
hold on
title('Refractive Index')
plot(refr, A)
xlim([-1, max(refr)])
set(gca, 'xdir', 'reverse')

n = stdatm.AltitudeDependentRefractiveIndex(840, A, WavelengthUnit=o);
refr = (n-1) .* (1e5);
figure
hold on
title('Refractive Index')
plot(refr, A)
xlim([-1, max(refr)])
set(gca, 'xdir', 'reverse')

zenith_deg = linspace(0, 90, 10);
zenith = deg2rad(zenith_deg);


%% new
close all
clear all

stdatm = StandardAtmosphere();

N = 10;
A = [5, 7, 11, 15, 20, 32, 47, 51, 71, 84.8];
% A = linspace(0, 84.8, 10);

o = OrderOfMagnitude.nano;
n = stdatm.AtmosphericRefractiveIndex(840, A, WavelengthUnit=o);
% n = ([27340, 14660, 11142, 6141, 3268, 1485, 235, 34, 21, 1, 0.1] ./ (1e8)) + 1;
% n = ([14660, 11142, 6141, 3268, 1485, 235, 34, 21, 1, 0.1] ./ (1e8)) + 1;

satellite_altitudes = [400, 780, 1200]; % km
% zeniths = linspace(-90, 90, 100);
N = 1000;
% zeniths = linspace(0, 90, N);
zeniths = linspace(45, 90, 100);
zeniths_rad = deg2rad(zeniths);


labels = {};
figure
hold on
i = 1;
for a_sat = satellite_altitudes
    epsilon = PathElongation.ElongationFactor(zeniths_rad, A, a_sat, n);
    labels{i} = [num2str(a_sat), 'km'];
    l1 = plot(zeniths, epsilon);
    i = i + 1;
    epsilon = PathElongation.ElongationFactor(zeniths_rad, A, a_sat, n, UseApparentZenith=false);
    labels{i} = [num2str(a_sat), 'km (True zenith)'];
    plot(zeniths, epsilon, color=l1.Color , LineStyle='--')
    i = i + 1;
end
legend(labels);
xlim([min(zeniths), max(zeniths)])
ylim([0.95,1.35])

%% test
close all
clear all
clc

A = [5, 7, 11, 15, 20, 32, 47, 51, 71, 84.8];
A = linspace(5, 35, 7);
cn2_b = HufnagelValley.HV15_12.Calculate(A);
disp(['Target: ', num2str(cn2_b)])

cn2 = AFGL_Plus() ...
    .UsingWindModel(BuftonWindProfile.Pugh_2020) ...
    .UsingAtmosphereProfile(StandardAtmosphere) ...
    .RefractiveIndexStructureConstant(A);
disp(['Result: ', num2str(cn2)]) % values produced are too big...


%% HWM (wind model)
A = linspace(5, 85, 81) .* (1e3);
latitude = 48 .* ones(size(A))';
longitude = 11.5 .* ones(size(A))';
day = 236 .* ones(size(A))';

wind_speed = atmoshwm(latitude, longitude, A, day=day);
meridional_wind_speed = wind_speed(:, 1);
zonal_wind_speed = wind_speed(:, 2);

meridional_wind_shear = gradient(wind_speed(:, 1), A);
zonal_wind_shear = gradient(wind_speed(:, 2), A);

figure
subplot(1, 2, 1)
hold on
title('Wind Speed')
plot(meridional_wind_speed, A ./ (1e3))
plot(zonal_wind_speed, A ./ (1e3))
legend('Meridional', 'Zonal')
subplot(1, 2, 2)
hold on
title('Wind Shear')
plot(meridional_wind_shear, A ./ (1e3))
plot(zonal_wind_shear, A ./ (1e3))
legend('Meridional', 'Zonal')

%% test

A = linspace(5, 85, 81) .* (1e3);
n = 100;
latitude = linspace(-180, 180, n)';
longitude = linspace(-90, 90, n)';

[la, lo] = meshgrid(latitude, longitude);
A = 30 .* ones(size(la));
day = 236 .* ones(size(la));

wind_speed = atmoshwm(la, lo, A, day=day);
% meridional_wind_speed = wind_speed(:, 1);
% zonal_wind_speed = wind_speed(:, 2);

%% new

fp = FriedParameter("Downlink", "Hufnagel_Valley", "HV5_7");
fp = FriedParameter("Uplink", "AirForceGeophysicsLab", AFGL_Plus);

AFGL_Plus(StandardAtmosphere, BuftonWindProfile.Pugh_2020)
AFGL_Plus(StandardAtmosphere, @atmoshwm)

AFGL_Plus.StandardAtmosphere_Bufton_Pugh2020

clear all
clc
semilogy(AFGL_Plus.StandardAtmosphere_HWM.Calculate(linspace(5, 85, 81)))


fp = FriedParameter("Downlink", "AirForceGeophysicsLab", "StandardAtmosphere_HWM")

AFGL_Plus.StandardAtmosphere_HWM
