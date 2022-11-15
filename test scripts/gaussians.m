%% gaussians
clear all
close all

xrange = @(centre, width, points) linspace(centre - width / 2, ...
                                           centre + width / 2, ...
                                           points);

sigma = @(FWHM) 1 / (2 * sqrt(2 * log(2)) * FWHM);

gaussian = @(X, MU, SIGMA) ( 1 / (SIGMA * sqrt(2*pi)) ) ...
                           * exp( -((X - MU).^2) / (2 * (SIGMA^2)));

fwhmFromExponentialWidth = @(WIDTH) (2 * WIDTH * sqrt(log(2))) / sqrt(2);

normaliseToMeanPhotonNumber = @(GAUSSIAN, N_BAR) GAUSSIAN ...
                                                 * (N_BAR / sum(GAUSSIAN));

wl_central = 550;
filter_width = 5;
wl_range = xrange(wl_central, filter_width, 1001);

filterBounds = @(fw, wl) wl + ((fw * 0.55) .* [-1, 1]);
bounds = filterBounds(filter_width, wl_central);

y_arr = normaliseToMeanPhotonNumber(...
            gaussian(wl_range, ...
                     wl_central, ...
                     sigma(fwhmFromExponentialWidth(filter_width))), ...
            0.5);

wvl = 808;
n_ph_opts = linspace(0.3, 0.8, 6);
n_ph = n_ph_opts(1);
reprate = 50e6;
time_gate = 10^-9;
spectral_filter = 1; 
dcr = 1000; % optionally 200

detector_dv = MPD_Detector(wvl, reprate, time_gate, spectral_filter);
detector_dv = Excelitas_Detector(wvl, reprate, time_gate, spectral_filter);
det_wl = detector_dv.Valid_Wavelength;
det_eff = detector_dv.Detector_Efficiency_arr;

pw_poly = interp1(detector_dv.Valid_Wavelength, ...
                  detector_dv.Detector_Efficiency_arr, 'cubic', 'pp');

detected_photon_number = y_arr .* ppval(pw_poly, wl_range);

figure
hold on
plot(wl_range, y_arr)
plot(wl_range, detected_photon_number)
yyaxis right
plot(wl_range, ppval(pw_poly, wl_range))
hold off

figure
plot(wl_range, detected_photon_number * reprate)

smarts_data_path = '/home/bp38/Documents/MATLAB/SMARTS/PassAt11/150.ext.txt';
data = readtable(smarts_data_path);

mask = (data.Wvlgth > detector_dv.Valid_Wavelength(1)) & (data.Wvlgth < detector_dv.Valid_Wavelength(end));

figure
hold on
plot(data.Wvlgth(mask), data.Global_tilted_irradiance(mask))
yyaxis right
plot(data.Wvlgth(mask), ppval(pw_poly, data.Wvlgth(mask)))

powerAtDetector = data.Global_tilted_irradiance(mask) ...
                  .* ppval(pw_poly, data.Wvlgth(mask));

figure
hold on
plot(data.Wvlgth(mask), powerAtDetector)

h = 6.62607015*10^-34; % plank's constant
c = 299792458; % speed of light

photonEnergy = (h * c) ./ (data.Wvlgth(mask) .* (1e-9));

figure
hold on
plot(data.Wvlgth(mask), powerAtDetector ./ photonEnergy)

N_SKY_PHOTONS = @(RADIANCE, RX_D, FOV, WL, DWL, DT) ...
            (RADIANCE .* (FOV .* pi .* (RX_D^2) .* WL .* DWL .* DT)) ...
            ./ (4 * h * c);

fd2fov = @(fd_arcmin) 2 * pi ...
                      * (1 - cos(deg2rad((fd_arcmin ./ 60) ./ 2)));

telescope_field_diameter = 16.35;
fov = fd2fov(telescope_field_diameter);

radiance = data.Global_tilted_irradiance(mask) ./ (2 * pi);
wvl = data.Wvlgth(mask) * (1e-9);

