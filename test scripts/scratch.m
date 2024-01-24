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

lrt = libradtran.libRadtran("~/libRadtran-2.0.4/")

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
    .FileAndFormat("File", '~/Documents/conference_data/out1.txt');

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
    '~/Documents/conference_data', 'test1.txt', ...
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
[keys, data] = libRadtran.read_input_file(path)
data = libradtran.outputFromInputFile(path)
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
clear all
clc
ExampleHOGS

hogs = new_HOGS(785);
spoqc = new_spoqc(785, '25/12/2022, 08:44, 14:50, 16:22, 17:55');

loss = nodes.GeometricLoss("qkd", hogs, spoqc)
loss = nodes.GeometricLoss("beacon", hogs, spoqc)

mask = Pass.Elevation_Limit_Flags;

figure
hold on
plot(Pass.Times(mask), ...
    Pass.Downlink_Beacon_Link_Model.Geometric_Loss_dB(mask) ...
    - utilities.decibelFromPercentLoss(loss(mask)))

Pass.plot()

[loss_s_dl, extras_s_dl] = nodes.linkLoss("qkd", hogs, spoqc, "apt", "optical", "geometric", "turbulence", "atmospheric", "dB", true)

[loss_b_dl, extras_b_dl] = nodes.linkLoss("beacon", hogs, spoqc, "apt", "optical", "geometric", "turbulence", "atmospheric")

[loss_b_ul, extras_b_ul] = nodes.linkLoss("beacon", spoqc, hogs, "apt", "optical", "geometric", "turbulence", "atmospheric")

[loss_b_dl, extras_b_dl] = nodes.linkLoss("beacon", hogs, spoqc, "apt", "optical", "geometric", "turbulence", "atmospheric", "dB", true)

[new_loss, new_extras] = nodes.linkLoss("beacon", hogs, spoqc, "apt", "geometric", "optical", "turbulence", "atmospheric")

figure
new_loss.plotLosses(spoqc.Times, "time (s)", "mask", Pass.Elevation_Limit_Flags)


beacon_loss_down = beacon.beaconSimulation(hogs, spoqc);
beacon_loss_down.plot(spoqc.Times, "time (s)", "mask", Pass.Elevation_Limit_Flags)

beacon_loss_up = beacon.beaconSimulation(spoqc, hogs);
beacon_loss_up.plot(spoqc.Times, "time (s)", "mask", Pass.Elevation_Limit_Flags)

beacon_loss.losses.plotLosses(spoqc.Times, "time (s)", "mask", Pass.Elevation_Limit_Flags)

%close all
result = nodes.QkdPassSimulation(hogs, spoqc, "DecoyBB84");
fig = result.plotResult(spoqc.Times, "Time (s)", hogs, spoqc, "mask", "Elevation")


hogs.Location_Name

result.losses.plotLosses(spoqc.Times, "time (s)", "mask", Pass.Elevation_Limit_Flags)
total_loss = result.losses.TotalLoss("dB");
figure
plot(spoqc.Times(Pass.Elevation_Limit_Flags), total_loss(Pass.Elevation_Limit_Flags))

figure
hold on
plot(utilities.decibelFromPercentLoss(beacon_loss.losses.geometric))

utilities.decibelFromProbabilityLoss(beacon_loss_up.losses.geometric(mask))
utilities.probabilityFromDecibelLoss( utilities.decibelFromProbabilityLoss(beacon_loss_up.losses.geometric(mask)))
beacon_loss_up.losses.geometric(mask)

[l, w] = nodes.GeometricLoss("beacon", hogs, spoqc);

[loss_s_dl, extras_s_dl] = nodes.linkLoss("qkd", hogs, spoqc, "apt", "optical", "geometric", "turbulence", "atmospheric", "dB", true)
mask = Pass.Elevation_Limit_Flags;
total_loss = loss_s_dl.TotalLoss("dB")
figure
plot(spoqc.Times(mask), total_loss(mask))

figure
hold on
plot(spoqc.Times(mask), loss_s_dl.geometric(mask))
plot(spoqc.Times(mask), Pass.Downlink_Beacon_Link_Model.Geometric_Loss_dB(mask))

figure
hold on
plot(spoqc.Times(mask), beacon_loss.total_loss_db(mask))
plot(spoqc.Times(mask), Pass.Downlink_Beacon_Link_Model.Link_Loss_dB(mask))

