%% run
clear all

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

%% uvpsec_simple
af = p.atmosphere_file.OptionResultToVariable('file');
af.Value = '~/libRadtran-2.0.4/data/atmmod/afglus.dat';

s = p.source.OptionResultToVariable('solar');
s.Value = '~/libRadtran-2.0.4/data/solar_flux/atlas_plus_modtran';

wl = p.wavelength;
wl.lambda_0.Value = 310.0;
wl.lambda_1.Value = 310.0;

uvpsec_simple = strjoin({format_tag(af), format_tag(s), format_tag(wl)}, delim);
disp(uvpsec_simple);

%% uvspec_so2
af = p.atmosphere_file.OptionResultToVariable('file');
af.Value = '~/libRadtran-2.0.4/examples/AFGLT50.DAT';

s = p.source.OptionResultToVariable('solar');
s.Value = '~/libRadtran-2.0.4/data/solar_flux/kurudz_0.1nm.dat';

ma = p.mol_abs_param.OptionResultToVariable('crs');
mf = p.mol_file;
mf.species = mf.species.OptionResultToVariable('SO2');
mf.file.Value = '~/libRadtran-2.0.4/data/atmmod/afglus_no2.dat';

al = p.albedo;
al.Value = 0.3;

umu = p.umu;
umu.Value = -1;

wg = p.wavelength_grid_file;
wg.Value = '~/libRadtran-2.0.4/examples/UVSPEC_SO2_TRANS';

wl = p.wavelength;
wl.lambda_0.Value = 290;
wl.lambda_1.Value = 320;


% both of these formats work
outs = choose_outputs({'lambda', 'edir', 'edn', 'eup', 'uu'});
q = p.quiet;

outs = choose_outputs({...
    p.output_user.OptionResultToVariable('lambda'), ...
    p.output_user.OptionResultToVariable('edir'), ...
    p.output_user.OptionResultToVariable('edn'), ...
    p.output_user.OptionResultToVariable('eup'), ...
    p.output_user.OptionResultToVariable('uu')});

uvspec_so2 = strjoin({...
    format_tag(af), format_tag(s),   format_tag(ma), format_tag(mf), ...
    format_tag(al), format_tag(umu), format_tag(wg), format_tag(wl), ...
    outs,           format_tag(q)},  ...
    delim);
disp(uvspec_so2)

%% uvspec_mc_pol
af = p.atmosphere_file.OptionResultToVariable('file');
%af.Value = '~/libRadtran-2.0.4/examples/UVSPEC_MC_ATM.DAT';
af.Value = '~/libRadtran-2.0.4/tests/UVSPEC_MC_ATM.DAT';

s = p.source.OptionResultToVariable('solar');
s.Value = adduserpath('~/libRadtran-2.0.4/data/solar_flux/atlas_plus_modtran');
s.Value = adduserpath('~/libRadtran-2.0.4/data/solar_flux/kurudz_1.0nm.dat');
%s.Value = adduserpath('~/libRadtran-2.0.4/tests/solar_flux/kato');
% s.Value = '~/libRadtran-2.0.4/data/solar_flux/kato';
%s.Value = '';

%mol = p.mol_abs_param;
%mol.Value = mol.OptionResultToVariable('lowtran').Value;
%mol.Value = 'lowtran';
%mol

mm = p.mol_modify;
mm.species = p.mol_modify.species.OptionResultToVariable('O3');
mm.column.Value = 300;
mm.unit = p.mol_modify.unit.OptionResultToVariable('DU');

doy = p.day_of_year;
doy.Value = 10;

al = p.albedo;
al.Value = 0.2;

sz = p.sza;
sz.Value = 30;

p0 = p.phi0;
p0.Value = 180;

rte = p.rte_solver.OptionResultToVariable('montecarlo');

mcp = p.mc_photons;
mcp.Value = 100000;

mcpol = p.mc_polarisation.OptionResultToVariable(1);

wl = p.wavelength;
wl.lambda_0.Value = 250;
wl.lambda_1.Value = 2000;

umu = p.umu;
umu.Value = -0.5;

phi = p.phi;
phi.Value = 40;

v = p.verbose;

of = p.output_file;
of.Value = '~/libRadtran-2.0.4/tests/testout.out';

params = {af, s, doy, al, sz, p0, rte, mcp, mcpol, wl, umu, phi, of, v};
%params = {af, s, doy, mol, al, sz, p0, rte, mcp, mcpol, wl, umu, phi, of, v};
out = runlibRadtran('~/Documents/MATLAB/mystic_test.inp', params, false, '~/libRadtran-2.0.4/tests/testout.out')

% need to build file reader that will add the correct header to the result of
% readtable(out.outputfile, FileType='delimitedtext')

%% format data

deg = @(i,q,u,v) sqrt(q^2 + u^2 + v^2) / i;
deglin = @(i, q, u) sqrt(q^2 + u^2) / i;
degcirc = @(i, v) v / i;

degs = @(i, q, u, v) [deg(i, q, u, v), deglin(i, q, u), degcirc(i, v)];


table = readtable(adduserpath('~/libRadtran-2.0.4/tests/mc.rad.spc'), FileType='delimitedtext');

[nrows, ncols] = size(table);

dop_data = zeros(nrows/4, 4);
j = 1;
for idx = 1:(nrows/4)
    wvl_res = table(j:j+3, :);
    wvl = table2array(wvl_res(:, 1));
    assert(sum(wvl == wvl(1)) == 4, 'File is corrupt')
    stokes = table2cell(wvl_res(:, end));
    [i, q, u, v] = stokes{:};
    dops = degs(i, q, u, v);
    dop_data(idx, 1) = wvl(1);
    dop_data(idx, 2) = dops(1);
    dop_data(idx, 3) = dops(2);
    dop_data(idx, 4) = dops(3);
    j = j + 4;
