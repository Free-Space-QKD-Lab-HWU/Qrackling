%% run test
close all;
clear all
clc;

% File Locations, replace these as you want
f1 = '~/Downloads/FB400-40.xlsx';
f2 = '~/Downloads/FB390-10.xlsx';
f3 = '~/Downloads/FELH0400_Transmission.xlsx';
f4 = '~/Downloads/FES0450.xlsx';

% Lets load each of the file paths so we can plot the data separately and verify
t1 = readtable(f1, VariableNamingRule='preserve');
t2 = readtable(f2, VariableNamingRule='preserve');
t3 = readtable(f3, VariableNamingRule='preserve');
t4 = readtable(f4, VariableNamingRule='preserve');

% Create a filter composed of 'f1' and 'f2'
sf = SpectralFilter(data={f1, f2});

% For convenience lets get the wavelengths and transmission percentage for each
% of the data files for separate plotting. 
% Example usage: SpectralFilter.get_column_from_name(table, name) -> will find 
% and return the column with from the input table with the closest matching 
% name. Should your table have similar names you will likely have to give this 
% some help to make sure it gets the correct names (e.g. it contains a column 
% for both percentage and dB for transmission information)
wl1 = sf.get_column_from_name(t1, 'wavelength');
wl2 = sf.get_column_from_name(t2, 'wavelength');
wl3 = sf.get_column_from_name(t3, 'wavelength');
wl4 = sf.get_column_from_name(t4, 'wavelength');
tr1 = sf.get_column_from_name(t1, 'transmission') / 100;
tr2 = sf.get_column_from_name(t2, 'transmission') / 100;
tr3 = sf.get_column_from_name(t3, 'transmission') / 100;
tr4 = sf.get_column_from_name(t4, 'transmission') / 100;

% Plot the resulting transmission spectra from a pair of filters
figure
grid on
hold on
plot(wl1, tr1);
plot(wl2, tr2);
plot(sf.wavelengths, sf.transmission)
xlim([350, 550])
lgd = legend(...
            'FB400-40', ...
            'FB390-10', ...
            '(FB400-40) \times (FB390-10)' ...
            );
lgd.Location = 'Best';
hold off

% Create a spectral filter from a single file and then add a second filter
sf = SpectralFilter(data=f1);
sf = sf.add_filter(f3);
figure
grid on
hold on
plot(wl1, tr1);
plot(wl3, tr3);
plot(sf.wavelengths, sf.transmission)
xlim([350, 550])
lgd = legend(...
            'FB400-40', ...
            'FELH0400', ...
            '(FB400-40) \times (FELH0400)' ...
            );
lgd.Location = 'Best';
hold off

% Create a spectral filter from a pair of files containing filter information 
% and then add a third filter after creation
sf = SpectralFilter(data={f1,f3});
sf = sf.add_filter(f4);
figure
grid on
hold on
plot(wl1, tr1);
plot(wl3, tr3);
plot(wl4, tr4);
plot(sf.wavelengths, sf.transmission)
xlim([350, 550])
lgd = legend(...
            'FB400-40', ...
            'FELH0400', ...
            'FES0450', ...
            ['(FB400-40)', newline, '\times (FELH0400)', newline, '\times (FES0450)'] ...
            );
lgd.Location = 'Best';
hold off
