%% run
clear all
close all
clc

ContentsOfDirectory = @(DirPath) {dir(adduserpath(DirPath)).name};

FilterFiles = @(DirectoryContents, Query) ...
    {DirectoryContents{cellfun( ...
        @(fp) contains(fp, Query), ...
        DirectoryContents)} ...
    };

in_target_path = '~/Documents/tqi_data/inputs/';

in_radianceFiles = FilterFiles( ...
    ContentsOfDirectory(in_target_path), ...
    '__radiance');

disp(in_radianceFiles')

in_file = strjoin({in_target_path, in_radianceFiles{3}}, '')

rf = radiance_file(in_file)

rf_jan_0900 = radiance_file(strjoin({in_target_path, in_radianceFiles{3}}, ''));
rf_aug_1500 = radiance_file(strjoin({in_target_path, in_radianceFiles{4}}, ''));

figure
wvl = 780;
[ff, c] = polarpcolor( ...
    rf.azimuths, ...
    rad2deg(rf.elevations), ...
    (fliplr(rf.pickRadianceForWavelength(wvl))) ...
);
%title(['Radiance at ', num2str(wvl), 'nm']);
c.Label.String = '$mW/sr/m^2$'
c.Label.Interpreter = 'latex';
c.TickLabelInterpreter = 'latex';
exportgraphics(gcf, adduserpath(['~/Documents/tqi_review_march_2023/src/figures/radiance_aug_1500_', num2str(wvl), '.pdf']),'ContentType','vector')

extrema = @(arraylike) [min(arraylike(:)), max(arraylike(:))];
extrema(radiance)

%%

wvl = 780e-9;
Dr = 1;
m = linspace(0, 2, 100);
f = 2.44 .* m .* wvl ./ Dr;
figure
plot(m, f)

pi .* (1.22 .* wvl ./ Dr) .^2
f(1)

%%
planck = 6.626e-34;
c = 299792458;

f = 8410e-3;
Dr = 0.7;

% field stop diameter at the diffraction limit for a given wavelength
fieldStopDiameter = @(FocalLength, RxDiameter, Wavelength) ...
    2.44 .* FocalLength .* Wavelength ./ RxDiameter;
fieldStopDiameter(f, Dr, 780e-9)

solidAngleFOV = @(FocalLength, FSDiameter) pi ./ 4 .* ((FSDiameter ./ FocalLength).^2);
solidAngleFOV(f, fieldStopDiameter(f, Dr, 780e-9))

% since we have the radiance for a given wavelength already I'm not 100% sure 
% that we need to include the wavelength in this function i.e. radiance = mW/sr/m^2
% output settings in libRadTran config also doesn't specify per nm so I don't think
% needed, also now not so sure about the spectral filter either....
nSkyPhotons = @(Radiance, FOV, RxDiameter, Wavelength, Band, ExpTime) ...
    (Radiance .* FOV .* pi .* (RxDiameter.^2) .* Band .* ExpTime) ...
    ./ (planck * c);

wvl = 1550;
ns = nSkyPhotons( ...
    rf.pickRadianceForWavelength(wvl) .* (1e-3), ...
    solidAngleFOV(f, fieldStopDiameter(f, Dr, wvl * 1e-9)), ...
    Dr, wvl, 1, 1e-9);

figure
[ff, cb] = polarpcolor( ...
    rf.azimuths, ...
    rad2deg(rf.elevations), ...
    (fliplr(ns)) ...
);
%title(['Radiance at ', num2str(wvl), 'nm']);
cb.Label.String = 'Counts'
cb.Label.Interpreter = 'latex';
cb.TickLabelInterpreter = 'latex';
%exportgraphics(gcf, adduserpath(['~/Documents/tqi_review_march_2023/src/figures/counts_aug_1500_', num2str(wvl), '.pdf']),'ContentType','vector')

fovs = linspace( ...
    solidAngleFOV(f, fieldStopDiameter(f, Dr, wvl * 1e-9)), ...
    100e-12, ...
    10);

elevs = 90 - pass_result.Elevations(pass_result.Communicating_Flags);
azims = pass_result.Headings(pass_result.Communicating_Flags);
numel(elevs) == numel(azims)
disp(numel(elevs))
wvl = 780;
sky_counts_jan = zeros(1, numel(elevs));
sky_counts_aug = zeros(1, numel(elevs));
raw_jan = fliplr(rf_jan_0900.pickRadianceForWavelength(wvl));
raw_aug = fliplr(rf_aug_1500.pickRadianceForWavelength(wvl));
for i = 1:numel(azims)
    [val, azim_idx] = min(abs(rf.azimuths - azims(i)));
    [val, elev_idx] = min(abs(rad2deg(rf.elevations) - elevs(i)));
    sky_counts_jan(i) = raw_jan(azim_idx, elev_idx);
    sky_counts_aug(i) = raw_aug(azim_idx, elev_idx);
end
sky_counts_jan = fliplr(sky_counts_jan);
sky_counts_aug = fliplr(sky_counts_aug);


first_diameter = fieldStopDiameter(f, Dr, wvl * 1e-9)
fstops = linspace(first_diameter, first_diameter*10, 50);
fovs = solidAngleFOV(f, fstops)
counts_for_pass_jan = zeros(1, numel(fovs));
counts_for_pass_aug = zeros(1, numel(fovs));
for i = 1:numel(fovs)
    counts_for_pass_jan(i) = ...
        sum(nSkyPhotons(sky_counts_jan .* (1e-3), fovs(i), Dr, wvl, 1, 1));
    counts_for_pass_aug(i) = ...
        sum(nSkyPhotons(sky_counts_aug .* (1e-3), fovs(i), Dr, wvl, 1, 1));
end

figure
hold on
semilogy(fstops.*(1e6), counts_for_pass_jan)
semilogy(fstops.*(1e6), counts_for_pass_aug)
legend({'January', 'August'}, Location='southeast')
xlabel('Field Stop Diameter, $\mu$m')
ylabel('Counts')
set(gca, 'Yscale', 'log')
%set(gca, 'DataAspectRatio', [1, 2])
exportgraphics(gcf, adduserpath(['~/Documents/tqi_review_march_2023/src/figures/total_sky_counts_', num2str(wvl), '.pdf']),'ContentType','vector')


%% 

radiance ./ 1000

%%
% close all
% figure
% wvl = 1550;
% ff = polarpcolor( ...
%     rf.azimuths, ...
%     rad2deg(rf.elevations), ...
%     log10(rf.pickRadianceForWavelength(wvl)) ...
% );
% title(['Radiance at ', num2str(wvl), 'nm']);
% 
% figure
% wvl = 780;
% ff = polarpcolor( ...
%     rf.azimuths, ...
%     rad2deg(rf.elevations), ...
%     log10(rf.pickRadianceForWavelength(wvl)) ...
% );
% title(['Radiance at ', num2str(wvl), 'nm']);
% 
% figure
% wvl = 780;
% ff = polarpcolor( ...
%     rf.azimuths, ...
%     rad2deg(rf.elevations), ...
%     log10(fliplr(rf.pickRadianceForWavelength(wvl))) ...
% );
% title(['Radiance at ', num2str(wvl), 'nm']);

%% 
% close all
% clear all

list_factory = fieldnames(get(groot,'factory'));
index_interpreter = find(contains(list_factory,'Interpreter'));
for i = 1:length(index_interpreter)
    default_name = strrep(list_factory{index_interpreter(i)},'factory','default');
    set(groot, default_name,'latex');
end

orbit_data_root = adduserpath([ ...
    '~/Projects/QKD_Sat_Link/libRadTran/', ...
    'orbit modelling resources/orbit LLAT files/']);
OrbitDataFileLocation = '500kmSSOrbitLLAT.txt';

wavelength = 780;

transmitter_telescope_diameter = 0.1;
receiver_telescope_diameter = 1;

time_gate_width = 1E-9;
Spectral_filter_width = 1;

transmitter_source = decoyBB84_Source(wavelength);
bb84_protocol = Protocol(qkd_protocol.DecoyBB84);
mpd_bb84_detector = MPD_Detector( ...
    wavelength, ...
    transmitter_source.Repetition_Rate, ...
    time_gate_width, ...
    Spectral_filter_width);
%mpd_bb84_detector = mpd_bb84_detector.SetDetectionEfficiency(1);
% %%wavelength = 1550;
%mpd_bb84_detector = mpd_bb84_detector.SetWavelength(wavelength);

transmitter_telescope = Telescope(transmitter_telescope_diameter);
%transmitter_telescope.Optical_Efficiency = 1;
sim_satellite = Satellite( ...
    transmitter_telescope, ...
    Source = transmitter_source, ...
    OrbitDataFileLocation = OrbitDataFileLocation);

receiver_telescope = Telescope(receiver_telescope_diameter);
receiver_telescope = receiver_telescope.SetWavelength(wavelength);
%receiver_telescope.Optical_Efficiency = 1;
sim_ground_station = Errol_OGS( ...
    receiver_telescope, ...
    Detector = mpd_bb84_detector);

pass_sim = PassSimulation( ...
    sim_satellite, ...
    Protocol(qkd_protocol.DecoyBB84), ...
    sim_ground_station);

pass_result = Simulate(pass_sim);
plot(pass_result);
% exportgraphics(gcf, ...
%     adduserpath('~/Documents/tqi_review_march_2023/src/figures/nominal_pass.pdf'), ...
%     ContentType = 'vector')

%%


%%

transmitter_source = decoyBB84_Source(wavelength);
bb84_protocol = Protocol(qkd_protocol.DecoyBB84);
this_det = MPD_Detector( ...
    wavelength, ...
    transmitter_source.Repetition_Rate, ...
    time_gate_width, ...
    Spectral_filter_width);
this_det = MPD_Detector( ...
    wavelength, ...
    1e6, ...
    time_gate_width, ...
    Spectral_filter_width);
disp(this_det.CalculateJitter());
new_det = this_det.StretchToNewJitter(60e-12);
disp(new_det.CalculateJitter());

jitters = (10 .^ linspace(0, 3.5, 20)) .* (1e-12);
qber_jitter = zeros(size(jitters));
jitter_loss = zeros(size(jitters));
for i = 1:numel(jitters);
    d = this_det.StretchToNewJitter(jitters(i));
    disp([i, d.CalculateJitter() * (1e12)]);
    qber_jitter(i) = d.QBER_Jitter;
    jitter_loss(i) = d.Jitter_Loss;
end

figure
hold on
yyaxis left
plot(jitters .* (1e12), jitter_loss)
ylabel('Temporal Efficiency');
ylim([0, 1.01])
yyaxis right
plot(jitters .* (1e12), qber_jitter)
ylabel('Jitter Contribution to QBER');
ylim([-0.01, 0.52])
xlabel('Jitter (ps)')
xlim([min(jitters), max(jitters)] .* (1e12))
set(gca, 'Xscale', 'log')
hold off

% make a heat map of clock rate vs jitter for qber_jitter and jitter_loss
% can lose counts without increasing qber -> i.e. just being inefficient...

clocks = (10 .^ linspace(0, 4, 49)) .* (1e6);
jitters = (10 .^ linspace(0, 3.5, 51)) .* (1e-12);
qber_jitter = zeros(numel(clocks), numel(jitters));
jitter_loss = zeros(numel(clocks), numel(jitters));
for i = 1:numel(clocks)
    c = clocks(i);
    this_det.Repetition_Rate = c;
    for j = 1:numel(jitters);
        disp([i, j]);
        d = this_det.StretchToNewJitter(jitters(j));
        qber_jitter(i, j) = d.QBER_Jitter;
        jitter_loss(i, j) = d.Jitter_Loss;
    end
end

[XX, YY] = meshgrid(jitters .* (1e12), clocks .* (1e-6));

figure
hold on
p = pcolor(XX, YY, qber_jitter)
p.EdgeColor = 'none'
shading interp
set(gca, 'Xscale', 'log')
set(gca, 'Yscale', 'log')
grid off

hold off
figure
hold on
pcolor(XX, YY, jitter_loss)
shading interp
set(gca, 'Xscale', 'log')
set(gca, 'Yscale', 'log')
grid off

result = struct()
result.clocks = clocks;
result.jitters = jitters;
result.jitter_loss = jitter_loss;
result.qber_jitter = qber_jitter;
save(adduserpath('~/Documents/tqi_data/clock_vs_jitter.mat'), 'result')
res_load = load(adduserpath('~/Documents/tqi_data/clock_vs_jitter.mat'))

%%
clear all
close all

list_factory = fieldnames(get(groot,'factory'));
index_interpreter = find(contains(list_factory,'Interpreter'));
for i = 1:length(index_interpreter)
    default_name = strrep(list_factory{index_interpreter(i)},'factory','default');
    set(groot, default_name,'latex');
end

results = load(adduserpath('~/Documents/tqi_data/clock_vs_jitter.mat')).result;
jitters = results.jitters .* (1e12);
clocks = results.clocks .* (1e-6);
[XX, YY] = meshgrid(jitters, clocks);

figure
hold on
p = pcolor(XX, YY, results.qber_jitter);
p.EdgeColor = 'none'
xlabel('Detector Jitter')
ylabel('System Clock Rate')
%title('Jitter and Clock Effects on QBER')
shading interp
set(gca, 'Xscale', 'log')
set(gca, 'Yscale', 'log')
xlim([0.71, max(jitters)])
ylim([0.70, max(clocks)])
c = colorbar(location = 'NorthOutside');
caxis([quantile(results.qber_jitter(:), 0.01), ...
    quantile(results.qber_jitter(:), 0.99)])
c.Title.String = 'QBER';
c.Title.Interpreter = 'latex';
ax = gca
a = gca;
x_tick_label_positions = a.XTick;
x_tick_labels = strsplit('$1ps$ $10ps$ $100ps$ $1ns$ $10ns$')';
a.XTickLabels = x_tick_labels;
y_tick_label_positions = a.YTick
y_tick_labels = strsplit('$1MHz$ $10MHz$ $100MHz$ $1GHz$ $10GHz$')';
a.YTickLabels = y_tick_labels;
ytickangle(45)
exportgraphics(gcf, ...
    adduserpath('~/Documents/tqi_review_march_2023/src/figures/jitter_qber.pdf'), ...
    ContentType = 'vector')

figure
hold on
p = pcolor(XX, YY, results.jitter_loss);
p.EdgeColor = 'none'
xlabel('Detector Jitter')
ylabel('System Clock Rate')
%title('Jitter and Clock Effects on QBER')
shading interp
set(gca, 'Xscale', 'log')
set(gca, 'Yscale', 'log')
xlim([0.71, max(jitters)])
ylim([0.70, max(clocks)])
c = colorbar(location = 'NorthOutside');
caxis([quantile(results.jitter_loss(:), 0.01), ...
    quantile(results.jitter_loss(:), 0.99)])
c.Title.String = 'Efficiency';
c.Title.Interpreter = 'latex';
ax = gca
a = gca;
x_tick_label_positions = a.XTick;
x_tick_labels = strsplit('$1ps$ $10ps$ $100ps$ $1ns$ $10ns$')';
a.XTickLabels = x_tick_labels;
y_tick_label_positions = a.YTick
y_tick_labels = strsplit('$1MHz$ $10MHz$ $100MHz$ $1GHz$ $10GHz$')';
a.YTickLabels = y_tick_labels;
ytickangle(45)
exportgraphics(gcf, ...
    adduserpath('~/Documents/tqi_review_march_2023/src/figures/jitter_loss.pdf'), ...
    ContentType = 'vector')

% figure
% ax = axes;
% hold on
% p = pcolor(XX, YY, results.qber_jitter)
% offsetFigAxis(ax);


%%

h = this_det.CDF;
t = linspace(0, numel(h), numel(h)) .* this_det.Histogram_Bin_Width;
nfft = 2^nextpow2(numel(h));
ff = fft(h, nfft);

figure
plot(t,ff)

res = ifft(ff .* conj(ff));
sum(h)
sum(res)
sum(xcorr(h))

figure
plot(res)

figure
plot(xcorr(h))

jl = load(adduserpath('~/Documents/tqi_data/jitter_loss.mat'))
qj = load(adduserpath('~/Documents/tqi_data/qber_jitter.mat'))

%%

figure
mpd_bb84_detector.PlotDetectorHistogram()

N = numel(mpd_bb84_detector.Histogram_Data);
index = linspace(1, N, N);
times = (index - N) ./ 2 * mpd_bb84_detector.Histogram_Bin_Width;

bins = unique(mpd_bb84_detector.Histogram_Data);
n_bins = numel(bins);
counts = zeros(1, n_bins);
for i = 1:n_bins
    counts(i) = sum(mpd_bb84_detector.Histogram_Data == bins(i));
end

Take = @(arraylike, N) arraylike(N);
cut_on = Take(bins(log10(counts) < 1), 1);
mask = mpd_bb84_detector.Histogram_Data > cut_on;

[max_val, max_idx] = max(mpd_bb84_detector.Histogram_Data);
[i_val, i_idx] = max(index(mask))

max_mask = mpd_bb84_detector.Histogram_Data >= (max_val / 2);
figure
plot(times(max_mask), mpd_bb84_detector.Histogram_Data(max_mask))
xlim(times([max_idx-i_idx, max_idx+i_idx]))
times_for_max = times(max_mask);
disp([times_for_max(end), times_for_max(1)])
(abs(times_for_max(1)) - abs(times_for_max(end))) * (1e12)

FirstLast = @(array) abs([array(1), array(end)]);
Difference = @(Pair) max(Pair) - min(Pair);

new_width = ...
    ((60e-12) / Difference(FirstLast(times_for_max))) ...
    * mpd_bb84_detector.Histogram_Bin_Width
mpd_bb84_detector.Histogram_Bin_Width

new_det = mpd_bb84_detector.SetHistogramBinWidth(new_width);
new_det.Histogram_Bin_Width

N = numel(new_det.Histogram_Data);
index = linspace(1, N, N);
times = (index - N) ./ 2 * new_det.Histogram_Bin_Width;

bins = unique(new_det.Histogram_Data);
n_bins = numel(bins);
counts = zeros(1, n_bins);
for i = 1:n_bins
    counts(i) = sum(new_det.Histogram_Data == bins(i));
end

Take = @(arraylike, N) arraylike(N);
cut_on = Take(bins(log10(counts) < 1), 1);
mask = new_det.Histogram_Data > cut_on;

[max_val, max_idx] = max(new_det.Histogram_Data);
[i_val, i_idx] = max(index(mask))

max_mask = new_det.Histogram_Data >= (max_val / 2);
figure
plot(times(max_mask), new_det.Histogram_Data(max_mask))
xlim(times([max_idx-i_idx, max_idx+i_idx]))
times_for_max = times(max_mask);
disp([times_for_max(end), times_for_max(1)])
(abs(times_for_max(1)) - abs(times_for_max(end))) * (1e12)

%%

figure
pax = polaraxes('ThetaZeroLocation','top');
polarplot( ...
    deg2rad(pass_result.Headings(pass_result.Communicating_Flags)), ...
    90 - pass_result.Elevations(pass_result.Communicating_Flags) ...
    )
pax.ThetaZeroLocation = 'top';

%%
close all
clear all

wavelength = 780;
time_gate_width = 1E-9;
Spectral_filter_width = 10;

bb84_detector = MPD_Detector( ...
    wavelength, ...
    1e8, ...
    time_gate_width, ...
    Spectral_filter_width);

figure
hold on
bb84_detector.PlotDetectorHistogram()
hold off

%%
figure
hold on
N = numel(bb84_detector.Histogram_Data);
times = (linspace(0, N, N) - (N/2)) .* bb84_detector.Histogram_Bin_Width;
plot(times, bb84_detector.StretchDetectorHistogram(150e-9))
hold off

% next steps...
% Detector with tuneable dead time and jitter
%   - there should already be code for this
% then plot the parameter space...

% set deadtime through Detector.SetDeadTime
% set rep rate through Source.SetRepetitionRate

%% 
%bb84_detector = MPD_Detector( ...
bb84_detector = Excelitas_Detector( ...
    wavelength, ...
    1, ...
    time_gate_width, ...
    Spectral_filter_width);

bb84_detector.Jitter_Loss

reprates = 10 .^ linspace(0, 15, 20);
results = zeros(size(reprates));
for i = 1:numel(reprates)
    disp(reprates(i))
    results(i) = bb84_detector.Jitter_Loss;
    bb84_detector = bb84_detector.SetJitterPerformance(reprates(i));
    disp([bb84_detector.QBER_Jitter, bb84_detector.Jitter_Loss])
end
disp(results)

figure
plot(reprates, results)

%%

figure
wvl = 780;
ff = polarpcolor( ...
    rf.azimuths, ...
    rad2deg(rf.elevations), ...
    (fliplr(rf.pickRadianceForWavelength(wvl))) ...
);
title(['Radiance at ', num2str(wvl), 'nm']);

figure
pax = polaraxes('ThetaZeroLocation','top');
polarplot( ...
    deg2rad(pass_result.Headings(pass_result.Communicating_Flags)), ...
    90 - pass_result.Elevations(pass_result.Communicating_Flags) ...
    )
pax.ThetaZeroLocation = 'top';

elevs = 90 - pass_result.Elevations(pass_result.Communicating_Flags);
azims = pass_result.Headings(pass_result.Communicating_Flags);
numel(elevs) == numel(azims)
disp(numel(elevs))
sky_counts = zeros(1, numel(elevs));
raw = fliplr(rf.pickRadianceForWavelength(wvl));
for i = 1:numel(azims)
    [val, azim_idx] = min(abs(rf.azimuths - azims(i)));
    [val, elev_idx] = min(abs(rad2deg(rf.elevations) - elevs(i)));
    sky_counts(i) = raw(azim_idx, elev_idx);
end
sky_counts = fliplr(sky_counts);

figure
plot(sky_counts)

planck = 6.626e-34;
c = 299792458;
numPhotonsFromPowerMilliWatt = @(power, wvl) (power .* 1e-3) ./ ((planck * c) / wvl)

figure
plot( ...
    pass_result.Times(pass_result.Communicating_Flags), ...
    numPhotonsFromPowerMilliWatt(sky_counts, wvl) ...
    )

fov = 2 * pi * (1 - cos(receiver_telescope.FOV / 2));
n_phot = ...
    ((sky_counts ./wvl) .* (1e-3)) ...
    .* (receiver_telescope.FOV ...
    * pi ...
    * (receiver_telescope.Diameter^2) ...
    * wvl ...
    * 1e-2 ...
    * 1);
n_phot = n_phot ./ (4 * planck * c);
figure
plot( ...
    pass_result.Times(pass_result.Communicating_Flags), ...
    n_phot ...
    )

dl_fov = pi * (1.22 * (wvl * 1e-9) / receiver_telescope.Diameter) ^ 2
n_phot = ...
    ((sky_counts ./ wvl) .* (1e-3)) ...
    .* ( ...
    (1.22 * pi)^2 ...
    * (wvl^3) ...
    * 1e-3 ...
    * 1 ...
    );
n_phot = n_phot ./ (4 * planck * c);
figure
plot( ...
    pass_result.Times(pass_result.Communicating_Flags), ...
    n_phot ...
    )
