lrt = libradtran.libRadtran("C:\Users\ccs2000\Documents\libRadtran-2.0.5\")

Aerosols = lrt.AerosolSettings();
Clouds = lrt.CloudsSettings();
GeneralAtmosphere = lrt.GeneralAtmosphereSettings();
Molecules = lrt.MoleculeSettings();
Surface = lrt.SurfaceSettings();
Mystic = lrt.MysticsSettings();
Spectrals = lrt.SpectralSettings();
Solver = lrt.SolverSettings();
Outputs = lrt.OutputSettings();
