% %% test
% clear all
% clc
% 
% atmosphere_file("Default", "midlatitude_summer")
% 
% la = ck_lowtran_absorption("O4", "on")
% 
% crs_model_tetraoxygen.
% 
% crs_model.Molina
% 
% mc_backward("start_x", 1, "start_y", 1, "stop_x", 10, "stop_y", 10)
% 
% ic_habit("rough-aggregate")
% ic_habit_yang2013("plate_5elements")
% 
% mcb = mc_backward_output("edn", "eup", "exp", "edn") ...
%     .Absorption("W_per_m3") ...
%     .Emission("K_per_day") ...
%     .Heating("W_per_m2_and_dz")
% 
% mc_escape("on")
% 
% mc_forward_output("emission", "unit", "W_per_m2_and_dz")
% 
% ic_properties_func(), ...
% 
% z_interpolate_func(), ...
% zout_func(), ...
% zout_interpolate_func(), ...
% zout_sea_func(), ...
% 
% 
% %% ...
% clear all
% 
% atm = atmosphere_file("Default", "tropics");
% s = source("solar","File", "~/libRadtran-2.0.4/data/solar_flux/kurudz_1.0nm.dat");
% alb = albedo(0.02);
% rte = rte_solver("mystic");
% mcp = mc_photons(100000);
% mcpol = mc_polarisation("(1) (1,1,0,0)");
% mcb = mc_backward();
% mcbo = mc_backward_output("edir");
% mcname = mc_basename("~/Documents/MATLAB/lrt/lrt_new");
% vrm = mc_vroom("on");
% mcrad = mc_rad_alpha(10);
% u = umu(1);
% p = phi(0);
% zo = zout(0);
% t = time(datetime("now"));
% lat = latitude("N", 56.405);
% lon = longitude("W", 3.183);
% outu = output_user("lambda", "zout", "uu", "edir", "eglo", "edn", "eup", "enet", "esum");
% outq = output_quantity("reflectivity");
% outproc = output_process("per_nm");
% mol_abs = mol_abs_param("reptran coarse");
% crs = crs_model.Bodhaine;
% mo3 = mol_modify("O3", 200, "DU");
% mh20 = mol_modify("H2O", 20, "MM");
% wl = wavelength(500, 950);
% season = aerosol_season.Spring_Summer;
% ad = aerosol_default("on");
% vis = aerosol_visibility(50);
% of = output_file("./spooky.txt");
% %of = output_file("spooky.txt");
% 
% 
% out = Outputs() ...
%     .OutputColumns("uu", "uu", "eup", "edn") ...
%     .OutputQuantity("transmittance") ...
%     .PostProcessing("none") ...
%     .FileAndFormat("Format", "ascii") ...
%     .ConfigString()
% 
% Aer = Aerosol() ...
%     .Visibility(34) ...
%     .Vulcan("Moderate_volcanic_aerosols") ...
%     .Haze("Rural") ...
%     .Season("Fall_Winter") ...
%     .Species_library("water_soluble")
% 
% 
% properties(out.Columns)
% 
% s = Solver("polradtran")
% s.Streams(2)
% s.Polradtran("Lobatto", 10, "nstokes", 3, "aziorder", 2, "src_code", 1)
% 
% 
% 
% opts = {'aziorder', 'nstokes', 'src_code'};
% [X, Y] = meshgrid(opts, opts)
% 
% contains(Y(:), opts{1})
% 
% aerosol_season.Fall_Winter
% 
% m = {enumeration('aerosol_season')}
% 
% aer = Aerosol();
% aer.Visibility(10) ...
%     .Vulcan("Background") ...
%     .Haze("Rural")
% 
% 
% mol = Molecular()
% mol = mol.Add_molecule_files("O3", "~/libRadtran-2.0.4/data/aerosol/OPAC/refractive_indices//waso98_refr.dat")
% mol = mol.Add_molecule_files("N2", "~/libRadtran-2.0.4/data/aerosol/OPAC/refractive_indices//waso98_refr.dat")
% mol.molecule_files(1)
% mol.molecule_files.Species
% 
% mol = Molecular()
% mol = mol.Add_molecule_files( ...
%     "O3", "~/libRadtran-2.0.4/data/aerosol/OPAC/refractive_indices//waso98_refr.dat", ...
%     "N2", "~/libRadtran-2.0.4/data/aerosol/OPAC/refractive_indices//waso98_refr.dat")
% mol.molecule_files.Species
% 
% 
% a = {'O3',  'O2',  'H2O'}
% b = {1, 2, 3}
% c = {'DU', 'CM_2', 'MM'}
% 
% d = [a, b, c]
% index = reshape(1:numel(d), [3, numel(d)/3])'
% d = d(index(1:end))
% 
% mol = Molecular()
% mol.CrossSectionModel("o3_Molina")
% 
% geo = Geometry()
% geo = geo.SensorLatitude('N', 45, min=5)
% geo.sensor_latitude
% 
% mystic = Mystic()
% mystic.Vroom("on").SurfaceReflectalways("on").Photons(10000).SensorDirection(1, 2, 3)
% 
% Solver("disort").DeltaMScaling("on").Streams(10)
% 
% lrt = libRadtran()
% [lrt, rte] = lrt.addHandleToSolver()
% rte = rte.DisortIntensityCorrection("phase")
% 
% lrt.Solver_Settings
% 
% rte = Solver("disort")
% 
% clear all
% lrt = libRadtran("disort")
% lrt.GetSettingsHandle("Solver_Settings", true, "NewSolverType", "mystic")
% lrt.Solver_Settings.solver
% 
% 
% clear all
% lrt = libRadtran("disort");
% aer = Aerosol("lrtConfiguration", lrt);
% aer = aer.Haze("Rural");
% lrt.Aerosol_Settings.haze;
% solv = lrt.GetSettingsHandle("Solver_Settings");
% solv.Pseudospherical("on");
% lrt.Solver_Settings.pseudospherical_geometry
% lrt.ConfigString();
% 
% lrt.Aerosol_Settings
% 
% out = Outputs("lrtConfiguration", lrt) ...
%     .OutputColumns("lambda", "uu");
% lrt.Output_Settings.ConfigString()
% 
% clear all
% conf = libRadtran();
% clds = conf.GetCloudsSettings();
% solv = conf.GetSolverSettings();
% 
% clear all
% conf = libRadtran();
% outs = conf.GetOutputSettings();
% outs.OutputColumns("lambda", "sza", "edir", "eglo");
% solv = conf.GetSolverSettings();
% solv.Solver("disort");
% general = conf.GetGeneralAtmosphereSettings();
% general.InterpolateZ("on")
% conf.ConfigString()
% 
% zz = z_interpolate("on");
% props = properties(zz)
% types = cellfun(@(p) class(zz.(p)), props, "UniformOutput", false)
% hasTag = contains(types, 'TagEnum')
% hasOnOff = contains(types, 'matlab.lang.OnOffSwitchState')
% 
% idx = 1:numel(types)
% idx(hasTag)
% idx(hasOnOff)
% 
% atmosphere_file("Default", "tropics")

