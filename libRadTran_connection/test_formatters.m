%% run
clear all

p = parameters();
delim = newline;
if ispc
    delim = [char(13), char(10)];
end

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
af.Value = '~/libRadtran-2.0.4/examples/UVSPEC_MC_ATM.DAT';

s = p.source.OptionResultToVariable('solar');
s.Value = adduserpath('~/libRadtran-2.0.4/data/solar_flux/atlas_plus_modtran');
% s.Value = '~/libRadtran-2.0.4/data/solar_flux/kato';
%s.Value = '';

mm = p.mol_modify;
mm.species = p.mol_modify.species.OptionResultToVariable('O3');
mm.column.Value = 300;
mm.unit = p.mol_modify.unit.OptionResultToVariable('DU');

doy = p.day_of_year;
doy.Value = 170;

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
wl.lambda_0.Value = 310;
wl.lambda_1.Value = 310;

umu = p.umu;
umu.Value = -0.5;

phi = p.phi;
phi.Value = 40;

v = p.verbose;

of = p.output_file;
of.Value = '~/Documents/MATLAB/mystic_test.out';

params = {af, s, doy, al, sz, p0, rte, mcp, mcpol, wl, umu, phi, of, v};
out = runlibRadtran('~/Documents/MATLAB/mystic_test.inp', params, false, '~/Documents/MATLAB/testout.out')

% need to build file reader that will add the correct header to the result of
% readtable(out.outputfile, FileType='delimitedtext')
