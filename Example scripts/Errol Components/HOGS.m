function HOGS = HOGS()
%HOGS Construct HOGS
% need to detail the correct OGS parameters and components
% need to implement the Errol_OGS class to give the correct position

%% parameters and components
%Telescope
Telescope_Diameter = 0.7;                                           %telescope diameter in m
Pointing_Jitter = 1E-6;                                             %pointing error in rads
Optical_Efficiency = 0.6;                                           %optical efficiency of telescope (dimensionless)
HOGS_Telescope = Telescope(Telescope_Diameter,...
    'Pointing_Jitter',Pointing_Jitter,...
    'Optical_Efficiency',Optical_Efficiency);

%Detector
Wavelength = 785;                                                   %signal wavelength in nm
Repetition_Rate = 1E8;                                              %signal rep rate in Hz
Time_Gate = 2E-9;                                                   %time gate width in s
Spectral_Filter_Width = 2;                                          %spectral filter width in nm
HOGS_Detector = MPD_Detector(Wavelength,Repetition_Rate,...
    Time_Gate,Spectral_Filter_Width);

%beacon camera
HOGS_Camera = ATIK();%this is a constructor for the ATIK camera we use

%uplink beacon
Beacon_Power = 2;                                                               %power of uplink beacon in W
Beacon_Wavelength = 850;                                                        %uplink beacon wavelength in nm
BeaconPointingPrecision = 1E-3;                                                 %beacon pointing precision (coarse pointing precision) in rads
BeaconEfficiency = 1;                                                           %beacon optical efficiency (unitless)
HOGSBeacon = Gaussian_Beacon(HOGS_Telescope,Beacon_Power,Beacon_Wavelength,...
                   'Pointing_Jitter',BeaconPointingPrecision,...
                    'Power_Efficiency',BeaconEfficiency);

%% construct OGS at Errol
HOGS=Errol_OGS(HOGS_Telescope,...
                'Detector',HOGS_Detector,...
                'Camera',HOGS_Camera,...
                'Beacon',HOGSBeacon,...
                'Atmosphere_File_Location',['SMARTS_connection',filesep,'SMARTS cache',filesep,'Errol_Atmosphere_winter_times.mat']);%choose a midnight simulation so that time is night );
end