%%
clear all
lrt = libRadtran();

atm = lrt.GetGeneralAtmosphereSettings();
atm.Atmosphere("Default", "tropics");

spec = lrt.GetSpectralSettings();
spec.RadiationSource("solar", "File",  "~/libRadtran-2.0.4/data/solar_flux/kurudz_1.0nm.dat");

alb = lrt.GetSurfaceSettings();
alb.SurfaceAlbedo(0.02); %surface is broken

rte = lrt.GetSolverSettings();
rte.Solver("mystic");

mc = lrt.GetMysticsSettings();
mc.Photons(100000);
mc.Polarisation("(1) (1,1,0,0)");
mc.Backward();
mc.BackwardOutput("edir");
mc.Basename("~/Documents/MATLAB/lrt/lrt_new");
mc.Vroom("on");
mc.RadAlpha(10);

geo = lrt.GetGeometrySettings();
geo.OutputPolarAngles(90, "Degrees");
geo.SolarAzimuthAngle(0);
geo.OutputAltitudes(0);
geo.Time(datetime("now"));
geo.SensorLatitude("N", 56.405);
geo.SensorLongitude("W", 3.183);

out = lrt.GetOutputSettings();
out.OutputColumns("lambda", "zout", "uu", "edir", "eglo", "edn", "eup", "enet", "esum");
out.OutputQuantity("reflectivity");
out.PostProcessing("per_nm");
out.FileAndFormat("File", './spooky.txt');

mol = lrt.GetMoleculeSettings();
mol.MolecularAbsorption("reptran coarse");
mol.CrossSectionModel("rayleigh_Bodhaine");
mol.ModifySpecies("O3", 200, "DU", "H2O", 20, "MM");

spec = lrt.GetSpectralSettings();
spec.WavelengthRange(500, 950);

aer = lrt.GetAerosolSettings();
aer.Season("Spring_Summer");
aer.Default("on");
aer.Visibility(50);

config_string = lrt.ConfigString();
disp(char(config_string))