sky_photons = N_SKY_PHOTONS(radiance, 0.8, fov, wvl, wvl(end) - wvl(1), 1);
sum(sky_photons .* ppval(pw_poly, data.Wvlgth(mask)))

figure
plot(wvl * 1e9, radiance)
yyaxis right
plot(wvl * (1e9), sky_photons)

figure
plot(wvl * (1e9), sky_photons .* ppval(pw_poly, data.Wvlgth(mask)))

figure
plot(data.Global_tilted_irradiance / (4 * pi))

sky_photons = N_SKY_PHOTONS(radiance, 0.8, fov, wvl, wvl(end) - wvl(1), 1);

nm2um = @(nanometres) nanometres ./ (1e3);

figure
plot(N_SKY_PHOTONS(data.Global_tilted_irradiance / (4 * pi), ...
                   0.7, fov, nm2um(data.Wvlgth), 0.5e-3, 1) )

% N_SKY_PHOTONS = @(RADIANCE, RX_D, FOV, WL, DWL, DT) ...
%             (RADIANCE .* (FOV .* pi .* (RX_D^2) .* WL .* DWL .* DT)) ...
%             ./ (4 * h * c);

% this is the solution...
sum(...
    N_SKY_PHOTONS(data.Global_tilted_irradiance / (4 * pi), ...
                  1, 1e-2, nm2um(data.Wvlgth), 0.5e-3, 1) ...
    .* ((h * c) ./ (data.Wvlgth .* (1e-9)))...
    )

fovs = linspace(1e-5, 1, 10);
fovs = 10 .^ linspace(-5, 2, 20);

collected_light = arrayfun(@(FOV) sum(...
                N_SKY_PHOTONS(data.Global_tilted_irradiance / (4 * pi), ...
                              1, FOV, nm2um(data.Wvlgth), 0.5e-3, 1) ...
                .* ((h * c) ./ (data.Wvlgth .* (1e-9)))...
                ), fovs);
figure
plot(fovs, collected_light)

irradiance2radiance = @(IRR) IRR ./ (4 * pi);

figure
hold on
plot(data.Wvlgth, N_SKY_PHOTONS(...
                        irradiance2radiance(data.Global_tilted_irradiance), ...
                        0.7, fov, nm2um(data.Wvlgth), 0.5e-3, 1) )

plot(data.Wvlgth, N_SKY_PHOTONS(...
                        irradiance2radiance(data.Difuse_tilted_irradiance), ...
                        0.7, fov, nm2um(data.Wvlgth), 0.5e-3, 1) )

plot(data.Wvlgth, N_SKY_PHOTONS(...
                        irradiance2radiance(data.Direct_normal_irradiance), ...
                        0.7, fov, nm2um(data.Wvlgth), 0.5e-3, 1) )

legend('Global Tilted', 'Diffuse Tilted', 'Direct Normal')


mask = (data.Wvlgth > detector_dv.Valid_Wavelength(1) ...
         & data.Wvlgth < detector_dv.Valid_Wavelength(end))

det_eff = ppval(pw_poly, data.Wvlgth .* mask);

nm2m = @(arr) arr.* (1e-9);
irradiance2radiance = @(IRR, WVL) (IRR ./ WVL) ./ (4 * pi);

figure
width = 1e-9; %nm
hold on
gt = plot(data.Wvlgth, N_SKY_PHOTONS(...
                        irradiance2radiance(data.Global_tilted_irradiance, data.Wvlgth .* (1e-9)), ...
                        0.7, fov, nm2m(data.Wvlgth), width, 1) .* mask .* det_eff)

dt = plot(data.Wvlgth, N_SKY_PHOTONS(...
                        irradiance2radiance(data.Difuse_tilted_irradiance, data.Wvlgth .* (1e-9)), ...
                        0.7, fov, nm2m(data.Wvlgth), width, 1) .* mask .* det_eff)

dn = plot(data.Wvlgth, N_SKY_PHOTONS(...
                        irradiance2radiance(data.Direct_normal_irradiance, data.Wvlgth .* (1e-9)), ...
                        0.7, fov, nm2m(data.Wvlgth), width, 1) .* mask .* det_eff)

