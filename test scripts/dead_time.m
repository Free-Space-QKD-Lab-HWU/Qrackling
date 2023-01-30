%% top hat for dead time
clear all
close all

extrema = @(array) [min(array), max(array)];

OrbitDataFileLocation = '500kmOrbitLLAT.txt';
OrbitDataFileLocation= '500kmSSOrbitLLAT.txt';
Time_Gate_Width = 10^-9;
Repetition_Rate = 1;
Spectral_Filter_Width = 1;
Wavelength = 850;

detector = MPD_Detector(Wavelength, ...
                      Repetition_Rate, ...
                      Time_Gate_Width, ...
                      Spectral_Filter_Width);

bin_width_ns = (1e-9) / detector.Histogram_Bin_Width;
N = numel(detector.PDF);
index = linspace(1, N, N);
times = detector.Histogram_Bin_Width .* index .* 1e9;

peak_loc = index(detector.Histogram_Data == max(detector.Histogram_Data));
% mm_pdf = extrema(detector.Histogram_Data);
min_val = 0.01;
max_val = 0.01;
up_to_max = (detector.Histogram_Data > min_val * min(detector.Histogram_Data)) & (times < times(peak_loc));
rising = up_to_max & (detector.Histogram_Data > min_val * max(detector.Histogram_Data));

after_max = (times > times(peak_loc));
falling = after_max & (detector.Histogram_Data > min_val * max(detector.Histogram_Data));


figure
hold on 
subplot(1, 2, 1)
plot(times, detector.Histogram_Data);
xlabel('ns')
xlim(extrema(times(rising)))
subplot(1, 2, 2)
plot(times, detector.Histogram_Data);
xlabel('ns')
xlim(extrema(times(falling)))
hold off


rise_time = sum(fliplr(extrema(times(rising))) .* [1, -1]);
dead_time = 10; % ns

additional_dead_time = dead_time - rise_time;
amplitude = detector.Histogram_Data;
waveform_mask = (times < (times(peak_loc) + additional_dead_time)) & (times > times(peak_loc));
amplitude(waveform_mask) = max(detector.Histogram_Data);

figure
hold on 
plot(times, amplitude);
xlabel('ns')
xlim(extrema(times(waveform_mask)) .* [0.95, 1.05])

% the plan... 
% find how long the rising edge is
% subtract this from an artificial dead time
% stretch the detector Histogram 
% now we can simulate ar detector dead times
