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
Beacon_Telescope_Diameter = 0.1;                                   %beacon telescope diameter in m, used to calculate collecting area
Beacon_Telescope_Efficiency = 0.9;                                 %efficiency of beacon telescope optical path
Beacon_Camera_Efficiency = 0.9;                                     %optical efficiency of beacon camera and imaging system
Beacon_Camera_Noise = 1E-9;                                         %rms noise power floor in camera, in W
Beacon_Wavelength = 850;                                            %beacon wavelength in nm
Camera_Scope = Telescope(Beacon_Telescope_Diameter,...
    'Wavelength',Beacon_Wavelength,...
    'Optical_Efficiency',Beacon_Telescope_Efficiency);
HOGS_Camera = Camera(Camera_Scope,...
    'Detection_Efficiency',Beacon_Camera_Efficiency,...
    'Noise',Beacon_Camera_Noise);

%% construct OGS at Errol
HOGS=Errol_OGS(HOGS_Detector,HOGS_Telescope,'Camera',HOGS_Camera);
end