props = properties(beacon_loss.losses)
props = props(~contains(props, {'unit', 'kind'}))
cell2mat(cellfun(@(p) beacon_loss.losses.(p), props, "UniformOutput", false))

beacon_loss.losses

tx = nodes.freeSpaceTransmitterFrom(spoqc);
rx = nodes.freeSpaceReceiverFrom(hogs);


losses = nodes.new_link_model.LinkLosses(hogs, spoqc, ...
    "apt", "optical", "geometric", "turbulence", "atmospheric" );
figure
hold on
plot(utilities.decibelFromPercentLoss(losses.apt))
plot(utilities.decibelFromPercentLoss(losses.optical))
plot(utilities.decibelFromPercentLoss(losses.geometric))
plot(utilities.decibelFromPercentLoss(losses.turbulence))
plot(utilities.decibelFromPercentLoss(losses.atmospheric))
legend("apt", "opt", "geo", "turb", "atmos")
title("new link model")
ylim([0, 50])

all_losses = utilities.decibelFromPercentLoss(cell2mat(struct2cell(losses)));
mask = Pass.Elevation_Limit_Flags;

figure
area( ...
    spoqc.Times(mask), ...
    all_losses(:, mask)')

link.lossStackPlot("mask", mask)


losses = nodes.new_link_model.LinkLosses(hogs, spoqc, ...
    "apt", "optical", "geometric", "turbulence", "atmospheric" );

loss_db = link.TotalLoss("dB", true);

figure
plot(loss_db)

keys = {'apt', 'optical', 'geometric', 'turbulence', 'atmospheric', 'apt'};
[uc, ~, idx] = unique(keys);

geo_db   = utilities.decibelFromPercentLoss(losses.apt);
eff_db   = utilities.decibelFromPercentLoss(losses.optical);
apt_db   = utilities.decibelFromPercentLoss(losses.geometric);
turb_db  = utilities.decibelFromPercentLoss(losses.turbulence);
atmos_db = utilities.decibelFromPercentLoss(losses.atmospheric);

mask = Pass.Elevation_Limit_Flags;
elevs = Pass.Elevations(mask);
[v, i] = max(elevs)
lower = elevs(1:i-1);
upper = elevs(i:end);
e = [lower - lower(end), fliplr(upper - upper(end))];

figure
hold on
area(Pass.Times(mask), [ ...
    geo_db(mask)', ...
    eff_db(mask)', ...
    apt_db(mask)', ...
    turb_db(mask)', ...
    atmos_db(mask)'])

size(e)
size(geo_db(mask))

figure
plot(Pass.Times(mask), Pass.Link_Model.Geometric_Loss_dB(mask) - geo_db(mask))
legend("geo")

figure
plot(Pass.Times(mask), Pass.Link_Model.Optical_Efficiency_Loss(mask) - losses.optical(mask))
legend("opt")

figure
plot(Pass.Times(mask), Pass.Link_Model.APT_Loss_dB(mask) - apt_db(mask))
legend("apt")

figure
plot(Pass.Times(mask), Pass.Link_Model.Turbulence_Loss_dB(mask) - turb_db(mask))
legend("turb")

figure
plot(Pass.Times(mask), Pass.Link_Model.Atmospheric_Loss_dB(mask) - atmos_db(mask))
legend("atmos")

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

%% 

wavelength = 785;
wavenumber = 2 * pi / (wavelength * (1e-9));
num2str(wavenumber)
zeniths = linspace(0, 90, 10);
old_r0 = atmospheric_turbulence_coherence_length_downlink( ...
    wavenumber, zeniths, 600, ghv_defaults('Standard', 'HV10-10'));
range = slant_range(600, 90-zeniths, "angle_unit", units.Angle.Degrees);
fried_param = FriedParameter(nodes.LinkDirection.Downlink, ...
    "Hufnagel_Valley", HufnagelValley.HV10_10);
r0 = fried_param.AtmosphericTurbulenceCoherenceLength(600, zeniths, wavelength);
figure
hold on
plot(zeniths, old_r0)
plot(zeniths, r0)
legend("old", "new")

close all


generalised_hufnagel_valley(ghv_defaults('Standard', 'HV10-10'), 600)
HufnagelValley.HV10_10.Calculate(600)

old_r0
r0

r0 .* 10


nodes.LinkDirection.Height(range, zeniths, 0.1)


%% 
keys = {'geometric', 'optical', 'apt', 'turbulence', 'atmospheric'}
for k = keys
    disp(k)
    break
end

%%

%% 2.1µm detector
clear all

preset_path = "~/Downloads/SNSPD_2um_Chang.mat"
preset = components.DetectorPresetBuilder().loadPreset(preset_path)

options = { ...
    'Wavelength', 'Repetition_Rate', 'Efficiency', ...
    'Mean_Photon_Number', 'State_Prep_Error', 'g2', ...
    'State_Probabilities'}
choices = {'Wavelength', 'Repetition_Rate'}
ismember(choices, options)
mustBeMember(choices, options)

props = properties(components.Detector.empty(0))

props = props(ismember(props, choices))'

i = 0;
for p = props'
    disp(p{1})
    i = i + 1
end

channel_wavelength = 785;
repetition_rate = 1E8;
time_gate = 2E-9;
filter_file = '~/Projects/QKD_Sat_Link/adaptive_optics/Example Data/spectral filters';
spectral_filter = SpectralFilter('input_file',[filter_file, filesep(),'FBH780-10.xlsx']);
detector = components.Detector( ...
    channel_wavelength, ...
    repetition_rate, ...
    time_gate, spectral_filter, ...
    "Preset", components.loadPreset("Excelitas") );

protocol.isOrHasSource(detector)
protocol.isOrHasDetector(detector)

hub_sat_source_mp_ns = [0.8,0.3,0];
hub_sat_source_probs = [0.75,0.25,0.25];
hub_sat_source_rep_rate = 1E8;
hub_sat_source_g2 = 0.01;
hub_sat_source_efficiency = 1;
hub_sat_source_state_prep_error = 0.0025;
wavelength = 785;
source = components.Source(wavelength,...
    'Mean_Photon_Number', hub_sat_source_mp_ns,...
    'State_Probabilities', hub_sat_source_probs,...
    'Repetition_Rate', hub_sat_source_rep_rate,...
    'g2', hub_sat_source_g2,...
    'Efficiency', hub_sat_source_efficiency,...
    'State_Prep_Error', hub_sat_source_state_prep_error);

protocol.isOrHasSource(source)


bb84_proto = protocol.bb84()
decoy_proto = protocol.decoyBB84()
ekart91 = protocol.e91()
coherent_one_way = protocol.cow()
differential_phase_shift = protocol.dps()

protocol.deriveAliceAndBob(source, detector)

hogs = new_HOGS(785);
hogs.Bob()
protocol.Bob(hogs)

props = properties(hogs);
class(hogs.(props{1}))

hogs.(string(props(cell2mat(cellfun(@(prop) isa(hogs.(prop), 'components.Detector'), props, UniformOutput=false)))))

utilities.getPropertyFromObject(hogs, "components.Detector")

protocol.Bob(detector)
protocol.Bob([detector, detector])

det1 = detector;
det1.Visibility = 0.6;

[protocol.Bob([detector, det1]).detector.Visibility]

dets = [detector, det1];

protocol.Bob(dets)

protocol.Bob(dets)

h = [hogs, hogs]

[h.Detector]

spoqc = new_spoqc(785, "26/12/2022 05:15, 06:49, 08:22, 09:54")
spoqc.Alice()
Alice(spoqc)

al = spoqc.Alice()

utilities.getPropertyFromObject(spoqc, 'components.Source')

try
    det = utilities.getPropertyFromObject(spoqc, 'components.Detector');
catch err
    switch err.identifier
    case 'utilities:getPropertyFromObject'
        det = components.Detector.empty(0);
    end
end

protocol.Alice(spoqc)


sources = [spoqc, spoqc]
spoqc.Detector = detector
protocol.Alice(sources, ~)

spoqc.Detector = hogs.Detector

spoqc.Alice()
protocol.Alice(spoqc)

protocol.Bob(spoqc)
spoqc.Bob()

protocol.bb84()

protocol.detectorRequirements.Wavelength

protocol.detectorRequirements.features("Dead_Time", "Wavelength", "Dead_Time")
protocol.sourceRequirements.features("g2", "Repetition_Rate", "g2")

protocol.bb84()
protocol.decoyBB84()

%%
close all
clear all
new_full_example
