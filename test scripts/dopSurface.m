%% run
close all
clear all
clc

data_path = '~/Documents/MATLAB/DOP_wide';
data_path = adduserpath(data_path)

contents = dir(data_path);
file_names = {contents.name};
spectral_files = {file_names{contains(file_names, 'rad.spc')}};


wvlstrings = cellfun(@(elems) elems{2}, ...
    cellfun(@(splitfile) strsplit(splitfile{1}, '_'), ...
        cellfun(@(sf) strsplit(sf, 'umu'), spectral_files, UniformOutput=false), ...
        UniformOutput=false), ...
    UniformOutput=false);

unique(cellfun(@(wvlstr) str2num(wvlstr), wvlstrings))
linspace(400, 2000, (2000 - 400) / 50)
linspace(20, 360, 18)


elems = strsplit(spectral_files{1}, 'umu')
wvl = strsplit(elems{1}, '_');

current_files = {spectral_files{contains(spectral_files, elems{1})}};
data = readtable([data_path, '/', current_files{1}], FileType='delimitedtext');
dopComp = data.Var5(1:4)

strsplit(current_files{1}, wvl)

raw_locs = ...
    cellfun(@(splits) strsplit(replace(splits{end}, '.rad.spc', ''), '__'), ...
        cellfun(@(fn) strsplit(fn , elems{1}), ...
            current_files, ...
            UniformOutput=false), ...
        UniformOutput=false);