legend('Global Tilted', 'Diffuse Tilted', 'Direct Normal')
xlim([detector_dv.Valid_Wavelength(1), detector_dv.Valid_Wavelength(end)])

dtTemplate = get(dt, 'DataTipTemplate')
dtTemplate.DataTipRows(1).Format = '%d'
dtTemplate.DataTipRows(2).Format = '%.3g'

figure
width = 1e-9; %nm
hold on
gt = plot(data.Wvlgth, N_SKY_PHOTONS(...
                        irradiance2radiance(data.Global_tilted_irradiance), ...
                        0.7, fov, nm2m(data.Wvlgth), width, 1) .* mask .* det_eff)

dt = plot(data.Wvlgth, N_SKY_PHOTONS(...
                        irradiance2radiance(data.Difuse_tilted_irradiance), ...
                        0.7, fov, nm2m(data.Wvlgth), width, 1) .* mask .* det_eff)

dn = plot(data.Wvlgth, N_SKY_PHOTONS(...
                        irradiance2radiance(data.Direct_normal_irradiance), ...
                        0.7, fov, nm2m(data.Wvlgth), width, 1) .* mask .* det_eff)

legend('Global Tilted', 'Diffuse Tilted', 'Direct Normal')
xlim([detector_dv.Valid_Wavelength(1), detector_dv.Valid_Wavelength(end)])


% tipXLoc = [759]; %, 768, 761, 850];
% for txl = tipXLoc
%     datatip(dt, 'DataIndex', txl);
% end


N_SKY_PHOTONS_DL = @(RADIANCE, WL, DWL, DT) ...
            ( ((1.22 * pi)^2) .* RADIANCE .* (WL.^3) .* DWL .* DT ) ...
            ./ (4 * h * c);
figure
hold on
gt = plot(data.Wvlgth, N_SKY_PHOTONS_DL(...
                        irradiance2radiance(data.Global_tilted_irradiance, data.Wvlgth .* (1e-9)), ...
                        nm2m(data.Wvlgth), width, 1) .* mask .* det_eff)

dt = plot(data.Wvlgth, N_SKY_PHOTONS_DL(...
                        irradiance2radiance(data.Difuse_tilted_irradiance, data.Wvlgth .* (1e-9)), ...
                        nm2m(data.Wvlgth), width, 1) .* mask .* det_eff)

dn = plot(data.Wvlgth, N_SKY_PHOTONS_DL(...
                        irradiance2radiance(data.Direct_normal_irradiance, data.Wvlgth .* (1e-9)), ...
                        nm2m(data.Wvlgth), width, 1) .* mask .* det_eff)

legend('Global Tilted', 'Diffuse Tilted', 'Direct Normal')
xlim([detector_dv.Valid_Wavelength(1), detector_dv.Valid_Wavelength(end)])


irradiance2radiance(data.Global_tilted_irradiance, data.Wvlgth ./ (1e-9))

figure
hold on
width = 1e-9
gt = plot(data.Wvlgth, N_SKY_PHOTONS_DL(...
                        irradiance2radiance(data.Global_tilted_irradiance, data.Wvlgth .* (1e-9)), ...
                        data.Wvlgth .* (1e-9), width, 1) .* mask .* det_eff)

dt = plot(data.Wvlgth, N_SKY_PHOTONS_DL(...
                        irradiance2radiance(data.Difuse_tilted_irradiance, data.Wvlgth .* (1e-9)), ...
                        data.Wvlgth .* (1e-9), width, 1) .* mask .* det_eff)

dn = plot(data.Wvlgth, N_SKY_PHOTONS_DL(...
                        irradiance2radiance(data.Direct_normal_irradiance, data.Wvlgth .* (1e-9)), ...
                        data.Wvlgth .* (1e-9), width, 1) .* mask .* det_eff)

legend('Global Tilted', 'Diffuse Tilted', 'Direct Normal')
xlim([detector_dv.Valid_Wavelength(1), detector_dv.Valid_Wavelength(end)])
