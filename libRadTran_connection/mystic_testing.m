%% init
clear all
close all

p = parameters();
delim = newline;
if ispc
    delim = [char(13), char(10)];
end

tableVars = @(N) cellfun( ...
    @(i) ...
    strjoin(...
        {'Var', i}), ...
        cellstr(num2str(linspace(1, N, N)'))', ...
    UniformOutput=false)

formatAll = @(params) cellfun(@(param) format_tag(param), params, UniformOutput=false);


close all
%% first test

%af = p.atmosphere_file.OptionResultToVariable('file');
%af.Value = '~/libRadtran-2.0.4/examples/UVSPEC_MC_ATM.DAT';
%af.Value = '~/libRadtran-2.0.4/tests/UVSPEC_MC_ATM.DAT';

atm = p.atmosphere_file.OptionResultToVariable('US-standard');
atm.Value = 'US-standard';
% atm = p.atmosphere_file.OptionResultToVariable('file');
% atm.Value = '~/libRadtran-2.0.4/examples/UVSPEC_MC_ATM.DAT';
atm
ad = p.aerosol_default;
vis = p.aerosol_visibility;
vis.Value = 50;
haze = p.aerosol_haze.OptionResultToVariable(1);
haze.Value = 1;
season = p.aerosol_season.OptionResultToVariable(2)
aer_species = p.aerosol_species_file.OptionResultToVariable('continental_average')

al = p.albedo;
al.Value = 0.2;

alt = p.altitude;
alt.first.Value = 0;
alt.second.Value = 0.01;
format_tag(alt)

lat = p.latitude;
lat.Value = 'N 56.405';
%lat.Value = 'N 0.405';
%lat.Value = 'N 0';
lon = p.longitude;
lon.Value = 'W -3.183';
%lon.Value = 'W 0';

time = p.time;
time.Value = '2023 02 24 09 00 00'
time.Value = '2023 02 24 15 00 00'
time.Value = '2023 06 10 12 00 00'

s = p.source.OptionResultToVariable('solar');
s.Value = adduserpath('~/libRadtran-2.0.4/data/solar_flux/atlas_plus_modtran');
s.Value = adduserpath('~/libRadtran-2.0.4/data/solar_flux/kurudz_1.0nm.dat');
s.Value = adduserpath('~/libRadtran-2.0.4/data/solar_flux/kurudz_0.1nm.dat');
%s.Value = adduserpath('~/libRadtran-2.0.4/data/solar_flux/NewGuey2003.dat');

rte = p.rte_solver.OptionResultToVariable('montecarlo');
% rte = p.rte_solver.OptionResultToVariable('disort');

ps = p.pseudospherical;

mol_abs = p.mol_abs_param.OptionResultToVariable('lowtran');
mol_abs.Value = 'lowtran';
mcp = p.mc_photons;
mcp.Value = 100000;

mcpol = p.mc_polarisation.OptionResultToVariable(2);
mcb = Variable(TagEnum.IsCondition, Parent='mc_backward');
mcbo = p.mc_backward_output.OptionResultToVariable('edir');
mcbo.Value = '';
mcf = p.mc_forward_output.OptionResultToVariable('absorption');
mcname = p.mc_basename;
mcname.Value = '~/Documents/MATLAB/lrt/lrt';
vroom = p.mc_vroom;
vroom.Value = false;
mcrad = p.mc_rad_alpha;
mcrad.Value = 10;

wl = p.wavelength;
wl.lambda_0.Value = 925;
wl.lambda_1.Value = 950;

umu = p.umu;
viewAng = 90+10;
umu.Value = -cosd(-viewAng)
% umu.Value = '-1 -0.5 -0.2 -0.1';
% umu.Value = num2str(sind(linspace(-90, 10, 5)))
%umu.Value = -0.5;

phi = p.phi;
phi.Value = 40;
% phi.Value = linspace(10, 180, 2.25)

zout = p.zout;
zout.Value = 0;
zinterp = p.zout_interpolate;

v = p.verbose;
outq = p.output_quantity.OptionResultToVariable('transmittance');
outu = p.output_user.OptionResultToVariable('fdir');
outu.Value = 'lambda fdir fglo fdn fup f uavgdir uavgglo uavgdn uavgup uavg';
outu.Value = 'lambda sza zout edir eglo edn uavgdir uavgglo uavgdn uavgup uavg';

inp = ['~/Documents/MATLAB/mystic_test_', num2str(viewAng), '.inp'];
outp = replace(inp, 'inp', 'out');

of = p.output_file;
of.Value = outp;

outproc = p.output_process.OptionResultToVariable('integrate');

params = { ...
    atm,   ad,      vis,  haze,   season,  ...
     lat,   lon,     time, ...
    s,     rte,     mcp,  mcname, mol_abs, ...
    vroom, wl,      umu,  phi,    ...
    zout,  zinterp, of,   outq,   outu ...
    };

%params = { ...
%    atm,  ad,      al,   alt,     vis,  haze, ...
%    lat,  lon,     time, ...
%    s,    rte,     ps,   mol_abs, ...
%    wl,   umu,     phi,  ...
%    zout, zinterp, of, ...
%    };


out = runlibRadtran( ...
    inp, ...
    params, ...
    false, ...
    outf)

data = str2num(fileread(outp));
extraPath = mcname.Value;

% mcRad = str2num(fileread(adduserpath([extraPath, '.rad'])));
% mcFlx = str2num(fileread(adduserpath([extraPath, '.flx'])));
mcSpcRad = str2num(fileread(adduserpath([extraPath, '.rad.spc'])));
mcSpcFlx = str2num(fileread(adduserpath([extraPath, '.rad.spc'])));

OD_from_Transmittance = @(T) -log(T);
percentTransmission_from_OD = @(OD) exp(-1 .* OD);

figure
hold on
[rows, cols] = size(data);
arr = data(:, 4);
for i = 4:cols
    T = data(:, i);
    % od = OD_from_Transmittance(T);
    % t = percentTransmission_from_OD(T);
    plot(data(:, 1), T)
    arr = arr + T;
end
xlim([wl.lambda_0.Value, wl.lambda_1.Value])

figure
hold on
[rows, cols] = size(data);
arr = data(:, 4);
corrections = linspace(0, 80, 9);
for i = 5:5
    T = data(:, i);
    for c = 1:numel(corrections)
        plot(data(:, 1), T .* cosd(corrections(c)))
    end
end
xlim([wl.lambda_0.Value, wl.lambda_1.Value])

% figure
% hold on
% [rows, cols] = size(mcSpcFlx);
% for i = 2:cols
%     plot(mcSpcFlx(:, 1), mcSpcFlx(: ,i))
% end
% xlim([wl.lambda_0.Value, wl.lambda_1.Value])

% %(10.^log(mcSpcFlx(:, 5))) .* 100
% figure
% hold on
% [rows, cols] = size(mcSpcFlx);
% for i = 2:cols
%     od = OD_from_Transmittance(mcSpcFlx(:, i));
%     t = percentTransmission_from_OD(od);
%     plot(mcSpcFlx(:, 1), 1 - mcSpcFlx(:, i))
% end
% title(sz.Value)
% xlabel('Wavelength (nm)')
% ylabel('Transmission (%)')

%% plot modtran data

modtranClear_80 = readtable(adduserpath('~/Projects/QKD_Sat_Link/libRadTran/orbit modelling resources/atmospheric transmittance/varying elevation MODTRAN data 3/Trans_Sep_2022_zen_80deg_clear_scan.csv'), VariableNamingRule='preserve');

modtran80_50km = readtable(adduserpath('~/Projects/QKD_Sat_Link/libRadTran/orbit modelling resources/atmospheric transmittance/varying elevation MODTRAN data 3/Trans_Sep_2022_zen_80deg_50km_scan.csv'), VariableNamingRule='preserve');

modtran30_50km = readtable(adduserpath('~/Projects/QKD_Sat_Link/libRadTran/orbit modelling resources/atmospheric transmittance/varying elevation MODTRAN data 3/Trans_Sep_2022_zen_30deg_50km_scan.csv'), VariableNamingRule='preserve');

figure
hold on
plot(modtranClear_80.Waveln, modtranClear_80.combin)
plot(modtran80_50km.Waveln, modtran80_50km.combin)
plot(modtran30_50km.Waveln, modtran30_50km.combin)
title('MODTRAN')
xlabel('Wavelength (nm)')
ylabel('Transmission')
legend('Clear @ 80 \circ', '50Km @ 80 \circ', '50Km @ 30 \circ')
xlim([500, 950])

figure
hold on
factors = cosd(linspace(10, 80, 8));
for i = 1:numel(factors)
    plot(modtran30_50km.Waveln, modtran30_50km.combin .* factors(i)),
end
plot(modtran80_50km.Waveln, modtran80_50km.combin)
xlim([500, 950])

%%

p180 = adduserpath('~/Documents/MATLAB/mystic_test_170.out')
p110 = adduserpath('~/Documents/MATLAB/mystic_test_10.out')
data180 = str2num(fileread(p180));
data110 = str2num(fileread(p110));

figure
hold on
[rows, cols] = size(data180);
for i = 4:cols
    T = data180(:, i);
    plot(data180(:, 1), T)
end
for i = 4:cols
    T = data110(:, i);
    plot(data110(:, 1), T)
end
xlim([700, 1700])

%% plot solar spectra

s.Value = adduserpath('~/libRadtran-2.0.4/data/solar_flux/atlas_plus_modtran_ph');
data_path = adduserpath('~/libRadtran-2.0.4/data/solar_flux/');
files = dir(data_path);
options = cellfun(@(n) [data_path, n], {files.name}, UniformOutput=false)
figure
hold on
labels = {};
j = 1;
for i = 6:8
    o = options{i};
    disp(o)
    solar_data = readtable(o, FileType='delimitedtext');
    solar_data = table2array(solar_data(7:end, 1:2));
    plot(solar_data(:, 1), solar_data(:, 2))
    labels{j} = o;
    j = j + 1;
end
legend(labels)
xlim([300, 2000])

%%

sp = adduserpath('~/libRadtran-2.0.4/data/solar_flux/atlas_plus_modtran_ph');
solar_data = table2cell(readtable(sp));

wvls = zeros(length(solar_data), 1);
powers = zeros(length(solar_data), 1);
for i = 1:length(solar_data)
    row = {solar_data{i, :}};
    wvls(i) = row{1};
    powers(i) = row{3};
end

figure
plot(wvls, powers)
xlim([500, 950])

%%

solar_data = table2cell(readtable(adduserpath('~/libRadtran-2.0.4/data/solar_flux/kurudz_0.1nm.dat')));
%solar_data = solar_data(7:end, :);
row2num = @(row) cellfun(@(r) str2num(r), row, UniformOutput=false);
%solar_data = cellfun(@(row) strsplit(row, ' '), solar_data(7:end, :), UniformOutput=false);
solar_data = cellfun(@(row) row2num(strsplit(row, ' ')), solar_data(7:end, :), UniformOutput=false);
testdata = solar_data(:, 1);

wvls = zeros(numel(testdata), 1);
powers = zeros(numel(testdata), 1);
for i = 1:numel(testdata)
    row = testdata{i};
    wvls(i) = row{1};
    powers(i) = row{2};
end

figure
plot(wvls, powers)
xlim([500, 950])

%% many

data_root = adduserpath('~/Documents/MATLAB/lrt/');
possible_files = {dir(data_root).name};
valid_files = {};
angles = {};
j = 1;
for i = 1:numel(possible_files)
    f = possible_files{i};
    if contains(f, 'mystic')
        parts = strsplit(f, '_');
        ends = strsplit(parts{end}, '.');
        angles{j} = str2num(ends{1});
        valid_files{j} = [data_root, f];
        j = j + 1;
    end
end

angles = cell2mat(angles);
[angles, index] = sort(angles);

figure
hold on
for i = 1:numel(valid_files)
    disp(valid_files{index(i)})
    data = str2num(fileread(valid_files{i}));
    [rows, cols] = size(data);
    for j = 4:4
        T = data(:, j);
        % od = OD_from_Transmittance(T);
        % t = percentTransmission_from_OD(T);
        %plot(data(:, 1), secd(90 - angles(i)) .* data(:, j))
        t = data(:, j) ./ secd(90 - angles(i));
        plot(data(:, 1), T)
    end
end
xlim([wl.lambda_0.Value, wl.lambda_1.Value])

figure
hold on
[rows, cols] = size(data);
new_angles = linspace(0,90,4)
for j = 4:4
    T = data(:, j);
    % od = OD_from_Transmittance(T);
    % t = percentTransmission_from_OD(T);
    for a = 1:numel(new_angles)
        %plot(data(:, 1), secd(90 - new_angles(a)) .* data(:, j))
        arr = data(:, j);
        %plot(data(:, 1), arr ./ sec(90 - new_angles(a))
        plot(data(:, 1), arr )
    end
end
xlim([wl.lambda_0.Value, wl.lambda_1.Value])


%% general

atm = p.atmosphere_file.OptionResultToVariable('US-standard');
atm.Value = 'US-standard';
atm = p.atmosphere_file.OptionResultToVariable('file')
atm.Value = '~/libRadtran-2.0.4/data/atmmod/afglus.dat';

s = p.source.OptionResultToVariable('solar');
s.Value = adduserpath('~/libRadtran-2.0.4/data/solar_flux/kurudz_0.1nm.dat');
s.Value = adduserpath('~/libRadtran-2.0.4/data/solar_flux/constant.dat');
s.Value = [s.Value, ' per_nm'];
format_tag(s)

alb = p.albedo;
alb.Value = 0.02;

rte = p.rte_solver.OptionResultToVariable('disort');
ps = p.pseudospherical;

umu = p.umu;
umu.Value = 1.0;
umu.Value = linspace(-1, 1e-1, 5)

phi = p.phi;
phi.Value = [0, 90, 180, 270, 360];

zout = p.zout;
zout.Value = '0 119';
format_tag(zout)

alt = Variable(TagEnum.IsValue, Parent='altitude');
alt.Value = 0.01;
format_tag(alt)

time = p.time;
time.Value = '2023 02 24 09 00 00';
time.Value = '2023 02 24 15 00 00';
time.Value = '2023 06 10 12 00 00';

lat = p.latitude;
lat.Value = 'N 56.405';
lon = p.longitude;
lon.Value = 'W 3.183';

spec_lib = p.aerosol_species_library.OptionResultToVariable('INSO')
spec_lib.Value = 'OPAC'

outu = p.output_user.OptionResultToVariable('fdir');
outu.Value = 'lambda zout uu edir eglo edn eup enet esum';
outq = p.output_quantity.OptionResultToVariable('reflectivity');

outp = p.output_process.OptionResultToVariable('per_nm');
format_tag(outp)

outproc = Variable(TagEnum.IsValue, Parent='output_process')
outproc.Value = 'per_nm';
format_tag(outproc)

mol_abs = p.mol_abs_param.OptionResultToVariable('reptran');
mol_abs.Value = 'reptran coarse';
format_tag(mol_abs)

crs = p.crs_model.rayleigh.OptionResultToVariable('Bodhaine');
crs.Value = 'rayleigh bodhaine';
format_tag(crs)

% mol_modify O3 200.000000 DU
% mol_modify H2O 20.000000 MM

mo3 = p.mol_modify.species.OptionResultToVariable('O3');
mo3.Value = 'O3 200 DU';
format_tag(mo3)

mh2o = p.mol_modify.species.OptionResultToVariable('H2O');
mh2o.Value = 'H2O 20 MM';
format_tag(mh2o)

% wl = p.wavelength;
% wl.lambda_0.Value = 925;
% wl.lambda_1.Value = 950;

wl = Variable(TagEnum.IsValue, Parent='wavelength');
wl.Value = num2str([500, 950])

ad = p.aerosol_default;
vis = p.aerosol_visibility;
vis.Value = 50;

inp = [ ...
    '~/Documents/MATLAB/lrt/first_lut/', ...
    outq.Value, ...
    '_crs.inp'];
outp = replace(inp, 'inp', 'out');
of = p.output_file;
of.Value = outp;
params = { ...
    atm, s,   alb,  rte,     ps,   ...
    umu, phi, zout, alt,     time, ...
    lat, lon, outu, mol_abs, mo3, mh2o, crs,  ...
    wl,  ad,  vis,  spec_lib, ...
    of, outq, ...
};
out = runlibRadtran(inp, params, false, outp);

outq = p.output_quantity.OptionResultToVariable('transmittance');
inp = [ ...
    '~/Documents/MATLAB/lrt/first_lut/', ...
    outq.Value, ...
    '_crs.inp'];
outp = replace(inp, 'inp', 'out');
of = p.output_file;
of.Value = outp;
params = { ...
    atm, s,   alb,  rte,     ps,   ...
    umu, phi, zout, alt,     time, ...
    lat, lon, outu, mol_abs, mo3, mh2o, crs,  ...
    wl,  ad,  vis,  spec_lib, ...
    of, outq, ...
};
out = runlibRadtran(inp, params, false, outp);

inp = [ ...
    '~/Documents/MATLAB/lrt/first_lut/', ...
    'test_crs', ...
    '.inp'];
outp = replace(inp, 'inp', 'out');
of.Value = outp;
params = { ...
    atm, s,   alb,  rte,     ps,   ...
    umu, phi, zout, alt,     time, ...
    lat, lon, outu, mol_abs, mo3, mh2o, crs,  ...
    wl,  ad,  vis,  spec_lib, ...
    of, ...
};
out = runlibRadtran(inp, params, false, outp);

%% viewing angles outer product

umus = umu.Value;
phis = phi.Value;
n_pairs = numel(umus) * numel(phis);
titles = {};
k = 1;
titles{k} = 'Wavelength';
k = k + 1;
titles{k} = 'zout';
k = k + 1;
for i = 1 : numel(umus)
    for j = 1 : numel(phis)
        titles{k} = ['umu(', num2str(umus(i)), '), phi(', num2str(phis(j)), ')'];
        k = k + 1;
    end
end
irr_labels = { ...
    'Direct irradiance', 'Global irradiance', 'Diffuse Down irradiance', ...
    'Diffuse Upward irradiance', 'Net irradiance', 'Sum irradiance' ...
    };
disp(titles)
for i = 1:numel(irr_labels)
    titles{k} = irr_labels{i};
    k = k + 1;
end

reflectivities = readtable( ...
    adduserpath('~/Documents/MATLAB/lrt/first_lut/reflectivity_crs.out'), ...
    FileType='delimitedtext');
reflectivities.Properties.VariableNames = titles;

transmittance = readtable( ...
    adduserpath('~/Documents/MATLAB/lrt/first_lut/transmittance_crs.out'), ...
    FileType='delimitedtext');
transmittance.Properties.VariableNames = titles;

standard = readtable( ...
    adduserpath('~/Documents/MATLAB/lrt/first_lut/test_crs.out'), ...
    FileType='delimitedtext');
standard.Properties.VariableNames = titles;

heights = str2num(zout.Value)
h = 0
hmask = reflectivities.zout == h;

phis
row_mask = contains(titles, 'phi(0)');
cols = titles(row_mask);

NORM = standard.('Sum irradiance') ./ max(standard.('Sum irradiance'));

figure
hold on
title('reflectivities')
for i = 1 : numel(cols)
    c = cols{i};
    plot(reflectivities.Wavelength(hmask), reflectivities.(c)(hmask) );
end

figure
hold on
title('transmittance')
for i = 1 : numel(cols)
    c = cols{i};
    plot(transmittance.Wavelength(hmask), transmittance.(c)(hmask));
end

figure
title('radiance')
hold on
for i = 1 : numel(cols)
    c = cols{i};
    plot(standard.Wavelength(hmask), standard.(c)(hmask));
end

% zeniths = cosd(linspace(10, 80, 8));
% figure
% hold on
% for i = 1:numel(zeniths)
%     plot(standard.Wavelength, standard.('Sum irradiance') .* zeniths(i) .* NORM);
% end
% 
% zeniths = secd(linspace(10, 80, 3))
% figure
% hold on
% for i = 1:numel(zeniths)
%     plot(standard.Wavelength, standard.('Direct irradiance') .* zeniths(i));
% end

figure
hold on
emask = contains(titles, 'irradiance');
for i = 1:numel(emask)
    if emask(i) == true
        plot(standard.Wavelength(hmask), standard.(titles{i})(hmask))
    end
end
legend({titles{emask}})

figure
hold on
for i = 1 : numel(cols)
    c = cols{i};
    plot(reflectivities.Wavelength(hmask), standard.('Direct irradiance')(hmask) .* (1 - reflectivities.(c)(hmask)) );
end

% figure
% hold on
% plot((standard.(c) ./ max(standard.(c))) .* standard.('Direct irradiance'))
% figure
% hold on
% plot((standard.(c) ./ max(standard.(c))) .* transmittance.(c))

% wvlsMask = (wvls >= standard.Wavelength(1)) == (wvls <= standard.Wavelength(end));
% 
% figure
% title('radiance normed')
% hold on
% for i = 1 : numel(cols)
%     c = cols{i};
%     plot(standard.Wavelength, standard.(c) ./ powers(wvlsMask));
% end
% 
% figure
% plot(standard.Wavelength, standard.('Global irradiance'))
% 
% figure
% hold on
% title('???')
% for i = 1 : numel(cols)
%     c = cols{i};
%     plot(transmittance.Wavelength, standard.(c) .* transmittance.(c));
% end
% 
% ratio = 1 ./ (reflectivities.(cols{1}) ./ (pi .* standard.(cols{1})));
% figure
% plot(standard.Wavelength, ratio .* transmittance.(cols{1}))


%% data

bigtable = str2num(fileread(outp));

%% loop
umus = linspace(-1, 1e-3, 10)
phis = linspace(1, 360, 10)

for u = 1:numel(umus)
    for ph = 1:numel(phis)
        umu.Value = umus(u);
        phi.Value = phis(ph);

        inp = [ ...
            '~/Documents/MATLAB/lrt/first_lut/inp/phi_', ...
            num2str(phi.Value), ...
            '_umu_', ...
            num2str(umu.Value), ...
            '.inp'];
        outp = replace(inp, 'inp', 'out');

        of.Value = outp;

        params = { ...
            atm, s,   alb,  rte,     ps,   ...
            umu, phi, zout, alt,     time, ...
            lat, lon, outu, mol_abs,  ...
            wl,  ad,  vis,  of,      outq ...
        };

        out = runlibRadtran(inp, params, false, outp)
    end
end

%% read data

data_root = adduserpath('~/Documents/MATLAB/lrt/first_lut/out/');
possible_files = {dir(data_root).name};

valid_files = {};
j = 1;
for i = 1:numel(possible_files)
    f = possible_files{i};
    if contains(f, 'phi')
        valid_files{j} = [data_root, f];
        j = j + 1;
    end
end

takeLast = @(X) X{end};
takeFileName = @(path) takeLast(strsplit(path, '/'));
removeExtension = @(FileName) replace(FileName, '.out', '');

phis = zeros(numel(valid_files), 1);
umus = zeros(numel(valid_files), 1);
for i = 1:numel(valid_files)
    parts = reshape(strsplit(removeExtension(takeFileName(valid_files{i})), '_'), [2, 2])';
    phis(i) = str2num(parts{1, 2});
    umus(i) = str2num(parts{2, 2});
end

azimuths = unique(phis)
az = azimuths(end-1)
f_mask = phis == az;
labels = {};
figure
hold on
j = 1;
for i = 1:numel(f_mask)
    if f_mask(i) == true
        data = str2num(fileread(valid_files{i}));
        plot(data(:, 1), data(:, 2))
        labels{j} = num2str(acosd(umus(i)));
        j = j + 1;
    end
end
legend(labels)

% figure
% hold on
% j = 1;
% for i = 1:numel(f_mask)
%     if f_mask(i) == true
%         data = str2num(fileread(valid_files{i}));
%         plot(data(:, 1), data(:, 3))
%         labels{j} = num2str(acosd(umus(i)));
%         j = j + 1;
%     end
% end
% legend(labels)

%% new montecarlo

atm = p.atmosphere_file.OptionResultToVariable('midlatitude_summer');
atm.Value = 'midlatitude_summer';

s = p.source.OptionResultToVariable('solar');
s.Value = adduserpath('~/libRadtran-2.0.4/data/solar_flux/kurudz_0.1nm.dat');
s.Value = adduserpath('~/libRadtran-2.0.4/data/solar_flux/kurudz_1.0nm.dat');
%s.Value = adduserpath('~/libRadtran-2.0.4/data/solar_flux/constant.dat');
%s.Value = [s.Value, ' per_nm'];
format_tag(s)

rte = p.rte_solver.OptionResultToVariable('mystic');

mcp = p.mc_photons;
mcp.Value = 100000;

mcpol = p.mc_polarisation.OptionResultToVariable(2);
mcb = Variable(TagEnum.IsCondition, Parent='mc_backward');
mcbo = p.mc_backward_output.OptionResultToVariable('edir');
% mcbo.Value = 'lambda zout uu edir eglo edn eup enet esum';
mcname = p.mc_basename;
mcname.Value = '~/Documents/MATLAB/lrt/lrt';
vroom = p.mc_vroom;
vroom.Value = false;
mcrad = p.mc_rad_alpha;
mcrad.Value = 10;

umu = p.umu;
umu.Value = 1.0;
umu.Value = linspace(-1, 1e-1, 5)
umu.Value = -1
%umu.Value = -0.1

phi = p.phi;
phi.Value = 0;
phi.Value = 80
%phi.Value = [0, 90, 180, 270, 360];

zout = p.zout;
zout.Value = '0';
format_tag(zout)

time = p.time;
time.Value = '2023 02 24 09 00 00';
time.Value = '2023 02 24 15 00 00';
time.Value = '2023 06 10 12 00 00';

lat = p.latitude;
lat.Value = 'N 56.405';
lon = p.longitude;
lon.Value = 'W 3.183';

spec_lib = p.aerosol_species_library.OptionResultToVariable('INSO')
spec_lib.Value = 'OPAC'
species = p.aerosol_species_file.OptionResultToVariable('maritime_tropical');

outu = p.output_user.OptionResultToVariable('fdir');
outu.Value = 'lambda zout uu edir eglo edn eup enet esum';
outq = p.output_quantity.OptionResultToVariable('transmittance');

outproc = Variable(TagEnum.IsValue, Parent='output_process')
outproc.Value = 'per_nm';
format_tag(outproc)

mol_abs = p.mol_abs_param.OptionResultToVariable('reptran');
mol_abs.Value = 'reptran';
format_tag(mol_abs)

crs = p.crs_model.rayleigh.OptionResultToVariable('Bodhaine');
crs.Value = 'rayleigh bodhaine';
format_tag(crs)

mo3 = p.mol_modify.species.OptionResultToVariable('O3');
mo3.Value = 'O3 200 DU';
format_tag(mo3)

mh2o = p.mol_modify.species.OptionResultToVariable('H2O');
mh2o.Value = 'H2O 20 MM';
format_tag(mh2o)

wl = Variable(TagEnum.IsValue, Parent='wavelength');
wl.Value = num2str([500, 950])
wl.Value = num2str([500, 2000])

ad = p.aerosol_default;
season = p.aerosol_season.OptionResultToVariable(2);
season.Value = 1;
vis = p.aerosol_visibility;
vis.Value = 23;

inp = [ ...
    '~/Documents/MATLAB/lrt/first_lut/mystic', ...
    outq.Value, ...
    '_crs.inp'];
outp = replace(inp, 'inp', 'out');
of = p.output_file;
of.Value = outp;
params = { ...
    atm,     s,   rte,      mcp,   mcpol, ...
     mcname,   vroom, mcrad, ...
    umu,     phi, zout,   time, species, ...
    lat,     lon, spec_lib, outu,  outproc, ...
    mol_abs, crs, mo3,      mh2o,  wl, ...
    ad, season,      vis, of, outq, ...
    };
out = runlibRadtran(inp, params, false, outp);

new_data = readtable( ...
    adduserpath('~/Documents/MATLAB/lrt/lrt.flx.spc'), ...
    FileType='delimitedtext' ...
);

figure
hold on
for i = 5:numel(new_data.Properties.VariableNames)
    prop = ['Var', num2str(i)];
    plot(new_data.Var1, new_data.(['Var', num2str(i)]))
end
xlim([cellfun(@(l) str2num(l), strsplit(wl.Value))])
xlim([700, 900])
hold off

figure
hold on
angles = linspace(20, 80, 3)
for i = 1:numel(angles)
    plot(new_data.Var1, new_data.Var5 .^ secd(angles(i)))
end
hold off
legend(strsplit(num2str(fliplr(angles))))
xlim([cellfun(@(l) str2num(l), strsplit(wl.Value))])
xlim([700, 900])

umus = umu.Value;
phis = phi.Value;
n_pairs = numel(umus) * numel(phis);
titles = {};
k = 1;
titles{k} = 'Wavelength';
k = k + 1;
titles{k} = 'zout';
k = k + 1;
for i = 1 : numel(umus)
    for j = 1 : numel(phis)
        titles{k} = ['umu(', num2str(umus(i)), '), phi(', num2str(phis(j)), ')'];
        k = k + 1;
    end
end
irr_labels = { ...
    'Direct irradiance', 'Global irradiance', 'Diffuse Down irradiance', ...
    'Diffuse Upward irradiance', 'Net irradiance', 'Sum irradiance' ...
    };
disp(titles)
for i = 1:numel(irr_labels)
    titles{k} = irr_labels{i};
    k = k + 1;
end
newres = readtable( ...
    adduserpath('~/Documents/MATLAB/lrt/first_lut/mystictransmittance_crs.out'), ...
    FileType='delimitedtext');
newres.Properties.VariableNames = titles;

emask = contains(titles, 'irradiance')
cols = titles(emask)
figure
title('radiance')
hold on
for i = 1 : numel(cols)
    c = cols{i};
    disp(c)
    plot(newres.Wavelength, newres.(c));
end
legend(cols)

%%
outq = p.output_quantity.OptionResultToVariable('transmittance');
inp = [ ...
    '~/Documents/MATLAB/lrt/first_lut/mystic', ...
    outq.Value, ...
    '_crs.inp'];
outp = replace(inp, 'inp', 'out');
of = p.output_file;
of.Value = outp;
params = { ...
    atm,     s,   rte,      mcp,   mcpol, ...
    mcb,     mcf, mcname,   vroom, mcrad, ...
    umu,     phi, zout,   time, species, ...
    lat,     lon, spec_lib, outu,  outproc, ...
    mol_abs, crs, mo3,      mh2o,  wl, ...
    ad, season,      vis, of,       outq, ...
    };
out = runlibRadtran(inp, params, false, outp);

inp = [ ...
    '~/Documents/MATLAB/lrt/first_lut/mystic', ...
    'test_crs', ...
    '.inp'];
outp = replace(inp, 'inp', 'out');
of.Value = outp;
params = { ...
    atm,     s,   rte,      mcp,   mcpol, ...
    mcb,     mcf, mcname,   vroom, mcrad, ...
    umu,     phi, zout,   time, species, ...
    lat,     lon, spec_lib, outu,  outproc, ...
    mol_abs, crs, mo3,      mh2o,  wl, ...
    ad, season,      vis, of, ...
    };
out = runlibRadtran(inp, params, false, outp);

%% DOP

atm = p.atmosphere_file.OptionResultToVariable('midlatitude_summer');
atm.Value = 'midlatitude_summer';

s = p.source.OptionResultToVariable('solar');
s.Value = adduserpath('~/libRadtran-2.0.4/data/solar_flux/kurudz_0.1nm.dat');
%s.Value = adduserpath('~/libRadtran-2.0.4/data/solar_flux/kurudz_1.0nm.dat');

rte = p.rte_solver.OptionResultToVariable('mystic');

mcp = p.mc_photons;
mcp.Value = 100000;

mcpol = p.mc_polarisation.OptionResultToVariable(1);
mcb = Variable(TagEnum.IsCondition, Parent='mc_backward');
mcbo = p.mc_backward_output.OptionResultToVariable('edir');
% mcbo.Value = 'lambda zout uu edir eglo edn eup enet esum';
mcname = p.mc_basename;
mcname.Value = '~/Documents/MATLAB/lrt/lrt';
vroom = p.mc_vroom;
vroom.Value = false;
mcrad = p.mc_rad_alpha;
mcrad.Value = 10;

umu = p.umu;
umu.Value = -1

phi = p.phi;
phi.Value = 0;

zout = p.zout;
zout.Value = '0';
format_tag(zout)

time = p.time;
time.Value = '2023 02 24 09 00 00';
time.Value = '2023 02 24 15 00 00';
time.Value = '2023 06 10 12 00 00';

lat = p.latitude;
lat.Value = 'N 56.405';
lon = p.longitude;
lon.Value = 'W 3.183';

spec_lib = p.aerosol_species_library.OptionResultToVariable('INSO')
spec_lib.Value = 'OPAC'
species = p.aerosol_species_file.OptionResultToVariable('maritime_tropical');

outu = p.output_user.OptionResultToVariable('fdir');
outu.Value = 'lambda zout uu edir eglo edn eup enet esum';
outq = p.output_quantity.OptionResultToVariable('transmittance');

outproc = Variable(TagEnum.IsValue, Parent='output_process')
outproc.Value = 'per_nm';
format_tag(outproc)

mol_abs = p.mol_abs_param.OptionResultToVariable('reptran');
mol_abs.Value = 'reptran';
format_tag(mol_abs)

crs = p.crs_model.rayleigh.OptionResultToVariable('Bodhaine');
crs.Value = 'rayleigh bodhaine';
format_tag(crs)

mo3 = p.mol_modify.species.OptionResultToVariable('O3');
mo3.Value = 'O3 200 DU';
format_tag(mo3)

mh2o = p.mol_modify.species.OptionResultToVariable('H2O');
mh2o.Value = 'H2O 20 MM';
format_tag(mh2o)

wl = Variable(TagEnum.IsValue, Parent='wavelength');
wl.Value = num2str([500, 950])
wl.Value = num2str([500, 2000])
wl.Value = num2str([400, 600])

ad = p.aerosol_default;
season = p.aerosol_season.OptionResultToVariable(2);
season.Value = 1;
vis = p.aerosol_visibility;
vis.Value = 23;

umus = linspace(-1, 1e-2, 5)
phis = linspace(60, 360, 6)
for i = 1:numel(umus)
    u = umus(i);
    for j = 1:numel(phis)
        ph = phis(j);
        label = ['umu_', num2str(u), '_phi_', num2str(ph)];
        mcname.Value = ['~/Documents/MATLAB/lrt/dopnext/', label];
        inp = [ ...
            '~/Documents/MATLAB/lrt/dopnew/mystic_', ...
            label, ...
            '.inp'];
        outp = replace(inp, 'inp', 'out');
        of = p.output_file;
        of.Value = outp;
        disp(outp)
        umu.Value = u;
        phi.Value = ph;
        params = { ...
            atm,     s,      rte,      mcp,  mcpol,   ...
             mcname, vroom,  mcrad,    ...
            umu,     phi,    zout,     time, species, ...
            lat,     lon,    spec_lib, outu, outproc, ...
            mol_abs, crs,    mo3,      mh2o, wl,      ...
            ad,      season, vis,      of,   outq,    ...
            };
        params = { ...
            atm,     s,      rte,      mcp,  mcpol,   ...
             mcname, vroom,  mcrad,    ...
            umu,     phi,    zout,     time, ...
            lat,     lon, outu, outproc, ...
             wl,   ...
            ad,      season, vis,      of,   outq,    ...
            };
        out = runlibRadtran(inp, params, false, outp);
    end
end


%% DOP analysis

filesFromDir = @(DirDataRoot, Filt) ...
    {DirDataRoot( ...
        cellfun(@(fp) contains(fp, Filt), {DirDataRoot.name}) ...
    ).name};

f_ext = '.rad.spc';
data_root = adduserpath('~/Documents/MATLAB/lrt/dopnext/');
dopfiles = filesFromDir(dir(data_root), f_ext);

elems = strsplit(replace(dopfiles{1}, f_ext, ''), '_');
[uS, uV] = elems{1:2};
[pS, pV] = elems{3:4};

uV = str2num(uV);
pV = str2num(pV);

dopdata = readtable([data_root, dopfiles{1}], FileType='delimitedtext');


toShape = @(TABLE) [ ...
    numel(TABLE) ...
    / ( ...
        numel(TABLE.Properties.VariableNames) ...
        * numel(unique(TABLE(:, 1))) ...
    ), ...
    numel(unique(TABLE(:, 1))) ...
    ]

IQUV = reshape(table2array(dopdata(:, end)), toShape(dopdata));

calcDOP = @(IQUV_MAT) sqrt( ...
      (IQUV_MAT(2, :) .^ 2) ...
    + (IQUV_MAT(3, :) .^ 2) ...
    + (IQUV_MAT(4, :) .^ 2) ...
    ) ./ IQUV_MAT(1, :)

calcDOPLin = @(IQUV_MAT) sqrt( ...
      (IQUV_MAT(2, :) .^ 2) ...
    + (IQUV_MAT(3, :) .^ 2) ...
    ) ./ IQUV_MAT(1, :)

azimuth_files = {dopfiles{contains(dopfiles, num2str(umus(1)))}};
figure
hold on
wvls = table2array(unique(dopdata(:, 1)))';
for i = 1:numel(azimuth_files)
    dopdata = readtable([data_root, azimuth_files{i}], FileType='delimitedtext');
    IQUV = reshape(table2array(dopdata(:, end)), toShape(dopdata));
    plot(wvls, calcDOPLin(IQUV)')
end

elevation_files = {dopfiles{contains(dopfiles, num2str(phis(1)))}};
figure
hold on
wvls = table2array(unique(dopdata(:, 1)))';
for i = 1:numel(elevation_files)
    dopdata = readtable([data_root, elevation_files{i}], FileType='delimitedtext');
    IQUV = reshape(table2array(dopdata(:, end)), toShape(dopdata));
    plot(wvls, calcDOPLin(IQUV)')
end

dopdata = readtable([data_root, elevation_files{1}], FileType='delimitedtext');
IQUV = reshape(table2array(dopdata(:, end)), toShape(dopdata));

iquv = IQUV(:, 10);
sqrt((iquv(2).^2) + (iquv(3).^2) + (iquv(4).^2)) / iquv(1)
