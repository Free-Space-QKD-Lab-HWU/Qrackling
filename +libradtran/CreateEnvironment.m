function Env = CreateEnvironment(LRT_path,options)
arguments
    LRT_path {mustBeFolder}
    options.headings {mustBeNumeric} = [0,1];%linspace(0,360,2);
    options.elevations {mustBeNumeric} = [1,89]%linspace(2,90,2);
    options.Time {mustBeA(options.Time,'datetime')} = datetime("01-Aug-2023 09:00:00");
    options.LLA (1,3) {mustBeNumeric} = [56.405,-3.183,10];
    options.WavelengthRange (1,2) {mustBeNonnegative} = [900,905];
    options.OutputFileName = [cd(),filesep(),'TempLRTOutputFile.txt'];
    options.InputFileName = [cd(),filesep(),'TempLRTInputFile.txt'];
    options.Visibility (1,1) {mustBeNonnegative} = 50;
end


%% input sorting
if isstring(LRT_path)
    LRT_path = char(LRT_path);
end
%if LRT_path(end) ~= filesep()
%    LRT_path = [LRT_path,filesep()];
%end
if isstring(options.OutputFileName)
    options.OutputFileName = char(options.OutputFileName);
end
if isstring(options.InputFileName)
    options.InputFileName = char(options.InputFileName);
end

%% compute radiance
%default parts
lrt = libradtran.libRadtran(LRT_path);
lrt.GeneralAtmosphereSettings().Atmosphere("Default", "midlatitude_winter");
lrt.SpectralSettings().RadiationSource("solar", "File", strjoin({LRT_path,'data','solar_flux','kurudz_1.0nm.dat'},filesep));
lrt.SurfaceSettings().SurfaceAlbedo(0.02);
lrt.SolverSettings().Solver("disort").Pseudospherical("on");

%set geometry
geo = lrt.GeometrySettings()...
    .OutputPolarAngles(90-options.elevations,"Degrees")...
    .SolarAzimuthAngle(options.headings)...
    .Time(options.Time);
if options.LLA(1)>0
geo.SensorLatitude("N", options.LLA(1));
else
geo.SensorLatitude("S",-options.LLA(1));
end
if options.LLA(2)>0
geo.SensorLongitude("E", options.LLA(2));
else
geo.SensorLongitude("W",-options.LLA(2));
end
geo.OutputAltitudes(options.LLA(3)/1000); %need to convert from m to km

lrt.MoleculeSettings()...
    .MolecularAbsorption("reptran coarse")...
    .CrossSectionModel("rayleigh_Bodhaine")...
    .ModifySpecies("O3", 200, "DU", "H2O", 20, "MM");

lrt.AerosolSettings() ...
    .Default("on") ...
    .Visibility(options.Visibility);

lrt.SpectralSettings() ...
    .WavelengthRange(options.WavelengthRange(1),options.WavelengthRange(2));

lrt.OutputSettings() ...
    .OutputColumns("lambda", "uu", "edir", "eglo", "edn", "eup", "enet", "esum")...
    .FileAndFormat("File", options.OutputFileName);

[input_file_loc,input_file_name,input_file_ext] = fileparts(options.InputFileName);
lrt.RunConfiguration(input_file_loc, [input_file_name,input_file_ext], 'Verbosity', 'Verbose');

%load in data
radiances = libradtran.outputFromInputFile(options.InputFileName).uu;

%% compute transmission
%change to transmittance
lrt.Output_Settings.OutputQuantity("transmittance")
%rerun
lrt.RunConfiguration(input_file_loc, [input_file_name,input_file_ext], 'Verbosity', 'Verbose');
%load in data
transmission = libradtran.outputFromInputFile(options.InputFileName).uu;

%reshape to be compatible with environment
radiances = permute(radiances,[2,3,1]);
transmission = permute(transmission,[2,3,1]);

%% create environment file
wavelengths = options.WavelengthRange(1):1:options.WavelengthRange(2);
Env = environment.Environment(options.headings,options.elevations,wavelengths,...
                  transmission,radiances);

