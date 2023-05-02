%% Making some presets
clear all
close all
clc

%% Example usage to generate Hamamatsu detector
clear all
close all
clc

Efficiency_Data_Location = 'Hamamatsu_efficiency.mat';
eff = load(Efficiency_Data_Location);

Hamamatsu = detectorPresetBuilder() ...
    .addName('Hamamatsu') ...
    .addDarkCountRate(10) ...
    .addDeadTime(0) ...
    .addJitterHistogram(load('HamamatsuHistogram.mat').Counts, 10^-12) ...
    .addDetectorEfficiencyArray(eff.wavelengths, eff.efficiency);

Hamamatsu.makeDetectorPreset()
Hamamatsu.writePreset('~/Projects/QKD_Sat_Link/detector_presets/detectors/presets/Hamamatsu.mat')


%% Example usage to generate Perkin Elmer detector
clear all
close all
clc

Efficiency_Data_Location = 'perkin_elmer_efficiency.mat';
eff = load(Efficiency_Data_Location);

Perkin_Elmer = detectorPresetBuilder() ...
    .addName('Perkin Elmer') ...
    .addDarkCountRate(10) ...
    .addDeadTime(0) ...
    .addJitterHistogram(load('PerkinElmerHistogram.mat').Counts, 10^-12) ...
    .addDetectorEfficiencyArray(eff.wavelengths, eff.efficiency);

Perkin_Elmer.makeDetectorPreset()
Perkin_Elmer.writePreset('~/Projects/QKD_Sat_Link/detector_presets/detectors/presets/PerkinElmer.mat')


%% Example usage to generate Excelitas detector
clear all
close all
clc

Efficiency_Data_Location = 'Excelitas_efficiency.mat';
eff = load(Efficiency_Data_Location);

Excelitas = detectorPresetBuilder() ...
    .addName('Excelitas') ...
    .addDarkCountRate(10) ...
    .addDeadTime(0) ...
    .addJitterHistogram(load('ExcelitasHistogram.mat').Counts, 10^-12) ...
    .addDetectorEfficiencyArray(eff.wavelengths, eff.efficiency);

Excelitas.makeDetectorPreset()
Excelitas.writePreset('~/Projects/QKD_Sat_Link/detector_presets/detectors/presets/Excelitas.mat')


%% Example usage to generate Micro Photon Devices detector
clear all
close all
clc

Efficiency_Data_Location = 'MPD_efficiency.mat';
eff = load(Efficiency_Data_Location);

MPD = detectorPresetBuilder() ...
    .addName('Micro Photon Devices') ...
    .addDarkCountRate(10) ...
    .addDeadTime(77e-9) ...
    .addJitterHistogram(load('MPDHistogram.mat').Counts, 10^-12) ...
    .addDetectorEfficiencyArray(eff.wavelengths, eff.efficiency);

MPD.makeDetectorPreset()
MPD.writePreset('~/Projects/QKD_Sat_Link/detector_presets/detectors/presets/MicroPhotonDevices.mat')


%% Example usage to generate Laser Components detector
clear all
close all
clc

Efficiency_Data_Location = 'LaserComponents_efficiency.mat';
eff = load(Efficiency_Data_Location);

LaserComp = detectorPresetBuilder() ...
    .addName('Laser Components') ...
    .addDarkCountRate(10) ...
    .addDeadTime(0) ...
    .addJitterHistogram(load('LaserComponentHistogram.mat').Counts, 10^-12) ...
    .addDetectorEfficiencyArray(eff.wavelengths, eff.efficiency);

LaserComp.makeDetectorPreset()
LaserComp.writePreset('~/Projects/QKD_Sat_Link/detector_presets/detectors/presets/LaserComponents.mat')


%% testing
close all
clear all
clc
Efficiency_Data_Location = 'LaserComponents_efficiency.mat';
eff = load(Efficiency_Data_Location);
test = DetectorPresets.Custom
test.PresetLoader() ...
    .addName('Laser Components') ...
    .addDarkCountRate(10) ...
    .addDeadTime(0) ...
    .addJitterHistogram(load('LaserComponentHistogram.mat').Counts, 10^-12) ...
    .addDetectorEfficiencyArray(eff.wavelengths, eff.efficiency) ...
    .makeDetectorPreset()

% load the Hamamatsu
DetectorPresets.Hamamatsu.LoadPreset()

% Test custom loading (using the LaserComponents.mat as the test case for a users detector)
DetectorPresets.Custom.LoadPreset('LaserComponents.mat')

% Load the preset thats held in the enumeration (Hamamatsu) not in the customPath
DetectorPresets.Hamamatsu.LoadPreset('LaserComponents.mat')