umus = cell2mat( ...
    cellfun(@(splitloc) str2num(splitloc{2}), ...
        cellfun(@(loc) strsplit(loc{1}, '_'), raw_locs, UniformOutput=false), ...
    UniformOutput=false)');

phis = cell2mat( ...
    cellfun(@(splitloc) str2num(splitloc{2}), ...
        cellfun(@(loc) strsplit(loc{2}, '_'), raw_locs, UniformOutput=false), ...
    UniformOutput=false)');

u_umus = unique(umus);
umu_idxs = zeros(size(umus));
for idx = 1: numel(u_umus)
    umu_idxs(umus == u_umus(idx)) = idx;
end

u_phis = unique(phis);
phi_idxs = zeros(size(phis));
for idx = 1: numel(u_phis)
    phi_idxs(phis == u_phis(idx)) = idx;
end

% calcDOP = @(I,Q,U,V) sqrt((Q.^2) + (U.^2) + (V.^2)) ./ I;
calcDOP = @(arr) sqrt((arr(2).^2) + (arr(3).^2) + (arr(4).^2)) ./ arr(1);

dop_map = zeros(numel(u_phis), numel(u_umus));
for i = 1:numel(current_files)
    cur_f = current_files{i};
    data = readtable([data_path, '/', cur_f], FileType='delimitedtext');
    dop = calcDOP(data.Var5(1:4));
    dop_map(phi_idxs, umu_idxs) = dop;
end

%%

data_path = '~/Documents/MATLAB/DOP_wide/';
data_path = adduserpath(data_path)
directory_contents = dir(data_path);
file_names = {directory_contents.name};
mask = contains(file_names, '.rad.spc');
files = cellfun(@(fn) [data_path, fn], {file_names{mask}}, UniformOutput=false);

data = readtable(files{1}, FileType='delimitedtext');

wvl = data{1:4:end, 1};
I = table2array(data(1:4:end, end));
Q = table2array(data(2:4:end, end));
U = table2array(data(3:4:end, end));
V = table2array(data(4:4:end, end));

DOP = sqrt((Q.^2) + (U.^2) + (V.^2)) ./ I;

TakeNth = @(List, N) list{N};
Last = @(list) list{end};
First = @(list) list{1};
RemoveSubString = @(String, SubString) String(1:strfind(String, SubString)-1);
angles = strsplit(RemoveSubString(Last(strsplit(files{1}, '/wvl_2000')), '.rad.spc'), '__')
ze = str2num(Last(strsplit(angles{2}, '_')))
az = str2num(Last(strsplit(angles{3}, '_')))

angles = cellfun(@(fn) ...
    strsplit(RemoveSubString(Last(strsplit(fn, '/')), '.rad.spc'), '__'), ...
    files, UniformOutput=false);

zeniths = unique(cellfun(@(a) str2num(Last(strsplit(a{2}, '_'))), angles))
azimuths = unique(cellfun(@(a) str2num(Last(strsplit(Last(a), '_'))), angles))

file_names{end}

I_Mat = zeros(numel(zeniths), numel(azimuths), numel(wvl));
Q_Mat = zeros(numel(zeniths), numel(azimuths), numel(wvl));
U_Mat = zeros(numel(zeniths), numel(azimuths), numel(wvl));
V_Mat = zeros(numel(zeniths), numel(azimuths), numel(wvl));

for z = 1:numel(zeniths)
    Z = zeniths(z);
    for a = 1:numel(azimuths)
        A = azimuths(a);
        fName = ['wvl_2000__umu_', num2str(Z), '__phi_', num2str(A), '.rad.spc'];
        %valid_file_name = files{contains(file_names, fName)};
        valid_file_name = [data_path, fName];
        data = readtable(valid_file_name, FileType='delimitedtext');
        I = table2array(data(1:4:end, end));
        Q = table2array(data(2:4:end, end));
        U = table2array(data(3:4:end, end));
        V = table2array(data(4:4:end, end));
        I_Mat(z, a, :) = I;
        Q_Mat(z, a, :) = Q;
        U_Mat(z, a, :) = U;
        V_Mat(z, a, :) = V;
    end
    disp([num2str(z), '/', num2str(numel(zeniths))]);
end


calcDOP = @(I,Q,U,V) sqrt((Q.^2) + (U.^2) + (V.^2)) ./ I;
dopAtWvl = @(IM, QM, UM, VM, idx) ...
    calcDOP(I(:, :, idx), Q(:, :, idx), U(:, :, idx), V(:, :, idx));


dopAtWvl(I_Mat, Q_Mat, U_Mat, V_Mat, 1)

wvlIdx = 50
doptest = sqrt((Q_Mat(:, :, wvlIdx) .^ 2) + (U_Mat(:, :, wvlIdx) .^ 2) + (V_Mat(:, :, wvlIdx) .^ 2)) ./ I_Mat(:, :, wvlIdx);
figure
polarpcolor(azimuths, rad2deg(zeniths), fliplr(doptest')) %this?
%polarpcolor(azimuths, rad2deg(zeniths), (doptest')) % or this?
title(['DOP @ ', num2str(wvl(wvlIdx)), 'nm'])

size(doptest')
size(zeniths)
size(azimuths)

%%

[AA, ZZ] = meshgrid(azimuths, 90 + rad2deg(zeniths));
mask = AA == 180;
size(mask)

allDOP = zeros([numel(zeniths), numel(wvl)]);
size(allDOP)
pos = find(azimuths == 180)
for i = 1:numel(wvl)
    wvlIdx = i;
    doptest = sqrt( ...
            (Q_Mat(:, :, wvlIdx) .^ 2) ...
            + (U_Mat(:, :, wvlIdx) .^ 2) ...
            + (V_Mat(:, :, wvlIdx) .^ 2) ...
        ) ./ I_Mat(:, :, wvlIdx);
    allDOP(:, i) = doptest(:, pos);
end

[ZZ, WW] = meshgrid(wvl, 90 + rad2deg(zeniths));
figure
title('Degree-Of-Polarisation from 400nm \rightarrow 2000nm')
grid
s = surface(ZZ, WW, smoothdata(allDOP))
s.EdgeColor = 'none';
%shading interp
xlim([min(wvl), max(wvl)])
ylim([33, 90])
zlim([0, 0.75])
xlabel('Wavelength (nm)')
ylabel('Zenith (\circ)')
zlabel('Degree-Of-Polarisation (Linear)')
view([34, 24])

idx = find(wvl == 780);
figure
doptest = sqrt( ...
        (Q_Mat(:, :, idx) .^ 2) ...
        + (U_Mat(:, :, idx) .^ 2) ...
        + (V_Mat(:, :, idx) .^ 2) ...
    ) ./ I_Mat(:, :, idx);
polarpcolor(azimuths, rad2deg(zeniths), fliplr(doptest')) %this?
title(['Degree of Polarisation @', num2str(wvl(idx)), 'nm'])

snrPercentFromDop = @(DOP) (1 - DOP) ./ 2;
snrDbFromDop = @(DOP) 10 .* log10(2 ./ (1 - DOP));

[ZZ, WW] = meshgrid(wvl, 90 + rad2deg(zeniths));
figure
title('Polarisation SNR from 400nm \rightarrow 2000nm')
grid
s = surface(ZZ, WW, snrDbFromDop(smoothdata(allDOP)))
s.EdgeColor = 'none';
%shading interp
xlim([min(wvl), max(wvl)])
ylim([33, 90])
% zlim([0, 0.75])
xlabel('Wavelength (nm)')
ylabel('Zenith (\circ)')
zlabel('Degree-Of-Polarisation (Linear)')
view([34, 24])

%% Counts

countsPath = '~/Documents/MATLAB/Counts/umu_-0.999__phi_40.out';
counts = readtable(adduserpath(countsPath), FileType='delimitedtext');

wvls_counts = counts.Var1;

fields = fieldnames(counts);
variables = fields(contains(fields, 'Var') & ~contains(fields, 'Variables'));
n_vars = numel(variables)

output_layout = strsplit('lambda zout uu edir eglo edn eup enet esum', ' ');

whichOptions = @(options, choice) sum((1:numel(options)) .* contains(options, choice));
whichOptions(output_layout, 'uu')
getUuColumns = @(columns, options, choice_location) columns(choice_location : end - numel(options) + choice_location);
uu_cols = getUuColumns(variables, output_layout, whichOptions(output_layout, 'uu'));
assert(numel(uu_cols) == (numel(zeniths) * numel(azimuths)), 'nope')
getUuData = @(data, idx, options, choice_location) table2array(data(idx, choice_location : end - numel(options) + choice_location));

labels = {};
i = 1;
for z = 1:numel(zeniths)
    for a = 1:numel(azimuths)
        % labels{i} = strjoin({Z, A}, '_');
        labels{i} = [z, a];
        disp(labels{i});
        i = i + 1;
    end
end

allcounts = zeros(numel(azimuths), numel(zeniths), numel(wvl));
for i = 1:numel(wvls_counts)
    allcounts(:, :, i) = reshape( ...
        getUuData(counts, i, output_layout, whichOptions(output_layout, 'uu')), ...
        [numel(azimuths), numel(zeniths)]);
end

idx = find(wvls_counts == 780);
figure
polarpcolor(azimuths, rad2deg(zeniths), fliplr(allcounts(:, :, idx))) %this?
title(['Radiance @', num2str(wvls_counts(idx)), 'nm (W/m^2/sr/nm)'])

%% plot test
counts_no_az = zeros([numel(zeniths), numel(wvl)]);
pos = find(azimuths == 180)
%pos = numel(azimuths)
for i = 1:numel(wvls_counts)
    counts_no_az(:, i) = allcounts(pos, :, i);
end

[ZZ, WW] = meshgrid(wvl, 90 + rad2deg(zeniths));
figure
title('Solar Background from 400nm \rightarrow 2000nm')
grid
s = surface(ZZ, WW, counts_no_az)
s.EdgeColor = 'none';
%shading interp
xlim([min(wvl), max(wvl)])
ylim([33, 90])
% zlim([0, 0.75])
xlabel('Wavelength (nm)')
ylabel('Zenith (\circ)')
zlabel('Radiance (W/m^2/sr/nm)')
view([34, 24])

[ZZ, WW] = meshgrid(wvl, 90 + rad2deg(zeniths));
figure
title('Maximally Filtered Solar Background from 400nm \rightarrow 2000nm')
grid
s = surface(ZZ, WW, counts_no_az .* snrPercentFromDop(allDOP))
s.EdgeColor = 'none';
%shading interp
xlim([min(wvl), max(wvl)])
ylim([33, 90])
% zlim([0, 0.75])
xlabel('Wavelength (nm)')
ylabel('Zenith (\circ)')
zlabel('Radiance (W/m^2/sr/nm)')
view([34, 24])

%% full range

counts_no_az = zeros([numel(zeniths) * 2, numel(wvl)]);
size(zeniths)
size(counts_no_az)
pos = find(azimuths == 180)
pos1 = find(azimuths == 360)
for i = 1:numel(wvls_counts)
    counts_no_az(1:numel(zeniths), i) = fliplr(allcounts(pos1, :, i));
    counts_no_az(numel(zeniths)+1:end, i) = allcounts(pos, :, i);
end

allDOP = zeros([numel(zeniths) * 2, numel(wvl)]);
for i = 1:numel(wvl)
    wvlIdx = i;
    doptest = sqrt( ...
        (Q_Mat(:, :, wvlIdx) .^ 2) + ...
        (U_Mat(:, :, wvlIdx) .^ 2) + ...
        (V_Mat(:, :, wvlIdx) .^ 2)) ...
        ./ I_Mat(:, :, wvlIdx);
    allDOP(1:numel(zeniths), i) = fliplr(doptest(:, pos1));
    allDOP(numel(zeniths)+1:end, i) = doptest(:, pos);
end

zenAng = 90 + rad2deg(zeniths);
[ZZ, WW] = meshgrid(wvl, linspace(zenAng(1), zenAng(end)*2, numel(zenAng)*2));
figure
title('Solar Background from 400nm \rightarrow 2000nm')
grid
s = surface(ZZ, WW, counts_no_az)
s.EdgeColor = 'none';
%shading interp
xlim([min(wvl), max(wvl)])
ylim([zenAng(1), zenAng(end)*2])
% zlim([0, 0.75])
xlabel('Wavelength (nm)')
ylabel('Zenith (\circ)')
zlabel('Radiance (W/m^2/sr/nm)')
view([34, 24])

figure
title('Degree-Of-Polarisation from 400nm \rightarrow 2000nm')
grid
s = surface(ZZ, WW, allDOP)
s.EdgeColor = 'none';
%shading interp
xlim([min(wvl), max(wvl)])
ylim([zenAng(1), zenAng(end)*2])
zlim([0, 0.75])
xlabel('Wavelength (nm)')
ylabel('Zenith (\circ)')
zlabel('Degree-Of-Polarisation (Linear)')
view([34, 24])

figure
title('Maximally Filtered Solar Background from 400nm \rightarrow 2000nm')
grid
s = surface(ZZ, WW, counts_no_az .* snrPercentFromDop(allDOP))
s.EdgeColor = 'none';
%shading interp
xlim([min(wvl), max(wvl)])
ylim([zenAng(1), zenAng(end)*2])
% zlim([0, 0.75])
xlabel('Wavelength (nm)')
ylabel('Zenith (\circ)')
zlabel('Radiance (W/m^2/sr/nm)')
view([34, 24])
