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

cosd(90)

%% libradtran.m testing
clear all
lrt = libRadtran("~/libRadtran-2.0.4/");

atm = lrt.GeneralAtmosphereSettings() ...
    .Atmosphere("Default", "tropics");

spec = lrt.SpectralSettings() ...
    .RadiationSource("solar", "File",  "~/libRadtran-2.0.4/data/solar_flux/kurudz_1.0nm.dat");

alb = lrt.SurfaceSettings() ...
    .SurfaceAlbedo(0.02);

rte = lrt.SolverSettings() ...
    .Solver("mystic");

mc = lrt.MysticsSettings() ...
    .Photons(100000)...
    .Polarisation("(1) (1,1,0,0)")...
    .Backward()...
    .BackwardOutput("edir")...
    .Basename('~/Documents/conference_data/')...
    .RadAlpha(10);

geo = lrt.GeometrySettings() ...
    .OutputPolarAngles(linspace(10, 90, 9), "Degrees")...
    .SolarAzimuthAngle(0)...
    .OutputAltitudes(0)...
    .Time(datetime("now"))...
    .SensorLatitude("N", 56.405)...
    .SensorLongitude("W", 3.183);

out = lrt.OutputSettings() ...
    .OutputColumns("lambda", "zout", "uu", "edir", "eglo", "edn", "eup", "enet", "esum")...
    .OutputQuantity("reflectivity")...
    .PostProcessing("per_nm")...
    .FileAndFormat("File", '~/Documents/conference_data/out.txt');

%mol = lrt.MoleculeSettings()...
%    .MolecularAbsorption("reptran coarse")...
%    .CrossSectionModel("rayleigh_Bodhaine")...
%    .ModifySpecies("O3", 200, "DU", "H2O", 20, "MM");

spec = lrt.SpectralSettings() ...
    .WavelengthRange(500, 950);

%aer = lrt.AerosolSettings() ...
%    .Season("Spring_Summer") ...
%    .Default("on") ...
%    .Visibility(50);

config_string = lrt.StringFromConfiguration();
disp(char(config_string))

%lrt.SaveConfigurationString('~/Documents/conference_data/', 'test.txt')

out_file_path = lrt.RunConfiguration( ...
    '~/Documents/conference_data', 'test.txt', ...
    Verbosity = 'Quiet');


%% libradtran.m test and run
clear all
close all
clc
lrt = libRadtran("~/libRadtran-2.0.4/");

libradtran.libRadtran("~/libRadtran-2.0.4/")

atm = lrt.GeneralAtmosphereSettings() ...
    .Atmosphere("Default", "midlatitude_summer");

spec = lrt.SpectralSettings() ...
    .RadiationSource("solar", "File",  "~/libRadtran-2.0.4/data/solar_flux/kurudz_1.0nm.dat");

alb = lrt.SurfaceSettings() ...
    .SurfaceAlbedo(0.02);

rte = lrt.SolverSettings() ...
    .Solver("disort") ...
    .Pseudospherical("on");

geo = lrt.GeometrySettings() ...
    .OutputPolarAngles(linspace(-1, -1e-3, 10), "Radians")...
    .SolarAzimuthAngle(linspace(120, 360, 3))...
    .OutputAltitudes(0.01)...
    .Time(datetime("01-Aug-2023 09:00:00"))...
    .SensorLatitude("N", 56.405)...
    .SensorLongitude("W", 3.183);

out = lrt.OutputSettings() ...
    .OutputColumns("lambda", "zout", "uu", "edir", "eglo", "edn", "eup", "enet", "esum")...
    .OutputQuantity("reflectivity")...
    .PostProcessing("per_nm")...
    .FileAndFormat("File", '~/Documents/conference_data/out.txt');

mol = lrt.MoleculeSettings()...
    .MolecularAbsorption("reptran coarse")...
    .CrossSectionModel("rayleigh_Bodhaine")...
    .ModifySpecies("O3", 200, "DU", "H2O", 20, "MM");

