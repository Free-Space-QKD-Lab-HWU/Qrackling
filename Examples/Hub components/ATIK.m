function ATIKCamera = ATIK(Telescope,Exposure_Time,Spectral_Filter_Width)
%ATIK camera object constructor

%exposure time in s
%spectral filter width in nm

%% telescope
Telescope_Diameter = 0.25;                                                      %telescope diameter in m, used to calculate collecting area
Beacon_Telescope_Efficiency = 0.9;                                              %efficiency of beacon telescope optical path


ATIKCamera = beacon.Camera(Telescope,...
            'Quantum_Efficiency',1,...
            'Exposure_Time', Exposure_Time,...
            'Spectral_Filter_Width',Spectral_Filter_Width,...
            'Detector_Diameter',0.0017,...
            'Focal_Length', 0.0125,...
            'Readout_Noise', 2.4,...
            'Dark_Current', 0.027,...
            'Full_Well_Capacity', 11000,...
            'Pixels',[4096,3008]);
end