end


figure
plot(dop_data(:, 1), dop_data(:, 2))
xlabel('Wavelength (nm)')
ylabel('Degree of Polarisation')

%% test zenith

lrtdir = getlibradtranfolder('~/libRadtran-2.0.4');
curdir = cd([lrtdir, '/bin/'])
outfile = '~/Documents/MATLAB/lrt/test_angles';

command_str = 'zenith -a 50 -o 3 -s -15 -y 2023 -B 9 -E 10 -u 500 -v 4000 -w 1 4 3';
system([command_str, ' > ', outfile])
%command_str = 'zenith -a 50 -o 3 -s -15 -y 2023 4 3 9 35';
%system(command_str)

curdir = cd(curdir)
sol_angle = readtable(adduserpath(outfile));
sol_angle = renamevars( ...
    sol_angle, ...
    ["Var1", "Var2", "Var3"], ...
    ["Wavelength", "Solar Azimuth", "Solar Elevation"]);

figure
hold on
yyaxis left
plot(sol_angle.Wavelength, sol_angle.("Solar Azimuth"))
ylabel("Solar Azimuth");
yyaxis right
plot(sol_angle.Wavelength, sol_angle.("Solar Elevation"))
ylabel("Solar Elevation")


%% transmission

af = p.atmosphere_file.OptionResultToVariable('file');
af.Value = '~/libRadtran-2.0.4/data/atmmod/afglus.dat';

s = p.source.OptionResultToVariable('solar');
%s.Value = adduserpath('~/libRadtran-2.0.4/data/solar_flux/atlas_plus_modtran');
s.Value = adduserpath('~/libRadtran-2.0.4/data/solar_flux/kurudz_1.0nm.dat');

% mmO3 = p.mol_modify;
% mmO3.species = p.mol_modify.species.OptionResultToVariable('O3');
% mmO3.column.Value = 300;
% mmO3.unit = p.mol_modify.unit.OptionResultToVariable('DU');

molabs = p.mol_abs_param.OptionResultToVariable('lowtran');

doy = p.day_of_year;
doy.Value = 170;

al = p.albedo;
al.Value = 0.2;

atm = p.atmosphere_file.OptionResultToVariable('midlatitude_summer');
atm.Value = 'midlatitude_summer';

sz = p.sza;
sz.Value = 30;
%sz.Value = 00;

rte = p.rte_solver.OptionResultToVariable('disort');

nstreams = p.number_of_streams;
nstreams.Value = 6;

umu = p.umu;
%umu.Value = 0.5;
umu.Value = sind(90 - sz.Value);
% umu.Value = sind(170);

phi = p.phi;
phi.Value = 30;

wl = p.wavelength;
wl.lambda_0.Value = 300;
wl.lambda_1.Value = 1500;

slit = p.slit_function_file;
slit.Value ='~/libRadtran-2.0.4/examples/TRI_SLIT.DAT';

% wvl_spline = p.spline;
% wvl_spline.lambda_0.Value = 300;
% wvl_spline.lambda_1.Value = 340;
% wvl_spline.lambda_2.Value = 1;

out = p.output_user.OptionResultToVariable('edir');
out.Value = 'lambda edir edn uavgdn';
outq = p.output_quantity.OptionResultToVariable('transmittance');

params = {af, atm, s, molabs, doy, al, sz, rte, nstreams, umu, wl, slit, out,};
params = {af, atm, s, molabs, doy, al, sz, rte, nstreams, umu, wl, slit, out, outq};

out_path = '~/Documents/MATLAB/lrt/uvspec_clear_test.inp';
out_file = adduserpath(out_path);
out_data = '~/Documents/MATLAB/lrt/uvspec_clear_test.out.txt';

output = runlibRadtran( ...
    out_path, ...
    params, ...
    false, ...
    out_data)

table = readtable(out_data, FileType='delimitedtext');
table = renamevars( ...
    table, ...
    cellfun(@(V) replace(V, ' ', ''), tableVars(4), UniformOutput=false), ...
    { ...
        'Wavelength', ...
        'Direct Beam Transmission', ...
        'Diffuse Down Transmission', ...
        'Diffuse Downward Transmission', ...
    });

props = table.Properties.VariableNames;
figure
hold on
labels = {};
for i = 2 : numel(props)
    prop = props{i};
    plot(table.Wavelength, table.(prop))
    labels{i-1} = props{i};
end
legend(labels)


%% mmflx

mmflx = readtable(adduserpath('~/libRadtran-2.0.4/examples/mc.flx.spc'), FileType='delimitedtext');

mmflx = renamevars( ...
    mmflx, ...
    [cellfun(@(V) replace(V, ' ', ''), tableVars(9), UniformOutput=false)], ...
    ["Wavelength", "x", "y", ...
        "direct transmittance", ...
        "diffuse downward transmittance", ...
        "diffuse upward transmittance", ...
        "direct actinic flux transmittance", ...
        "diffuse downward actinic flux transmittance", ...
        "diffuse upward actinic flux transmittance", ...
            ]);

props = mmflx.Properties.VariableNames;
props = props(contains(props, 'trans'));

figure
labels = {};
hold on
for i = 1:numel(props)
    plot(mmflx.Wavelength, mmflx.(props{i}))
    labels{i} = replace(replace(props{i}, '__', '_'), '_', ' ');
end
legend(labels)
