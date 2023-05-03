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
    .addDeadTime(1e-6) ...
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


%% Examples of DetectorPresets.Custom
close all
clear all
clc

Efficiency_Data_Location = 'LaserComponents_efficiency.mat';
eff = load(Efficiency_Data_Location);

% Define a detector preset inplace from the "Custom" enum
test = DetectorPresets.Custom.PresetLoader() ...
    .addName('Laser Components') ...
    .addDarkCountRate(10) ...
    .addDeadTime(0) ...
    .addJitterHistogram(load('LaserComponentHistogram.mat').Counts, 10^-12) ...
    .addDetectorEfficiencyArray(eff.wavelengths, eff.efficiency) ...
    %.makeDetectorPreset()

% load the Hamamatsu
DetectorPresets.Hamamatsu.LoadPreset()

% Test custom loading (using the LaserComponents.mat as the test case for a users detector)
DetectorPresets.Custom.LoadPreset('LaserComponents.mat')

% Load the preset thats held in the enumeration (Hamamatsu) not in the path
DetectorPresets.Hamamatsu.LoadPreset('LaserComponents.mat')

%% Test AltDetector
close all
clear all
clc

wvl = 800;
rr = 1e9;
timeGate = 1e-9;
spectralWidth = 1;

% AltDetector( ...
%     DetectorPresets.Hamamatsu.LoadPreset, ...
%     wvl, rr, timeGate, spectralWidth)

Efficiency_Data_Location = 'MPD_efficiency.mat';
eff = load(Efficiency_Data_Location);

newPreset = DetectorPresets.Custom.PresetLoader() ...
    .addName('Micro Photon Devices') ...
    .addDarkCountRate(10) ...
    .addDeadTime(0) ...
    .addJitterHistogram(load('MPDHistogram.mat').Counts, 10^-12) ...
    .addDetectorEfficiencyArray(eff.wavelengths, eff.efficiency);

assert(~isempty(newPreset.makeDetectorPreset()), '...')


detector = AltDetector(wvl, rr, timeGate, spectralWidth, ...
    Preset=newPreset.makeDetectorPreset() )

detectorPresetBuilder().BuildPresetFromDetector('a test', detector).makeDetectorPreset()

detector = AltDetector(wvl, rr, timeGate, spectralWidth)

%detector.HistogramInfo;

% figure
% plot(detector.Valid_Wavelength, detector.Efficiencies_Values)
% 
% figure
% bins = linspace(1, numel(detector.Histogram_Data), numel(detector.Histogram_Data));
% time_bins = bins .* detector.Histogram_Bin_Width .* 1e9;
% plot(time_bins, detector.Histogram_Data)
% 
% figure
% plot(time_bins, gradient(detector.Histogram_Data))
% 
% figure
% plot(time_bins, gradient(smooth(detector.Histogram_Data, 1000)))
% 
% upperHalf = @(array) array >= (max(array) / 2);
% width = @(array) array(end) - array(1);
% fwhm = @(xarray, yarray) width(xarray(upperHalf(yarray)));
% fwhm(time_bins, detector.Histogram_Data)
% shift = floor(fwhm(bins, detector.Histogram_Data) / 4)
% 
% x = smooth(detector.Histogram_Data, 1000);
% bins(max(x) == x)
% 
% x2 = x - circshift(x, shift);
% mask = (abs(x2) / max(abs(x2))) > 0.05;
% figure
% plot(bins(mask), detector.Histogram_Data(mask))
% 
% figure
% plot(time_bins, abs(x))
% 
% mask = abs(x) > (0.1 * max(abs(x)));
% firstLast = @(array) [array(1), array(end)];
% a = firstLast(find(mask == 1))
% 
% figure
% plot(time_bins(mask), x(mask))
% 
% 
