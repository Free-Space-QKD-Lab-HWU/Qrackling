%% time constants
clear all
%close all
clc

extrema = @(arr) [min(arr), max(arr)];

det_data_path = 'MPDHistogram.mat';
% det_data_path = 'ExcelitasHistogram.mat';
det_data = load(det_data_path);
counts = det_data.Counts;
bin_width = 10^-12;
index = linspace(1, numel(counts), numel(counts));
time_arr = index .* bin_width;

centre = time_arr(counts == max(counts));
max_cut_off = 0.9;
peak_points = extrema(time_arr(counts > max(counts)*max_cut_off));

min_cut_off = 0.1;
rise = index((counts > min_cut_off*max(counts)) & (time_arr < peak_points(1)));
fall = index((counts > min_cut_off*max(counts)) & (time_arr > peak_points(2)));

figure
hold on
plot(time_arr, counts)
plot(time_arr(rise), counts(rise))
plot(time_arr(fall), counts(fall))
N = 200;
xlim([time_arr(rise(1)-N), time_arr(fall(end)+N)])

rising_edge_counts = counts(rise);
rising_edge_times = time_arr(rise);

falling_edge_counts = counts(fall);
falling_edge_times = time_arr(fall);

time_difference = @(times) sum( fliplr( extrema(times) ) .* [1, -1] );
time_difference(time_arr(rise))
time_difference(time_arr(fall))

time_arr(fall(end)) - time_arr(rise(1))

time_difference(time_arr(counts >= 0.5 * max(counts)))
