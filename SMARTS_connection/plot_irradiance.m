%% Plotting irradiance map from SMARTS data...

close all
clear all
clc


%% Generate Data

ispr = sitePressure(spr=1013.25, altit=0, height=0);
iatmos = atmosphere(atmos='STS');
ih20 = water_vapour(w=1);
i03 = ozone();
igas = gas_atmospheric_absorption(iload=0); 
ico2 = carbon_dioxide(amount=370);
iaeros = aerosol(aeros='S&F_RURAL');
iturb = turbidity(visi=50);
ialbdx = far_field_albedo(spectral_reflectance=38, tilt=45, wazim=0, ialbdg=38);
ialbdx = far_field_albedo(spectral_reflectance=38, tilt=999, wazim=999, ialbdg=38);
isolar = extra_spectral(wlmin=280, wlmax=4000, suncor=1, solarc=1367);
iprt = printing(output_options=linspace(2, 8, 7), wpmn=280, wpmx=4000, intvl=0.5);
icirc = circum_solar(slope=0, apert=2.9, limit=0);
iscan = scanning(filtering=0);
illum = illuminance(value=0);
iuv =  broadband_uv(value=0);
%imass = solar_position_and_airmass(amass=1.5);
imass = solar_position_and_airmass(dateAndTime=datetime('now'), ...
        latitude=56.405, longitude=-3.183);

inputs = {ispr, iatmos, ih20, i03, igas, ico2, iaeros, iturb, ialbdx, ...
          isolar, iprt, icirc, iscan, illum, iuv, imass};

smarts_path = '/home/bp38/Downloads/smarts-295-linux-tar/SMARTS_295_Linux/';
s = SMARTS_input(comment='this is a test', args=inputs, executable_path=smarts_path);
[s, success, destination] = s.run_smarts(file_name='test');
assert(success, 'Something failed...');

start_time = datetime(2022, 8, 15, 0, 0, 0);
end_time = datetime(2022, 8, 15, 23, 0, 0);
times = linspace(start_time, end_time, 24);

file_path = '/home/bp38/Documents/MATLAB/SMARTS/data/';
file_names = cell(size(times));

for i = 1 : numel(times)
    file_name = strrep(strrep(string(times(i)), ' ', '_'), ':', '_');
    file_name = char(file_name);
    disp(times(i));
    file_names{i} = file_name;
    imass = solar_position_and_airmass(dateAndTime=times(i), ...
        latitude=56.405, longitude=-3.183);
    inputs = {ispr, iatmos, ih20, i03, igas, ico2, iaeros, iturb, ialbdx, ...
                isolar, iprt, icirc, iscan, illum, iuv, imass};
    s = SMARTS_input(comment='this is a test', args=inputs, executable_path=smarts_path);
    [s, success, destination] = s.run_smarts(file_path=file_path, file_name=file_name);
    assert(success, 'Something failed...');
end


%% Process Data

diffuse_horizontal_irradiance = zeros(size(file_names));
diffuse_tilted_irradiance = zeros(size(file_names));
direct_horizontal_irradiance = zeros(size(file_names));
direct_tilted_irradiance = zeros(size(file_names));
global_horizontal_irradiance = zeros(size(file_names));
global_tilted_irradiance = zeros(size(file_names));
wavelengths = cell(size(file_names));

for i = 1 : length(file_names)
    data_file = [file_path, file_names{i}, '.ext.txt'];
    data = readtable(data_file);
    if ~isempty(data)
        diffuse_horizontal_irradiance(i) = sum(data.Difuse_horizn_irradiance);
        diffuse_tilted_irradiance(i) = sum(data.Difuse_tilted_irradiance);
        direct_horizontal_irradiance(i) = sum(data.Direct_horizn_irradiance);
        direct_tilted_irradiance(i) = sum(data.Direct_tilted_irradiance);
        global_horizontal_irradiance(i) = sum(data.Global_horizn_irradiance);
        global_tilted_irradiance(i) = sum(data.Global_tilted_irradiance);
    end
end

figure
hold on
plot(times, diffuse_horizontal_irradiance)
plot(times, diffuse_tilted_irradiance)
plot(times, direct_horizontal_irradiance)
plot(times, direct_tilted_irradiance)
plot(times, global_horizontal_irradiance)
plot(times, global_tilted_irradiance)
legend('Diffuse Horizontal', 'Diffuse Tilted', ...
       'Direct Horizontal', 'Direct Tilted', ...
       'Global Horizontal', 'Global Tilted')
