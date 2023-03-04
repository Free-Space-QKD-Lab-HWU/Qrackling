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

%% disort

atm = p.atmosphere_file.OptionResultToVariable('US-standard');
atm.Value = 'US-standard';
% atm = p.atmosphere_file.OptionResultToVariable('file')
% atm.Value = '~/libRadtran-2.0.4/data/atmmod/afglus.dat';

s = p.source.OptionResultToVariable('solar');
s.Value = adduserpath('~/libRadtran-2.0.4/data/solar_flux/kurudz_0.1nm.dat');
s.Value = adduserpath('~/libRadtran-2.0.4/data/solar_flux/constant.dat');
s.Value = adduserpath('~/libRadtran-2.0.4/data/solar_flux/kurudz_1.0nm.dat');
s.Value = [s.Value, ' per_nm'];
format_tag(s)

alb = p.albedo;
alb.Value = 0.02;

rte = p.rte_solver.OptionResultToVariable('disort');
ps = p.pseudospherical;

umu = p.umu;
umu.Value = 1.0;
umu.Value = linspace(-1, 1, 180)

phi = p.phi;
phi.Value = [0, 90, 180, 270, 360];
phi.Value = linspace(0, 360, 180);
phi.Value

zout = p.zout;
zout.Value = '0 119';
zout.Value = '0';
format_tag(zout)

alt = Variable(TagEnum.IsValue, Parent='altitude');
alt.Value = 0.01;
format_tag(alt)

time = p.time;
time.Value = '2023 02 24 09 00 00';
time.Value = '2023 02 24 17 00 00';
% time.Value = '2023 02 24 15 00 00';
% time.Value = '2023 06 10 12 00 00';

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
wl.Value = num2str([500, 550])

ad = p.aerosol_default;
vis = p.aerosol_visibility;
vis.Value = 50;

% inp = [ ...
%     '~/Documents/tqi_data/inputs/01032023_high_res_disort_', ...
%     replace(time.Value, ' ', '_'), '_', ...
%     outq.Value, ...
%     '_crs.inp'];
% disp(inp)
% outp = replace(inp, 'inputs', 'outputs');
% outp = replace(outp, 'inp', 'out');
% of = p.output_file;
% disp(outp)
% of.Value = outp;
% params = { ...
%     atm, s,   alb,  rte,     ps,   ...
%     umu, phi, zout, alt,     time, ...
%     lat, lon, outu, mol_abs, mo3, mh2o, crs,  ...
%     wl,  ad,  vis,  spec_lib, ...
%     of, outq, ...
% };
% out = runlibRadtran(inp, params, false, outp);

% outq = p.output_quantity.OptionResultToVariable('transmittance');
% inp = [ ...
%     '~/Documents/tqi_data/inputs/01032023_high_res_disort_', ...
%     replace(time.Value, ' ', '_'), '_', ...
%     outq.Value, ...
%     '_crs.inp'];
% outp = replace(inp, 'inputs', 'outputs');
% outp = replace(outp, 'inp', 'out');
% of = p.output_file;
% of.Value = outp;
% params = { ...
%     atm, s,   alb,  rte,     ps,   ...
%     umu, phi, zout, alt,     time, ...
%     lat, lon, outu, mol_abs, mo3, mh2o, crs,  ...
%     wl,  ad,  vis,  spec_lib, ...
%     of, outq, ...
% };
% out = runlibRadtran(inp, params, false, outp);
% 
% inp = [ ...
%     '~/Documents/tqi_data/inputs/01032023_high_res_disort_', ...
%     replace(time.Value, ' ', '_'), '_', ...
%     'radiance_crs', ...
%     '.inp'];
% outp = replace(inp, 'inputs', 'outputs');
% outp = replace(outp, 'inp', 'out');
% of.Value = outp;
% params = { ...
%     atm, s,   alb,  rte,     ps,   ...
%     umu, phi, zout, alt,     time, ...
%     lat, lon, outu, mol_abs, mo3, mh2o, crs,  ...
%     wl,  ad,  vis,  spec_lib, ...
%     of, ...
% };
% out = runlibRadtran(inp, params, false, outp);

%%
wl.Value = num2str([500, 2000])
umu.Value = linspace(-0.999, -1e-3, 90)
phi.Value = linspace(0, 360, 90);

dates = { ...
    '2023 02 24 09 00 00', ...
    '2023 02 24 12 00 00', ...
    '2023 02 24 15 00 00', ...
    '2023 08 01 09 00 00', ...
    '2023 08 01 12 00 00', ...
    '2023 08 01 15 00 00', ...
    };

