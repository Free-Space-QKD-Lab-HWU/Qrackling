%% Detector Presets
% The Qrackling toolbox allows convenient bundling of detector performance data 
% shipping data for a range of devices covering both avalanche photon diodes and 
% superconducting nanowires, that we have collected either experimentally or extracted 
% from manuals. These can be easily accessed with:
%%
% 
%   components.loadPreset
%
%% 
% Each of these presets contains data for wavelength dependent detection efficiency, 
% a jitter histogram, the dead time of the detector and a dark count rate. From 
% this we can get an accurate representation of the detector performance at our 
% chosen wavelength, provided its within the range the detector is intended to 
% operate over.
% 
% For the preset detector we bundle into the toolbox the following devices are 
% currently available:
%% 
% * Excelitas
% * Hamamatsu
% * LaserComponents
% * MicroPhotonDevices
% * PerkinElmer
% * ID_Qube_NIR
% * QuantumOpus1550_RoomTemperatureAmplifier
% * QuantumOpus1550_CryogenicAmplifier
%% 
% these names can be used as arguments to components.loadPreset. In the rest 
% of this example we will go through the process of creating a new detector preset 
% that we can use later.
%% Loading the Data
% For this example the <https://opg.optica.org/prj/fulltext.cfm?uri=prj-10-4-1063&id=470770 
% nanowire detector at 2.1µm from Jin et-al> will be used. The files used here 
% are available in Examples/Data/ and have been extracted from the paper.

loc = which('components.loadPreset');
[path, ~, ~] = fileparts(loc);
elems = strsplit(path, filesep);
path_root = string(join(elems(1:end-1), filesep)) + filesep;
whichSeparator = @(Path, Sep) Sep{cellfun(@(sep) contains(Path, sep), Sep)};
MakePathNative = @(Path) strjoin(strsplit(Path, whichSeparator(Path, {'/', '\'})), filesep);
example_path = "Examples/Data/detector_data_doi_10_1364_PRJ_437834/";
data_path = path_root + MakePathNative(example_path);

paths = dir(data_path);
FilterStrings = @(haystack, needle) haystack(arrayfun(@(h) contains(h, needle), haystack));
csv_files = FilterStrings({paths.name}, ".csv");
disp(csv_files')
%% Detection Efficiency
% The paper presents a figure for detection efficiency, we will take some liberties 
% here with the data and interpolate over the four data points. This will give 
% us a reasonable representation of the detector efficiency over its quoted operation 
% range.

efficiency_data = readtable(data_path + csv_files{contains(csv_files, "efficiency")});

wavelengths = linspace(efficiency_data.Wavelength_nm(1), efficiency_data.Wavelength_nm(end), 1000);
efficiency = interpn( ...
    efficiency_data.Wavelength_nm, ...
    efficiency_data.Efficiency_percent ./ 100, ...
    wavelengths, ...
    'makima');

figure
hold on
grid on
scatter(efficiency_data.Wavelength_nm, efficiency_data.Efficiency_percent ./ 100)
plot(wavelengths, efficiency)
legend("Measured Data", "Interpolated")
xlabel("wavelengths (nm)")
ylabel("Detection Efficiency")
title("Detector Efficiency")
hold off
%% Jitter Data
% Next we will do the same with the jitter figure presented. For this part of 
% the detector preset we must have equal spacing between each of the data points 
% to use it as a histogram, to achieve this we will again interpolate the data, 
% this time we will do it over a linspace such that we now know that each bin 
% has a width of 1ps.

jitter_data = readtable(data_path + csv_files{contains(csv_files, "jitter")});

times = linspace(jitter_data.time_ps(1), jitter_data.time_ps(end), 1000);
counts = abs(interpn(jitter_data.time_ps, jitter_data.normalised_counts, times));

figure
hold on
grid on
scatter(jitter_data.time_ps, jitter_data.normalised_counts)
plot(times, counts)
legend("Measured Data", "Interpolated")
xlabel("Time (ps)")
ylabel("Normalised Counts")
title("Jitter Histogram")
hold off
%% Pulse Trace

pulse_data = readtable(data_path + csv_files{contains(csv_files, "pulse")});

times_pulse = linspace(pulse_data.Time_ns(1), pulse_data.Time_ns(end), 100);
amplitudes = smoothdata(pulse_data.normalised_amplitude, "gaussian", 6);

figure
hold on
grid on
scatter(pulse_data.Time_ns, pulse_data.normalised_amplitude)
plot(pulse_data.Time_ns, amplitudes)
legend("Measured Data", "Smoothed")
xlabel("Time (ps)")
ylabel("Normalised Amplitude")
title("Detector Pulse Trace")
hold off
%% Building the Preset
% The class:
%%
% 
%   components.DetectorPresetBuilder
%
%% 
% provides us a builder interface, we can use the 'add' functions present to 
% build a detector preset and finally call 'makeDetectorPreset()' on this builder 
% to get a validated and complete detector preset object. This is ready to be 
% used with the rest of the toolbox.

superconducting_NbTiN_nanowires_preset = components.DetectorPresetBuilder() ...
    .addName("Single Quantum NbTiN nanowire") ...
    .addDarkCountRate(10) ...
    .addDeadTime(11.6e-9) ... % we know this from the paper
    .addDetectorEfficiencyArray(wavelengths, efficiency) ...
    .addJitterHistogram(counts, 1e-12);
superconducting_NbTiN_nanowires_preset.makeDetectorPreset()
%% 
% Alternatively, we might want to use this data later and save ourselves the 
% building process. The 'writePreset' function will validate the data held in 
% the builder class and save it to the specified file path.

save_path = strjoin([string(userpath), "superconducting_NbTiN.mat"], filesep);
superconducting_NbTiN_nanowires_preset.writePreset(save_path);
%% 
% We can then use the preset we created like so:

my_preset = components.DetectorPresetBuilder().loadPreset(save_path)
%% 
%