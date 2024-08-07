%% test detector preset builder
clear all
close all
clc

%% Example usage to generate Hamamatsu detector
clear all
Efficiency_Data_Location = 'Hamamatsu_efficiency.mat';
eff = load(Efficiency_Data_Location);

builder = detectorPresetBuilder() ...
    .addName("Hamamatsu") ...
    .addDarkCountRate(10) ...
    .addDeadTime(0) ...
    .addJitterHistogram(load('HamamatsuHistogram.mat').Counts, 10^-12) ...
    .addDetectorEfficiencyArray(eff.wavelengths, eff.efficiency) ...
    .makeDetectorPreset()

%% missing deadtime -> MISSING ANY PARAMETER SHOULD FAIL
clear all
Efficiency_Data_Location = 'Hamamatsu_efficiency.mat';
eff = load(Efficiency_Data_Location);

builder = detectorPresetBuilder() ...
    .addName("Hamamatsu") ...
    .addDarkCountRate(10) ...
    .addJitterHistogram(load('HamamatsuHistogram.mat').Counts, 10^-12) ...
    .addDetectorEfficiencyArray(eff.wavelengths, eff.efficiency) ...
    .makeDetectorPreset()

%% mismatched sizes of inputs -> SHOULD FAIL
clear all
Efficiency_Data_Location = 'Hamamatsu_efficiency.mat';
eff = load(Efficiency_Data_Location);

a = linspace(0, 1, 3);
ba = linspace(0, 0.9, 9);

builder = detectorPresetBuilder() ...
    .addName("Hamamatsu") ...
    .addDarkCountRate(10) ...
    .addDeadTime(0) ...
    .addJitterHistogram(load('HamamatsuHistogram.mat').Counts, 10^-12) ...
    .addDetectorEfficiencyArray(a, ba) ...
    .preset

%% mismatched shapes of inputs -> SHOULD FAIL
clear all
Efficiency_Data_Location = 'Hamamatsu_efficiency.mat';
eff = load(Efficiency_Data_Location);

a = linspace(0, 1, 3);
ba = reshape(linspace(0, 0.9, 9), [3, 3]);

builder = detectorPresetBuilder() ...
    .addName("Hamamatsu") ...
    .addDarkCountRate(10) ...
    .addDeadTime(0) ...
    .addJitterHistogram(load('HamamatsuHistogram.mat').Counts, 10^-12) ...
    .addDetectorEfficiencyArray(a, ba) ...
    .preset
