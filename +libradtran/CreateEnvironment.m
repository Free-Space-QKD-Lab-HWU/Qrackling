function Env = CreateEnvironment(LRT_path,options)
arguments
    LRT_path {mustBeFolder}
    options.headings {mustBeNumeric} = linspace(0,360,50);
    options.elevations {mustBeNumeric} = linspace(5,90,20);
    options.Time {mustBeA(options.Time,'datetime')} = datetime("01-Aug-2023 02:00:00");
    options.LLA (1,3) {mustBeNumeric} = [56.405,-3.183,0];
    options.WavelengthRange (1,2) {mustBeNonnegative} = [800,810];
    options.OutputFileName = [cd(),filesep(),'TempLRTOutputFile.out'];
    options.InputFileName = [cd(),filesep(),'TempLRTInputFile.txt'];
    options.Visibility (1,1) {mustBeNonnegative} = 100;
end


%% input sorting
if isstring(LRT_path)
    LRT_path = char(LRT_path);
end
if isstring(options.OutputFileName)
    options.OutputFileName = char(options.OutputFileName);
end
if isstring(options.InputFileName)
    options.InputFileName = char(options.InputFileName);
end

%% compute radiance
%default parts
lrt = libradtran.libRadtran(LRT_path);
lrt.GeneralAtmosphereSettings().Atmosphere("Default", "midlatitude_summer")...
                               .InterpolateZOut('on');
lrt.SpectralSettings().RadiationSource("solar", "File", strjoin({LRT_path,'data','solar_flux','kurudz_1.0nm.dat'},filesep));
lrt.SurfaceSettings().SurfaceAlbedo(0.02);
lrt.SolverSettings().Solver("disort")...
                    .Pseudospherical("on");
%set geometry
lrt.GeometrySettings()...
    .OutputPolarAngles(90-options.elevations,"Degrees")...
    .SolarAzimuthAngle(options.headings)...

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
    .OutputColumns("uu","lambda","edir","sza")...%("lambda", "uu", "edir", "eglo", "edn", "eup", "enet", "esum")...
    .FileAndFormat("File", options.OutputFileName);


[input_file_loc,input_file_name,input_file_ext] = fileparts(options.InputFileName);

%% compute transmission
%change to reflectivity
lrt.Output_Settings.OutputQuantity("reflectivity")

%set solar zenith angle to 0
lrt.Geometry_Settings.SolarZenithAngle(0);
%rerun
lrt.RunConfiguration(input_file_loc, [input_file_name,input_file_ext], 'Verbosity', 'Verbose');
%load in data
data_tran = libradtran.outputFromInputFile(options.InputFileName);
upwards_transmission = data_tran.edir;
angle_transmission = upwards_transmission'*cosd(90-options.elevations);
transmission = repmat(angle_transmission,[1,1,numel(options.headings)]);
transmission = permute(transmission,[1,3,2]);
transmission = flip(transmission,3);


%% calculate radiances
%set new geometry settings
New_Geo_Settings = libradtran.Groups.Geometry()...
    .Time(options.Time)...
    .OutputPolarAngles(90-options.elevations,"Degrees")...
    .SolarAzimuthAngle(options.headings);

if options.LLA(1)>0
New_Geo_Settings.SensorLatitude("N", options.LLA(1));
else
New_Geo_Settings.SensorLatitude("S",-options.LLA(1));
end
if options.LLA(2)>0
New_Geo_Settings.SensorLongitude("E", options.LLA(2));
else
New_Geo_Settings.SensorLongitude("W",-options.LLA(2));
end
New_Geo_Settings.OutputAltitudes(options.LLA(3)/1000); %need to convert from m to km

%replace geometry settings
lrt = lrt.ReplaceSettings('Geometry_Settings',New_Geo_Settings);

lrt.RunConfiguration(input_file_loc, [input_file_name,input_file_ext], 'Verbosity', 'Verbose');

data_rad = libradtran.outputFromInputFile(options.InputFileName);
radiances= data_rad.uu;
wavelengths = data_rad.lambda;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% at night, radiance returns nonzero values.
% should test over multiple hours to establish whether this is correct.
% is LRT returning some scattered daylight? or is this anomalous?

% should plot radiance for multiple hours overnight to establish
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% create environment file
Env = environment.Environment(options.headings,options.elevations,wavelengths,...
                  radiances,transmission);

