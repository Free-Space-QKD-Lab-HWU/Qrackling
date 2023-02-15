%% run
clear all

p = parameters();
delim = newline;
if ispc
    delim = [char(13), char(10)];
end

%% uvpsec_simple
af = p.atmosphere_file.OptionResultToVariable('file');
af.Value = '~/libRadtran-2.0.4/data/atmmod/afglus.dat';

s = p.source.OptionResultToVariable('solar');
s.Value = '~/libRadtran-2.0.4/data/solar_flux/atlas_plus_modtran';

wl = p.wavelength;
wl.lambda_0.Value = 310.0;
wl.lambda_1.Value = 310.0;

strjoin({format_tag(af), format_tag(s), format_tag(wl)}, delim)

%% uvspec_so2
af = p.atmosphere_file.OptionResultToVariable('file');
af.Value = '~/libRadtran-2.0.4/examples/AFGLT50.DAT';

s = p.source.OptionResultToVariable('solar');
s.Value = '~/libRadtran-2.0.4/data/solar_flux/kurudz_0.1nm.dat';

ma = p.mol_abs_param.OptionResultToVariable('crs');
mf = p.mol_file;
mf.species = mf.species.OptionResultToVariable('SO2')
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

strjoin({format_tag(af), format_tag(s), format_tag(ma), format_tag(mf), format_tag(al), format_tag(umu), format_tag(wg), format_tag(wl), outs, format_tag(q)}, delim)
