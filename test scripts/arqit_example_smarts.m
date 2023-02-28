%% run

clear all
% close all

ispr   = sitePressure(spr=1013.25, altit=0, height=0);
iatmos = atmospherecard(atmos='MLS');
ih20   = water_vapour(w=1);
i03    = ozone();
igas   = gas_atmospheric_absorption(iload=4);
ico2   = carbon_dioxide(amount=370);
iaeros = aerosol(aeros='S&F_RURAL');
iturb  = turbidity(visi=50);
wlmin  = 800;
wlmax  = 900;
ialbdx = far_field_albedo(spectral_reflectance=40, tilt=10, wazim=-999, ialbdg=38);
isolar = extra_spectral(wlmin=wlmin, wlmax=wlmax, suncor=1);
iprt   = printing(output_options=linspace(1, 43, 43), wpmn=wlmin, wpmx=wlmax, intvl=1);
icirc  = circum_solar(slope=0, apert=2.9, limit=0);
iscan  = scanning(filtering=0);
illum  = illuminance(value=0);
iuv    = broadband_uv(value=0);
imass  = solar_position_and_airmass(dateAndTime=datetime(2022, 8, 15, 12, 0, 0), ...
            latitude=56.405, longitude=-3.183);

defaults = {ispr,  iatmos, ih20,   i03,  igas,  ico2,  iaeros, ...
            iturb, ialbdx, isolar, iprt, icirc, iscan, ...
            illum, iuv,    imass};

smarts_path = '/home/bp38/Downloads/smarts-295-linux-tar/SMARTS_295_Linux/';
results_path = '/home/bp38/Documents/MATLAB/SMARTS/smarts_modtran/';

conf = SMARTS_input( ...
    comment = 'Test_for_Arqit', ...
    args = defaults, ...
    executable_path = smarts_path, ...
    stub = results_path);

file_name = 'arqit';
[conf, success, destination] = conf.run_smarts(file_path = results_path, file_name = file_name);
data = readtable([results_path, file_name, '.ext.txt'], VariableNamingRule='Preserve');

figure
props = data.Properties.VariableNames;
props = props(contains(props, 'trans'));
labels = {};
hold on
for i = 1:numel(props)
    plot(data.Wvlgth, data.(props{i}))
    labels{i} = replace(replace(props{i}, '__', '_'), '_', ' ');
end
legend(labels)