spec = lrt.SpectralSettings() ...
    .WavelengthRange(500, 950);

aer = lrt.AerosolSettings() ...
    .Season("Spring_Summer") ...
    .Default("on") ...
    .Visibility(50);

config_string = lrt.StringFromConfiguration();

out_file_path = lrt.RunConfiguration( ...
    '~/Documents/conference_data', 'test.txt', ...
    Verbosity = 'Quiet');

%% detector preset recreation after error
clear all
close all


preset = detectors.loadPreset("Excelitas")
detectors.Detector(785, 1, 1, 1, "Preset", detectors.loadPreset("Hamamatsu"))

components.DetectorPresetBuilder().convert(detectors.loadPreset("Excelitas"), '~/Projects/QKD_Sat_Link/adaptive_optics/+components/presets/Excelitas.mat')
components.DetectorPresetBuilder().convert(detectors.loadPreset("Hamamatsu"), '~/Projects/QKD_Sat_Link/adaptive_optics/+components/presets/Hamamatsu.mat')
components.DetectorPresetBuilder().convert(detectors.loadPreset("ID_Qube_NIR"), '~/Projects/QKD_Sat_Link/adaptive_optics/+components/presets/ID_Qube_NIR.mat')
components.DetectorPresetBuilder().convert(detectors.loadPreset("PerkinElmer"), '~/Projects/QKD_Sat_Link/adaptive_optics/+components/presets/PerkinElmer.mat')
components.DetectorPresetBuilder().convert(detectors.loadPreset("LaserComponents"), '~/Projects/QKD_Sat_Link/adaptive_optics/+components/presets/LaserComponents.mat')
components.DetectorPresetBuilder().convert(detectors.loadPreset("MicroPhotonDevices"), '~/Projects/QKD_Sat_Link/adaptive_optics/+components/presets/MicroPhotonDevices.mat')
components.DetectorPresetBuilder().convert(detectors.loadPreset("QuantumOpus1550_RoomTempAmplifier"), '~/Projects/QKD_Sat_Link/adaptive_optics/+components/presets/QuantumOpus1550_RoomTempAmplifier.mat')
components.DetectorPresetBuilder().convert(detectors.loadPreset("QuantumOpus1550_CryogenicAmplifier"), '~/Projects/QKD_Sat_Link/adaptive_optics/+components/presets/QuantumOpus1550_CryogenicAmplifier.mat')

clear all
clc

components.loadPreset("PerkinElmer")

detectors.Detector(785, 1, 1, 1, "Preset", components.loadPreset("Excelitas"))

components.Detector(785, 1, 1, 1, "Preset", components.loadPreset("Excelitas"))

components.DetectorPreset()

new_preset = components.DetectorPresetBuilder();
new_preset = new_preset.addName(preset.Name)
new_preset = new_preset.addDeadTime(preset.Dead_Time)