atmospheres = {
    'midlatitude_winter', ...
    'midlatitude_winter', ...
    'midlatitude_winter', ...
    'midlatitude_summer', ...
    'midlatitude_summer', ...
    'midlatitude_summer', ...
    };


visibilities = [5, 10, 50];
visibilities = [50];


for d = 1:numel(dates)
    D = dates{d};
    time.Value = D;
    atm.Value = atmospheres{d};
    for v = 1:numel(visibilities)
        V = visibilities(v);
        vis.Value = V;

        outq = p.output_quantity.OptionResultToVariable('transmittance');
        inp = [ ...
            '~/Documents/tqi_data/inputs/time_', ...
            replace(D, ' ', '_'), '__', ...
            'visibility_', num2str(V), '__', ...
            outq.Value, ...
            '.inp'];

        outu.Value = 'lambda edir eglo edn eup enet esum';
        outp = replace(inp, 'inputs', 'outputs');
        outp = replace(outp, 'inp', 'out');
        of = p.output_file;
        of.Value = outp;
        params = { ...
            atm, s,   alb,  rte,     ps,   ...
            alt,     time, ...
            lat, lon, outu, mol_abs, mo3, mh2o, crs,  ...
            wl,  ad,  vis,  spec_lib, ...
            of, outq, ...
        };
        out = runlibRadtran(inp, params, false, outp);
        %%%%%%%%
        outu.Value = 'lambda uu edir eglo edn eup enet esum';
        inp = [ ...
            '~/Documents/tqi_data/inputs/time_', ...
            replace(D, ' ', '_'), '__', ...
            'visibility_', num2str(V), '__', ...
            'radiance', ...
            '.inp'];
            outp = replace(inp, 'inputs', 'outputs');
        outp = replace(outp, 'inp', 'out');
        of.Value = outp;
        params = { ...
            atm, s,   alb,  rte,     ps,   ...
            umu, phi, alt,     time, ...
            lat, lon, outu, mol_abs, mo3, mh2o, crs,  ...
            wl,  ad,  vis,  spec_lib, ...
            of, ...
        };
        out = runlibRadtran(inp, params, false, outp);
    end
end

%%

target_path = '~/Documents/tqi_data/outputs/';
ContentsOfDirectory = @(DirPath) {dir(adduserpath(DirPath)).name};

FilterFiles = @(DirectoryContents, Query) ...
    {DirectoryContents{cellfun( ...
        @(fp) contains(fp, Query), ...
        DirectoryContents)} ...
    };

radianceFiles = FilterFiles( ...
    ContentsOfDirectory(target_path), ...
    '__radiance');

disp(radianceFiles')

viewingAngles = strsplit('lambda zout');
k = numel(viewingAngles) + 1;
for i = 1:numel(umu.Value)
    UMU = umu.Value(i);
    for j = 1:numel(phi.Value)
        PHI = phi.Value(j);
        viewingAngles{k} = strjoin({num2str(UMU), num2str(PHI)}, ', ');
        k = k+1;
    end
end
extras = strsplit('edir eglo edn eup enet esum');
for i = 1:numel(extras)
    viewingAngles{k} = extras{i};
    k = k + 1;
end

data = readtable(strjoin({target_path, radianceFiles{1}}, ''), FileType='delimitedtext');


%%

data = readtable( ...
    replace(replace(inp, '.inp', '.out'), 'inputs', 'outputs'), ...
    FileType = 'delimitedtext' ...
    );

size(data)

size(data(1, :))
wavelengths = table2array(data(:, 1));
% zout = data(:, 2);

edir = data(:, end - 5);
eglo = data(:, end - 4);
edn  = data(:, end - 3);
eup  = data(:, end - 2);
enet = data(:, end - 1);
esum = data(:, end);

radiances = data(:, 3:numel(umu.Value) * numel(phi.Value)+2);
size(radiances)
clear data

[val, idx] = min(abs(wavelengths - 530))

size(radiances(idx, :))
numel(umu.Value) * numel(phi.Value)

[theta, r] = meshgrid(umu.Value, phi.Value)

figure
contourf(r.*cos(umu.Value), r.*cosd(phi.Value), reshape(table2array(radiances(idx, :)), 180, 180)')

[r, t] = meshgrid(umu.Value, deg2rad(phi.Value));
z = reshape(table2array(radiances(idx, :)), 180, 180);
figure
contourf(r.*cos(t), r.*sin(t), z, levels=2e-2)
