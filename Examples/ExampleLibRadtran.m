libRadTranPath = utilities.nativePathFrom('C:\Users\ccs2000\Documents\libRadtran-2.0.5\');
output_file_location = 'C:\Users\ccs2000\Desktop\libRadtran_bin\';


lrt = libradtran.libRadtran(libRadTranPath);

atm = lrt.GeneralAtmosphereSettings() ...
    .Atmosphere("Default", "midlatitude_summer");

spec = lrt.SpectralSettings() ...
    .RadiationSource("solar", "File",  utilities.nativePathFrom([libRadTranPath,'data\solar_flux\kurudz_1.0nm.dat']))...
    .WavelengthRange(500, 1600);

alb = lrt.SurfaceSettings() ...
    .SurfaceAlbedo(0.02);

rte = lrt.SolverSettings() ...
    .Solver("mystic");

mc = lrt.MysticsSettings() ...
    .Photons(1000)...
    .Polarisation("(0) (1,0,0,0) (default)")...
    .Backward()...
    .BackwardOutput("edn")...
    .Basename([output_file_location,'mystic'])...
    .Vroom("on")...
    .RadAlpha(1);

geo = lrt.GeometrySettings() ...
    .OutputPolarAngles(0, "Degrees")...
    .SolarAzimuthAngle(0)...
    .OutputAltitudes(1)...
    .Time(datetime("now"))... %this must be a time during the day, do not use datetime("today")!
    .SensorLatitude("N", 56.405)...
    .SensorLongitude("W", 3.183);

out = lrt.OutputSettings() ...
    .OutputColumns("lambda", "zout", "uu", "edir", "eglo", "edn", "eup", "enet", "esum")...
    .OutputQuantity("reflectivity")...
    .PostProcessing("per_nm")...
    .FileAndFormat("File", [output_file_location,'output.txt']);

mol = lrt.MoleculeSettings()...
    .MolecularAbsorption("reptran coarse")...
    .CrossSectionModel("rayleigh_Bodhaine")...
    .ModifySpecies("O3", 200, "DU", "H2O", 20, "MM");

aer = lrt.AerosolSettings() ...
    .Season("Spring_Summer") ...
    .Default("on") ...
    .Visibility(50) ...
    .Species_file('maritime_polluted');

config_string = lrt.StringFromConfiguration();
%disp(char(config_string))

Output_file = RunConfiguration(lrt,output_file_location,'input','Verbosity','Verbose');

Data = libradtran.ReadData(lrt);