components.DetectorPresetBuilder().convert(

detectors.DetectorPresetBuilder().convert('~/Projects/QKD_Sat_Link/adaptive_optics/+detectors/presets/Excelitas.mat')
detectors.DetectorPresetBuilder().convert('~/Projects/QKD_Sat_Link/adaptive_optics/+detectors/presets/Hamamatsu.mat')
detectors.DetectorPresetBuilder().convert('~/Projects/QKD_Sat_Link/adaptive_optics/+detectors/presets/ID_Qube_NIR.mat')
detectors.DetectorPresetBuilder().convert('~/Projects/QKD_Sat_Link/adaptive_optics/+detectors/presets/PerkinElmer.mat')
detectors.DetectorPresetBuilder().convert('~/Projects/QKD_Sat_Link/adaptive_optics/+detectors/presets/LaserComponents.mat')
detectors.DetectorPresetBuilder().convert('~/Projects/QKD_Sat_Link/adaptive_optics/+detectors/presets/MicroPhotonDevices.mat')
detectors.DetectorPresetBuilder().convert('~/Projects/QKD_Sat_Link/adaptive_optics/+detectors/presets/QuantumOpus1550_RoomTempAmplifier.mat')
detectors.DetectorPresetBuilder().convert('~/Projects/QKD_Sat_Link/adaptive_optics/+detectors/presets/QuantumOpus1550_CryogenicAmplifier.mat')

%% angles

units.Angle.Degrees
units.Angle.ToDegrees("Radians", pi/2)
units.Angle.ToRadians("Degrees", 90)

units.Magnitude.Convert("micro", "nano", 1.55)

%% stokes parameters and degree of polarisation
path = "/home/bp38/Documents/tqi_data/inputs/time_2023_02_24_09_00_00__visibility_50__radiance.inp";
[keys, data] = libRadtran.read_input_file(path);
numel(keys)
numel(data)
is_key = contains(keys, 'output_file')
sum(is_key) == 1
any(is_key)
[v, l] = max(is_key)

numel(is_key)
numel(data)

path = "/home/bp38/Documents/MATLAB/DOP_800/mysticumu_-0.5__phi_8.0899.inp";
libRadtran.dop_data(path)

result_path = libRadtran.input_has_dop_data(path)

data = readtable(result_path, "FileType", "delimitedtext");

table2array(data(1:4:end, end))

[a, b, ext] = fileparts(result_path)
all(ext == '.spc')
[a, b, ext2] = fileparts(b)
[ext2, ext]

stokes = libRadtran.read_dop_file(libRadtran.input_has_dop_data(path))

lrt = libRadtran("~/libRadtran-2.0.4")

libradtran.input_has_dop_data(path)

[stokes, wvl] = libradtran.read_dop_file(libradtran.input_has_dop_data(path), "extract_wavelength", "on");

figure
hold on
plot(wvl, stokes.I)
plot(wvl, stokes.Q)
plot(wvl, stokes.U)
plot(wvl, stokes.V)

table = readtable(libradtran.input_has_dop_data(path), "FileType", "delimitedtext")
unique(table2array(table(:, 1)))

%% dopFromStokes.m
path = "/home/bp38/Documents/MATLAB/DOP_800/mysticumu_-0.5__phi_8.0899.inp";
[stokes, wvl] = libradtran.extractStokesParameters( ...
    libradtran.inputHasDopData(path), ...
    "extract_wavelength", "on");

dop = libradtran.dopFromStokes(stokes.I, stokes.Q, stokes.U, stokes.V, "Full");
utilities.equalDimensions(stokes.I, dop)
dop = libradtran.dopFromStokes(stokes.I, stokes.Q, stokes.U, stokes.V, "Linear");
utilities.equalDimensions(stokes.I, dop)
dop = libradtran.dopFromStokes(stokes.I, stokes.Q, stokes.U, stokes.V, "Circular");
utilities.equalDimensions(stokes.I, dop)

[f, c, l] = libradtran.dopFromStokes(stokes.I, stokes.Q, stokes.U, stokes.V, "Full", "Circular", "Linear")

figure
hold on
plot(wvl, f)
plot(wvl, c)
plot(wvl, l)

%% radiance_file.m testing
clear all
clc

ContentsOfDirectory = @(DirPath) {dir(utilities.addUserPath(DirPath)).name};

FilterFiles = @(DirectoryContents, Query) ...
    {DirectoryContents{cellfun( @(fp) contains(fp, Query), DirectoryContents)}};

in_target_path = '~/Documents/tqi_data/inputs/';

in_radianceFiles = FilterFiles( ...
    ContentsOfDirectory(in_target_path), ...
    '__radiance');

disp(in_radianceFiles')

file_path = [in_target_path, in_radianceFiles{1}];

data = libradtran.outputFromInputFile(file_path);
disp(data)


%% lrt fixes
clear all
clc

lrt = libradtran.libRadtran("~/libRadtran-2.0.4/");

atm = lrt.GeneralAtmosphereSettings() ...
    .Atmosphere("Default", "midlatitude_summer");

spec = lrt.SpectralSettings() ...
    .RadiationSource("solar", "File",  "~/libRadtran-2.0.4/data/solar_flux/kurudz_1.0nm.dat");

alb = lrt.SurfaceSettings() ...
    .SurfaceAlbedo(0.02);

rte = lrt.SolverSettings() ...
    .Solver("disort") ...
    .Pseudospherical("on");

geo = lrt.GeometrySettings() ...
    .OutputPolarAngles(linspace(-1, -1e-3, 10), "Radians")...
    .SolarAzimuthAngle(linspace(120, 360, 3))...
    .OutputAltitudes(0.01)...
    .Time(datetime("01-Aug-2023 09:00:00"))...
    .SensorLatitude("N", 56.405)...
    .SensorLongitude("W", 3.183);

out = lrt.OutputSettings() ...
    .OutputColumns("lambda", "zout", "uu", "edir", "eglo", "edn", "eup", "enet", "esum")...
    .OutputQuantity("reflectivity")...
    .PostProcessing("per_nm")...
    .FileAndFormat("File", '~/Documents/MATLAB/tqi_dop_data_and_calculations/test_data.txt');

mol = lrt.MoleculeSettings()...
    .MolecularAbsorption("reptran coarse")...
    .CrossSectionModel("rayleigh_Bodhaine")...
    .ModifySpecies("O3", 200, "DU", "H2O", 20, "MM");

spec = lrt.SpectralSettings() ...
    .WavelengthRange(500, 950);

aer = lrt.AerosolSettings() ...
    .Season("Spring_Summer") ...
    .Default("on") ...
    .Visibility(50);

config_string = lrt.StringFromConfiguration();

out_file_path = lrt.RunConfiguration( ...
    '~/Documents/MATLAB/tqi_dop_data_and_calculations/', 'test_input.txt', ...
    Verbosity = 'Verbose');

disp(lrt.File)

clc
libradtran.ReadData(lrt)

clc
[k, d] = libradtran.readInputFile(lrt.File);

[path, name, extension] = fileparts(lrt.File)

strjoin({strjoin({path, name}, filesep), '.rad.spc'}, '')

numel(k)
numel(d)

data = libradtran.ReadData(lrt);
data.reflectivity


%% beacon class
% clear all
% clc

a = linspace(1, 10, 10)
numel(a)

Telescope(1,"Wavelength", 785, "Wavelength_Scale", "nano")

Telescope(1,"Wavelength", 785, "Wavelength_Scale", "nano"

%% 
rx = components.Telescope(1, "Wavelength", 780)
cam = components.Camera(rx)

%%
clear all
clc


isa(nodes.Satellite,'nodes.QKD_Receiver')
isa(nodes.Satellite,'nodes.QKD_Transmitter')


%%
clear all
clc

path = '~/Projects/QKD_Sat_Link/adaptive_optics/orbit modelling resources/orbit LLAT files/500kmSSOrbitLLAT.txt';

fd = fopen(path);

data = fscanf(fd, '%f, %f, %f, %f', [4, inf]);
fclose(fd);

lat = data(1,:);
lon = data(2,:);
alt = data(3,:) * 1000; %conversion to m from km
t = datetime( data(4,:), 'ConvertFrom', 'epochtime', 'Epoch', datetime(2023, 1, 1, 0, 0, 0));

obj = nodes.Located_Object()
obj = obj.SetPosition( ...
    'Latitude', lat, ...
    'Longitude', lon, ...
    'Altitude', alt)

ogs = nodes.Located_Object().SetPosition(LLA=[55.911420,-3.322424,84])

all(nodes.InEarthsShadow(obj, ogs) == nodes.InEarthsShadow(ogs, obj))

obj.RelativeHeadingAndElevation(ogs)
fliplr(ogs.RelativeHeadingAndElevation(obj))

elev1 = ogs.RelativeHeadingAndElevation(obj);
elev1(~nodes.InEarthsShadow(obj, ogs))

elev2 = obj.RelativeHeadingAndElevation(ogs);
elev2(~nodes.InEarthsShadow(obj, ogs))

all(obj.RelativeHeadingAndElevation(ogs) == fliplr(ogs.RelativeHeadingAndElevation(obj)))

unique(obj.Altitude > ogs.Altitude)

%% testing new link model
% clear all
% clc

hogs = new_HOGS(785);
spoqc = new_spoqc(785, '25/12/2022, 08:44, 14:50, 16:22, 17:55');

tx = nodes.freeSpaceTransmitterFrom("Satellite", spoqc)
tx.location
rx = nodes.freeSpaceReceiverFrom("Ground_Station", hogs)
rx.location

link = nodes.new_link_model(spoqc, hogs, "Ground_Station", "Satellite");
[geo, eff, apt, turb, atmos] = link.LinkLosses();
figure
hold on
plot(utilities.decibelFromPercentLoss(geo))
plot(utilities.decibelFromPercentLoss(eff))
plot(utilities.decibelFromPercentLoss(apt))
plot(utilities.decibelFromPercentLoss(turb))
plot(utilities.decibelFromPercentLoss(atmos))
legend("geo", "opt", "apt", "turb", "atmos")
title("new link model")
ylim([0, 50])


geo_db = utilities.decibelFromPercentLoss(geo);
eff_db = utilities.decibelFromPercentLoss(eff);
apt_db = utilities.decibelFromPercentLoss(apt);
turb_db = utilities.decibelFromPercentLoss(turb);
atmos_db = utilities.decibelFromPercentLoss(atmos);

mask = Pass.Elevation_Limit_Flags;
elevs = Pass.Elevations(mask);
[v, i] = max(elevs)
lower = elevs(1:i-1);
upper = elevs(i:end);
e = [lower - lower(end), fliplr(upper - upper(end))];

figure
hold on
area(e, [ ...
    geo_db(mask)', ...
    eff_db(mask)', ...
    apt_db(mask)', ...
    turb_db(mask)', ...
    atmos_db(mask)'])

size(e)
size(geo_db(mask))




% % atmospheric models match
% all(utilities.decibelFromPercentLoss(atmos) == Pass.Link_Model.Atmospheric_Loss_dB)
% 
% figure
% plot(utilities.decibelFromPercentLoss(geo) - Pass.Link_Model.Geometric_Loss_dB)
% 
% mean(utilities.decibelFromPercentLoss(geo) == Pass.Link_Model.Geometric_Loss_dB)
% 
% vis = nodes.Visibility(rx, tx);
% elevs = Pass.Elevations(Pass.Elevation_Limit_Flags);
% [v, i] = max(elevs)
% lower = elevs(1:i-1);
% upper = elevs(i:end);
% e = [lower - lower(end), fliplr(upper - upper(end))];
% figure
% hold on
% plot(e, Pass.QKD_Receiver.Detector.Visibility)
% plot(e, vis(Pass.Elevation_Limit_Flags))
% legend("old", "new")
% 
% figure
% plot(e, Pass.QKD_Receiver.Detector.Visibility - vis(Pass.Elevation_Limit_Flags))
% 
% phi = nodes.PhaseShiftFromRelativeMotion(rx, tx);
% Phi = Pass.QKD_Receiver.ComputeMotionPhaseShift(Pass.QKD_Transmitter);
% figure
% hold on
% plot(Phi)
% plot(phi)
% legend("old", "new")
% 
% shift = nodes.Doppler_Shift(rx, tx);
% Shift = Pass.QKD_Receiver.DopplerShift(Pass.QKD_Transmitter);
% figure
% hold on
% plot(Shift)
% plot(shift)
% legend("old", "new")
% 
% utilities.decibelFromPercentLoss(turb)
% 
% figure
% plot(Pass.Link_Model.r0)