xlabel('Time (Hours)');
ylabel('Irradiance  (W / m^2)')
hold off


%% Global tilted irradiance at midday
%%Generate Data
ispr = sitePressure(spr=1013.25, altit=0, height=0);
iatmos = atmosphere(atmos='STS');
ih20 = water_vapour(w=1);
i03 = ozone();
igas = gas_atmospheric_absorption(iload=0); 
ico2 = carbon_dioxide(amount=370);
iaeros = aerosol(aeros='S&F_RURAL');
iturb = turbidity(visi=50);
isolar = extra_spectral(wlmin=280, wlmax=4000, suncor=1, solarc=1367);
iprt = printing(output_options=linspace(2, 8, 7), wpmn=280, wpmx=4000, intvl=0.5);
icirc = circum_solar(slope=0, apert=2.9, limit=0);
iscan = scanning(filtering=0);
illum = illuminance(value=0);
iuv =  broadband_uv(value=0);
imass = solar_position_and_airmass(dateAndTime=datetime(2022, 8, 15, 12, 0, 0), ...
        latitude=56.405, longitude=-3.183);

smarts_path = '/home/bp38/Downloads/smarts-295-linux-tar/SMARTS_295_Linux/';

tilt = linspace(0, 90, 5);
azimuth = linspace(0, 360, (360/7.5) + 1);
file_path = '/home/bp38/Documents/MATLAB/SMARTS/tilted_irradiance/'

file_names = cell(length(azimuth), length(tilt));
for i = 1 : length(azimuth)
    for j = 1 : length(tilt)
        file_name = ['az_', num2str( azimuth(i) ), ...
                     '-tilt_', num2str( tilt(j) ) ];
        ialbdx = far_field_albedo(spectral_reflectance=38, ...
                                  tilt=tilt(j), wazim=azimuth(i), ialbdg=38);
        inputs = {ispr, iatmos, ih20, i03, igas, ico2, iaeros, iturb, ialbdx, ...
                    isolar, iprt, icirc, iscan, illum, iuv, imass};
        s = SMARTS_input(comment='this is a test', args=inputs, executable_path=smarts_path);
        [s, success, destination] = s.run_smarts(file_path=file_path, file_name=file_name);
        assert(success, 'Something failed...');
        file_names(i, j) = {file_name};
    end
end

%%Process Data
diffuse_tilted_irradiance = zeros(size(file_names));
direct_tilted_irradiance = zeros(size(file_names));
global_tilted_irradiance = zeros(size(file_names));

bandpass = @(array, wvl, width) (array > (wvl - (width/2))) & ((array < (wvl + (width/2))));

for i = 1 : length(azimuth)
    for j = 1 : length(tilt)
        data_file = [file_path, file_names{i,j}, '.ext.txt'];
        data = readtable(data_file);
        wavelengths = data.Wvlgth;
        wl = 850;
        width = 5;
        wavelengths = wavelengths / 1000;
        % diffuse_tilted_irradiance(i,j) = sum(data.Difuse_tilted_irradiance);
        % direct_tilted_irradiance(i,j) = sum(data.Direct_tilted_irradiance);
        % global_tilted_irradiance(i,j) = sum(data.Global_tilted_irradiance);
        diffuse_tilted_irradiance(i,j) = sum(data.Difuse_tilted_irradiance ./ wavelengths);
        direct_tilted_irradiance(i,j) = sum(data.Direct_tilted_irradiance ./ wavelengths);
        global_tilted_irradiance(i,j) = sum(data.Global_tilted_irradiance ./ wavelengths);
        % diffuse_tilted_irradiance(i,j) = sum(data.Difuse_tilted_irradiance(bandpass(wavelengths, wl, width)));
        % direct_tilted_irradiance(i,j) =  sum(data.Direct_tilted_irradiance(bandpass(wavelengths, wl, width)));
        % global_tilted_irradiance(i,j) =  sum(data.Global_tilted_irradiance(bandpass(wavelengths, wl, width)));
    end
end

[X,Y] = meshgrid(azimuth,tilt);

n_contours = 500;

