%% run
clear all
close all

%% run smarts

ispr = sitePressure(spr=1013.25, altit=0, height=0);
iatmos = atmosphere(tair=10, atmos='USSA');
ih20 = water_vapour(w=1);
i03 = ozone();
igas = gas_atmospheric_absorption(iload=4); 
ico2 = carbon_dioxide(amount=400);
iaeros = aerosol(aeros='S&F_RURAL');
iturb = turbidity(visi=23);

ialbdx = far_field_albedo(spectral_reflectance=-1, rhox=0, ...
                          tilt=0, wazim=0 , ialbdg=-1, rhog=0);

isolar = extra_spectral(wlmin=280, wlmax=4000, ...
                        suncor=1, solarc=1367);

iprt = printing(output_options=linspace(1, 43, 43), ...
                wpmn=280, wpmx=4000, intvl=0.5);

icirc = circum_solar(slope=0, apert=2.9, limit=0);
iscan = scanning(filtering=0);
illum = illuminance(value=0);
iuv =  broadband_uv(value=0);
imass = solar_position_and_airmass(dateAndTime=datetime(2022, 8, 15, 12, 0, 0), ...
                                   latitude=0, longitude=0);
imass = solar_position_and_airmass(zenith=0, azimuth=0);

defaults = {ispr, iatmos, ih20, i03, igas, ico2, iaeros, ...
            iturb, ialbdx, isolar, iprt, icirc, iscan, ...
            illum, iuv, imass};

smarts_path = '/home/bp38/Downloads/smarts-295-linux-tar/SMARTS_295_Linux/';
results_path = '/home/bp38/Documents/MATLAB/SMARTS/smarts_modtran/';

configuration = SMARTS_input(comment = 'Errol_airstrip', ...
                         args = defaults, ...
                         executable_path = smarts_path, ...
                         stub = results_path);

file_name = 'comparison';
[configuration, success, destination] = ...
            configuration.run_smarts(file_path=results_path, ...
                                     file_name = 'comparison');

% %% read data 

file_path = [results_path, file_name, '.ext.txt'];
data = readtable(file_path, 'VariableNamingRule', 'preserve');
wavelength = data.Wvlgth;
irradiance = data.Direct_normal_irradiance;
irradiance = data.Global_horizn_irradiance;

disp(data.Properties.VariableNames')


% %% plot irradiance and radiance
nm2um = @(nm) nm ./ (1e3);

close all

figure
hold on

prefactor = nm2um(wavelength) ./ (4 * pi);
prefactor = wavelength .* 10;
% prefactor = 1;

plot(nm2um(wavelength), data.("Beam_normal_+circumsolar") ./ wavelength .* 100)
plot(nm2um(wavelength), data.Global_horizn_irradiance ./ wavelength .* 100)
plot(nm2um(wavelength), data.Direct_normal_irradiance ./ wavelength .* 100)
plot(nm2um(wavelength), data.Difuse_horizn_irradiance ./ wavelength .* 100)
plot(nm2um(wavelength), data.Global_horizn_irradiance ./ wavelength .* 100)
plot(nm2um(wavelength), data.Direct_horizn_irradiance ./ wavelength .* 100)
plot(nm2um(wavelength), data.Direct_tilted_irradiance ./ wavelength .* 100)
plot(nm2um(wavelength), data.Difuse_tilted_irradiance ./ wavelength .* 100)
plot(nm2um(wavelength), data.Global_tilted_irradiance ./ wavelength .* 100)
legend([ ...
    "Beam normal +circumsolar", ...
    "Global horizn irradiance", ...
    "Direct normal irradiance", ...
    "Difuse horizn irradiance", ...
    "Global horizn irradiance", ...
    "Direct horizn irradiance", ...
    "Direct tilted irradiance", ...
    "Difuse tilted irradiance", ...
    "Global tilted irradiance", ...
    ])


xlim([0.4, 1])


irradiance = data.("Beam_normal_+circumsolar");
irradiance = data.Difuse_tilted_irradiance;
irradiance = data.("Difuse_horiz-circumsolar");

figure
subplot(1, 2, 1)
hold on
plot(nm2um(wavelength), irradiance ./  nm2um(wavelength))
xlabel('wavelength (microns)')
% ylabel('irradiance (W/cm^{2})')
xlim([0.4, 1])

subplot(1, 2, 2)
hold on
plot(nm2um(wavelength), irradiance ./ wavelength ./ (4*pi) .* 100); % ./ ((1e-4) .* (wavelength.*1000) .* (4 * pi)) )
xlabel('wavelength (microns)')
ylabel('radiance (W/cm^{2}/{\mu}m/sr)')
xlim([0.4, 1])

% so is the takeaway here that W / cm^2 / um / sr is equivalent to W / m^2 / nm / sr?
% if that is the case then we can get the same results as MODTRAN...