figure
hold on
title('Diffuse Tilted Irradiance (W / m^2 / sr / \mu m)');
contourf(X, Y, diffuse_tilted_irradiance' ./ (2*pi) ,n_contours, 'LineColor','none')
colorbar;
xlabel('Time (Hours)');
ylabel('Tilt Angle (\circ)')
hold off

figure
hold on
title('Direct Tilted irradiance (W / m^2 / sr / \mu m)');
contourf(X, Y, direct_tilted_irradiance' ./ (2*pi) ,n_contours, 'LineColor','none')
colorbar;
xlabel('Time (Hours)');
ylabel('Tilt Angle (\circ)')
hold off

figure
hold on
title('Global Tilted irradiance (W / m^2 / sr / \mu m)');
contourf(X, Y, global_tilted_irradiance' ./ (2*pi) ,n_contours, 'LineColor','none')
colorbar;
xlabel('Time (Hours)');
ylabel('Tilt Angle (\circ)')
hold off

%% sky photons

h = 6.62607015*10^-34; % plank's constant
c = 299792458; % speed of light

N_SKY_PHOTONS = @(RADIANCE, RX_D, FOV, WL, DWL, DT) ...
            (RADIANCE .* (FOV * pi * (RX_D^2) * WL * DWL * DT)) ...
            ./ (4 * h * c);

fd2fov = @(fd_arcmin) 2 * pi ...
                      * (1 - cos(deg2rad((fd_arcmin ./ 60) ./ 2)));

telescope_field_diameter = 16.35;
fov = fd2fov(telescope_field_diameter);

wl = 850;
width = 1;
wavelengths = data.Wvlgth;
wl_filter = bandpass(wavelengths, wl, width);

difuse_tilted_radiance = data.Difuse_tilted_irradiance(wl_filter) ./ (2 * pi);

N_sky_photons = N_SKY_PHOTONS(...
                difuse_tilted_radiance, 0.7, fov, wl * (1e-9), width * (1e-9), ...
                1); % 1 second integration time (DT in ...
                    % N_SKY_PHOTONS) gives us total number of 
                    % counts per second
                %Ground_Station.Detector.Time_Gate_Width);


sky_photons_diffuse = zeros(size(file_names));
sky_photons_direct = zeros(size(file_names));
sky_photons_global = zeros(size(file_names));

for i = 1 : length(azimuth)
    for j = 1 : length(tilt)
        data_file = [file_path, file_names{i,j}, '.ext.txt'];
        data = readtable(data_file);
        wavelengths = data.Wvlgth;
        wl = 850;
        width = 1;
        difuse_tilted_radiance = data.Difuse_tilted_irradiance(wl_filter) ./ (2 * pi);
        N_sky_photons = N_SKY_PHOTONS(difuse_tilted_radiance, 0.7, fov, ...
                                      wl * (1e-9), width * (1e-9), 1);

        sky_photons_diffuse(i,j) = sum(N_sky_photons);

        direct_tilted_radiance = data.Direct_tilted_irradiance(wl_filter) ./ (2 * pi);
        N_sky_photons = N_SKY_PHOTONS(direct_tilted_radiance, 0.7, fov, ...
                                      wl * (1e-9), width * (1e-9), 1);

        sky_photons_direct(i,j) = sum(N_sky_photons);

        global_tilted_radiance = data.Global_tilted_irradiance(wl_filter) ./ (2 * pi);
        N_sky_photons = N_SKY_PHOTONS(global_tilted_radiance, 0.7, fov, ...
                                      wl * (1e-9), width * (1e-9), 1);

        sky_photons_global(i,j) = sum(N_sky_photons);
    end
end

figure
hold on
title('Sky photons (Hz) from Diffuse Tilted irradiance');
contourf(X, Y, sky_photons_diffuse', n_contours, 'LineColor','none')
colorbar;
xlabel('Azimuth (\circ)');
ylabel('Tilt Angle (\circ)')
hold off

figure
hold on
title('Sky photons (Hz) from Direct Tilted irradiance');
contourf(X, Y, sky_photons_direct', n_contours, 'LineColor','none')
colorbar;
xlabel('Azimuth (\circ)');
ylabel('Tilt Angle (\circ)')
hold off

figure
hold on
title('Sky photons (Hz) from Global Tilted irradiance');
contourf(X, Y, sky_photons_global', n_contours, 'LineColor','none')
colorbar;
xlabel('Azimuth (\circ)');
ylabel('Tilt Angle (\circ)')
hold off

