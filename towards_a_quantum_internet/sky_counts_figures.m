%% run
close all
clear all

%% Ensure that latex mode is properly enabled
list_factory = fieldnames(get(groot,'factory'));
index_interpreter = find(contains(list_factory,'Interpreter'));
for i = 1:length(index_interpreter)
    default_name = strrep(list_factory{index_interpreter(i)},'factory','default');
    set(groot, default_name,'latex');
end

%% Get data
ContentsOfDirectory = @(DirPath) {dir(adduserpath(DirPath)).name};

FilterFiles = @(DirectoryContents, Query) ...
    {DirectoryContents{cellfun( ...
        @(fp) contains(fp, Query), ...
        DirectoryContents)} ...
    };

in_target_path = '~/Documents/tqi_data/matfiles/';

in_radianceFiles = FilterFiles( ...
    ContentsOfDirectory(in_target_path), ...
    '__radiance');


disp(in_radianceFiles')
jan_rf = radiance_file([in_target_path, in_radianceFiles{4}]);
aug_rf = radiance_file([in_target_path, in_radianceFiles{3}]);

%% Lambdas

planck = 6.626e-34;
c = 299792458;

f = 8410e-3;
Dr = 0.7;

% field stop diameter at the diffraction limit for a given wavelength
fieldStopDiameter = @(FocalLength, RxDiameter, Wavelength) ...
    2.44 .* FocalLength .* Wavelength ./ RxDiameter;
fieldStopDiameter(f, Dr, 780e-9)

solidAngleFOV = @(FocalLength, FSDiameter) pi ./ 4 .* ((FSDiameter ./ FocalLength).^2);
solidAngleFOV(f, fieldStopDiameter(f, Dr, 850e-9))

% since we have the radiance for a given wavelength already I'm not 100% sure 
% that we need to include the wavelength in this function i.e. radiance = mW/sr/m^2
% output settings in libRadTran config also doesn't specify per nm so I don't think
% needed, also now not so sure about the spectral filter either....
nSkyPhotons = @(Radiance, FOV, RxDiameter, Wavelength, Band, ExpTime) ...
    (Radiance .* FOV .* pi .* (RxDiameter.^2) .* Band .* ExpTime) ...
    ./ (planck * c);


%% January Counts

wvl = 850;
ns = nSkyPhotons( ...
    jan_rf.pickRadianceForWavelength(wvl) .* (1e-3), ...
    solidAngleFOV(f, fieldStopDiameter(f, Dr, wvl * 1e-9)), ...
    Dr, wvl, 1, 1);

figure
[ff, cb] = polarpcolor( ...
    jan_rf.azimuths, ...
    rad2deg(jan_rf.elevations), ...
    (fliplr(ns)) ...
);
%title(['Radiance at ', num2str(wvl), 'nm']);
cb.Label.String = 'Counts'
cb.Label.Interpreter = 'latex';
cb.TickLabelInterpreter = 'latex';
%exportgraphics(gcf, adduserpath(['~/Documents/tqi_review_march_2023/src/figures/counts_jan_0900_', num2str(wvl), '.pdf']),'ContentType','vector')

wvl = 1550;
ns = nSkyPhotons( ...
    jan_rf.pickRadianceForWavelength(wvl) .* (1e-3), ...
    solidAngleFOV(f, fieldStopDiameter(f, Dr, wvl * 1e-9)), ...
    Dr, wvl, 1, 1e-9);

figure
[ff, cb] = polarpcolor( ...
    jan_rf.azimuths, ...
    rad2deg(jan_rf.elevations), ...
    (fliplr(ns)) ...
);
%title(['Radiance at ', num2str(wvl), 'nm']);
cb.Label.String = 'Counts'
cb.Label.Interpreter = 'latex';
cb.TickLabelInterpreter = 'latex';
%exportgraphics(gcf, adduserpath(['~/Documents/tqi_review_march_2023/src/figures/counts_jan_0900_', num2str(wvl), '.pdf']),'ContentType','vector')

%% August Counts

wvl = 850;
ns = nSkyPhotons( ...
    aug_rf.pickRadianceForWavelength(wvl) .* (1e-3), ...
    solidAngleFOV(f, fieldStopDiameter(f, Dr, wvl * 1e-9)), ...
    Dr, wvl, 1, 1e-9);

figure
[ff, cb] = polarpcolor( ...
    aug_rf.azimuths, ...
    rad2deg(aug_rf.elevations), ...
    (fliplr(ns)) ...
);
%title(['Radiance at ', num2str(wvl), 'nm']);
cb.Label.String = 'Counts'
cb.Label.Interpreter = 'latex';
cb.TickLabelInterpreter = 'latex';
%exportgraphics(gcf, adduserpath(['~/Documents/tqi_review_march_2023/src/figures/counts_aug_1500_', num2str(wvl), '.pdf']),'ContentType','vector')

wvl = 1550;
ns = nSkyPhotons( ...
    aug_rf.pickRadianceForWavelength(wvl) .* (1e-3), ...
    solidAngleFOV(f, fieldStopDiameter(f, Dr, wvl * 1e-9)), ...
    Dr, wvl, 1, 1e-9);

figure
[ff, cb] = polarpcolor( ...
    aug_rf.azimuths, ...
    rad2deg(aug_rf.elevations), ...
    (fliplr(ns)) ...
);
%title(['Radiance at ', num2str(wvl), 'nm']);
cb.Label.String = 'Counts'
cb.Label.Interpreter = 'latex';
cb.TickLabelInterpreter = 'latex';
%exportgraphics(gcf, adduserpath(['~/Documents/tqi_review_march_2023/src/figures/counts_aug_1500_', num2str(wvl), '.pdf']),'ContentType','vector')

%% Satellite Sim config

orbit_data_root = adduserpath([ ...
    '~/Projects/QKD_Sat_Link/libRadTran/', ...
    'orbit modelling resources/orbit LLAT files/']);
OrbitDataFileLocation = '500kmSSOrbitLLAT.txt';

wavelength = 780;
wvl = wavelength

transmitter_telescope_diameter = 0.1;
receiver_telescope_diameter = 1;

time_gate_width = 1E-9;
Spectral_filter_width = 1;

transmitter_source = decoyBB84_Source(wavelength);
%bb84_protocol = decoyBB84_Protocol;
dbb84_protocol = protocol(qkd_protocols.DecoyBB84);
mpd_bb84_detector = MPD_Detector( ...
    wavelength, ...
    transmitter_source.Repetition_Rate, ...
    time_gate_width, ...
    Spectral_filter_width);
mpd_bb84_detector = mpd_bb84_detector.SetDetectionEfficiency(0.1);
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

% pass_sim = PassSimulation( ...
%     sim_satellite, ...
%     decoyBB84_Protocol, ...
%     sim_ground_station);
% pass_result = Simulate(pass_sim, []);

pass_sim = PassSimulation( ...
    sim_satellite, ...
    dbb84_protocol, ...
    sim_ground_station);
pass_result = Simulate(pass_sim, []);
plot(pass_result)

f = 8410e-3;
Dr = 0.7;
fovs = linspace( ...
    solidAngleFOV(f, fieldStopDiameter(f, Dr, wvl * 1e-9)), ...
    100e-12, ...
    10)
cm = count_map(jan_rf)
cm = cm.nSkyPhotons(wvl, fovs(1), Dr, 0.1, 1e-9)
counts = cm.countsForPass( ...
    pass_result.Elevations(pass_result.Communicating_Flags), ...
    pass_result.Headings(pass_result.Communicating_Flags), ...
    30);
%figure
%plot(fliplr(counts))
%figure
%[ff, cb] = polarpcolor( ...
%    aug_rf.azimuths, ...
%    rad2deg(aug_rf.elevations), ...
%    (fliplr(cm.counts)) ...
%);
pass_result = pass_sim.SimulateDownlink(cm)
plot(pass_result)

%% build data

sum(pass_result.Background_Count_Rates(pass_result.Communicating_Flags))
total_bcr = zeros(size(fovs));
total_key = zeros(size(fovs));
min_qber = zeros(size(fovs));
max_qber = zeros(size(fovs));
mean_qber = zeros(size(fovs));

cm = count_map(jan_rf);
f = 8410e-3;
Dr = 0.7;

fovs = linspace( ...
    solidAngleFOV(f, fieldStopDiameter(f, Dr, wvl * 1e-9)), ...
    100e-12, ...
    100);
pass_sim = PassSimulation( ...
    sim_satellite, ...
    decoyBB84_Protocol, ...
    sim_ground_station);
pass_result_base = Simulate(pass_sim, []);
for i = 1:numel(fovs)
    cm = count_map(jan_rf);
    cm = cm.nSkyPhotons(wvl, fovs(i), Dr, 0.1, 1e-9);
    counts = cm.countsForPass( ...
        pass_result_base.Elevations(pass_result_base.Elevation_Limit_Flags), ...
        pass_result_base.Headings(pass_result_base.Elevation_Limit_Flags), ...
        30);
    pass_result = pass_sim.SimulateDownlink(cm);
    %total_bcr(i) = sum( ...
    %    pass_result.Background_Count_Rates(pass_result.Elevation_Limit_Flags));
    total_bcr(i) = sum(counts);
    total_key(i) = pass_result.Total_Sifted_Key;
    %disp(sum(pass_result.QBERs(pass_result.Elevation_Limit_Flags)))
    %disp(min(pass_result.QBERs(pass_result.Elevation_Limit_Flags)))
    %disp(max(pass_result.QBERs(pass_result.Elevation_Limit_Flags)))
    %disp(mean(pass_result.QBERs(pass_result.Elevation_Limit_Flags)))
    min_qber(i) = min(min(pass_result.QBERs(pass_result.Elevation_Limit_Flags)));
    max_qber(i) = max(pass_result.QBERs(pass_result.Elevation_Limit_Flags));
    mean_qber(i) = mean(pass_result.QBERs(pass_result.Elevation_Limit_Flags));
end
figure
plot(fovs, total_key)
figure
hold on
plot(fovs, 100*min_qber)
plot(fovs, 100*max_qber)
plot(fovs, 100*mean_qber)


det_effs = linspace(0.1, 0.9, 50);
fovs = linspace( ...
    solidAngleFOV(f, fieldStopDiameter(f, Dr, wvl * 1e-9)), ...
    100e-12, ...
    50);

mpd_bb84_detector = MPD_Detector( ...
    wavelength, ...
    transmitter_source.Repetition_Rate, ...
    time_gate_width, ...
    Spectral_filter_width);

pass_sim = PassSimulation( ...
    sim_satellite, ...
    decoyBB84_Protocol, ...
    sim_ground_station);
pass_result_base = Simulate(pass_sim, []);

cm_base = count_map(jan_rf);

total_key = zeros(numel(det_effs), numel(fovs));
total_bcr = zeros(numel(det_effs), numel(fovs));
min_qber = zeros(numel(det_effs), numel(fovs));
max_qber = zeros(numel(det_effs), numel(fovs));
mean_qber = zeros(numel(det_effs), numel(fovs));

for i = 1:numel(det_effs)
    disp(i)
    eta = det_effs(i);
    mpd_bb84_detector = mpd_bb84_detector.SetDetectionEfficiency(eta);
    sim_ground_station = Errol_OGS( ...
        receiver_telescope, ...
        Detector = mpd_bb84_detector);
    pass_sim = PassSimulation(sim_satellite, decoyBB84_Protocol, sim_ground_station);
    for j = 1:numel(fovs)
        f = fovs(j);
        cm = cm_base.nSkyPhotons(wvl, f, Dr, 0.1, 1e-9);
        counts = cm.countsForPass( ...
            pass_result_base.Elevations(pass_result_base.Elevation_Limit_Flags), ...
            pass_result_base.Headings(pass_result_base.Elevation_Limit_Flags), ...
            30);

        pass_result = pass_sim.SimulateDownlink(cm);
        total_bcr(i, j) = sum(counts);
        total_key(i, j) = pass_result.Total_Sifted_Key;
        min_qber(i, j) = min(min(pass_result.QBERs(pass_result.Elevation_Limit_Flags)));
        max_qber(i, j) = max(pass_result.QBERs(pass_result.Elevation_Limit_Flags));
        mean_qber(i, j) = mean(pass_result.QBERs(pass_result.Elevation_Limit_Flags));
    end
end

[XX, YY] = meshgrid(fovs, det_effs);
figure
shading interp
surface(XX,YY,total_key)
title('total key')
figure
surface(XX,YY,total_bcr)
title('total bcr')
figure
surface(XX,YY,min_qber)
title('min qber')
figure
surface(XX,YY,max_qber)
title('max qber')
figure
surface(XX,YY,mean_qber)
title('mean qber')

qbersAndSkrs = struct();
qbersAndSkrs.total_key = total_key;
qbersAndSkrs.total_bcr = total_bcr;
qbersAndSkrs.min_qber = min_qber;
qbersAndSkrs.max_qber = max_qber;
qbersAndSkrs.mean_qber = mean_qber;
qbersAndSkrs.detection_efficiency = det_effs;
qbersAndSkrs.FOVs = fovs;
save(adduserpath('~/Documents/tqi_data/qbersAndSkrs.mat'), 'qbersAndSkrs');

test = load(adduserpath('~/Documents/tqi_data/qbersAndSkrs.mat'))

%%

qbersAndSkrs = load(adduserpath('~/Documents/tqi_data/qbersAndSkrs.mat'));
qbersAndSkrs = qbersAndSkrs.qbersAndSkrs;

total_key = qbersAndSkrs.total_key;
total_bcr = qbersAndSkrs.total_bcr;
min_qber = qbersAndSkrs.min_qber;
max_qber = qbersAndSkrs.max_qber;
mean_qber = qbersAndSkrs.mean_qber;
det_effs = qbersAndSkrs.detection_efficiency;
fovs = qbersAndSkrs.FOVs;


pass_sim = PassSimulation( ...
    sim_satellite, ...
    decoyBB84_Protocol, ...
    sim_ground_station);
pass_result_base = Simulate(pass_sim, []);
cm_base = count_map(jan_rf);
cm = cm_base.nSkyPhotons(wvl, fovs(18), Dr, 0.1, 1e-9);
counts = cm.countsForPass( ...
    pass_result_base.Elevations(pass_result_base.Elevation_Limit_Flags), ...
    pass_result_base.Headings(pass_result_base.Elevation_Limit_Flags), ...
    30);
fixed_effs = struct();
fixed_effs.efficiencies = linspace(0.1, 0.9, 5);
fixed_effs.efficiencies = [0.2, 0.5, 0.8];
fixed_effs.passes = cell(size(fixed_effs.efficiencies));
for i = 1:numel(fixed_effs.efficiencies)
    eta = fixed_effs.efficiencies(i);
    mpd_bb84_detector = mpd_bb84_detector.SetDetectionEfficiency(eta);
    sim_ground_station = Errol_OGS( ...
        receiver_telescope, ...
        Detector = mpd_bb84_detector);
    pass_sim = PassSimulation(sim_satellite, decoyBB84_Protocol, sim_ground_station);
    fixed_effs.passes{i} = pass_sim.SimulateDownlink(cm);
end

temp = fixed_effs.passes{1}
temp.plot

extrema = @(array) [min(array), max(array)];
disp(f*sqrt(4.*fovs(18)./pi)*(1e6))
[XX, YY] = meshgrid(f*sqrt(4.*fovs./pi)*(1e6), det_effs);
figure(Position=[1, 1, 800, 600])
hold on
subplot(3, 2, [5,6])
yyaxis right
hold on
for i = 1:numel(fixed_effs.efficiencies)
    sim = fixed_effs.passes{i};
    plot(sim.Times(sim.Elevation_Limit_Flags), ...
        100.*sim.QBERs(sim.Elevation_Limit_Flags))
end
xlabel('Time (s)')
ylabel('QBER \%')
legend(cellfun(@(eta) strjoin({'$\eta = $', eta}), ...
    strsplit(num2str(fixed_effs.efficiencies)), ...
    UniformOutput=false))
yyaxis left
for i = 1:numel(fixed_effs.efficiencies)
    sim = fixed_effs.passes{i};
    plot(sim.Times(sim.Elevation_Limit_Flags), ...
        sim.Secret_Key_Rates(sim.Elevation_Limit_Flags) ./ 1000)
end
ylabel('SKR (kBits/s)')
legend(cellfun(@(eta) strjoin({'$\eta = $', eta}), ...
    strsplit(num2str(fixed_effs.efficiencies)), ...
    UniformOutput=false))
xlim(extrema(sim.Times(sim.Elevation_Limit_Flags)))
subplot(3, 2, [1,3])
grid on
surface(XX, YY, total_key .* (1e-6))
xlabel('Field Stop Diameter, $\mu m$')
set(get(gca,'xlabel'),'rotation',10)
ylabel('$\eta$')
zlabel('MBits')
view(-40, 15)
shading interp
c = colorbar(location = 'NorthOutside');
tempZ = total_key.* (1e-6);
caxis([quantile(tempZ(:), 0.01), quantile(tempZ(:), 0.99)])
subplot(3, 2, [2, 4])
grid on
surface(XX, YY, total_bcr.* (1e-6))
view(-40, 15)
shading interp
xlabel('Field Stop Diameter, $\mu m$')
set(get(gca,'xlabel'),'rotation',10)
ylabel('$\eta$')
zlabel('Solar Counts MHz')
c = colorbar(location = 'NorthOutside');
tempZ = total_bcr.* (1e-6);
caxis([quantile(tempZ(:), 0.01), quantile(tempZ(:), 0.99)])
hold off
exportgraphics(gcf, ...
    adduserpath(['~/Documents/tqi_review_march_2023/src/figures/effect_of_solar_counts_', num2str(wvl), '.pdf']),'ContentType','vector')

%%

% elevs = 90 - pass_result.Elevations(pass_result.Communicating_Flags);
% azims = pass_result.Headings(pass_result.Communicating_Flags);
% numel(elevs) == numel(azims)
% disp(numel(elevs))
% wvl = 850;
% sky_counts_jan = zeros(1, numel(elevs));
% sky_counts_aug = zeros(1, numel(elevs));
% raw_jan = fliplr(jan_rf.pickRadianceForWavelength(wvl));
% raw_aug = fliplr(aug_rf.pickRadianceForWavelength(wvl));
% for i = 1:numel(azims)
%     [val, azim_idx] = min(abs(jan_rf.azimuths - azims(i)));
%     [val, elev_idx] = min(abs(rad2deg(jan_rf.elevations) - elevs(i)));
%     sky_counts_jan(i) = raw_jan(azim_idx, elev_idx);
%     sky_counts_aug(i) = raw_aug(azim_idx, elev_idx);
% end
% sky_counts_jan = fliplr(sky_counts_jan);
% sky_counts_aug = fliplr(sky_counts_aug);
% 
% 
% first_diameter = fieldStopDiameter(f, Dr, wvl * 1e-9)
% fstops = linspace(first_diameter, first_diameter*10, 50);
% fovs = solidAngleFOV(f, fstops)
% counts_for_pass_jan = zeros(1, numel(fovs));
% counts_for_pass_aug = zeros(1, numel(fovs));
% for i = 1:numel(fovs)
%     counts_for_pass_jan(i) = ...
%         sum(nSkyPhotons(sky_counts_jan .* (1e-3), fovs(i), Dr, wvl, 1, 1));
%     counts_for_pass_aug(i) = ...
%         sum(nSkyPhotons(sky_counts_aug .* (1e-3), fovs(i), Dr, wvl, 1, 1));
% end
% 
% figure
% hold on
% semilogy(fstops.*(1e6), counts_for_pass_jan)
% semilogy(fstops.*(1e6), counts_for_pass_aug)
% legend({'January', 'August'}, Location='southeast')
% xlabel('Field Stop Diameter, $\mu$m')
% ylabel('Counts')
% set(gca, 'Yscale', 'log')
% %set(gca, 'DataAspectRatio', [1, 2])
% %exportgraphics(gcf, adduserpath(['~/Documents/tqi_review_march_2023/src/figures/total_sky_counts_', num2str(wvl), '.pdf']),'ContentType','vector')
% 
% 
% atmo = Atmosphere()
% atmo.Azimuth = jan_rf.azimuths;
% atmo.Elevation = rad2deg(jan_rf.elevations);
% atmo.wavelengths = jan_rf.wavelengths;
% atmo.sky_dome = fliplr(jan_rf.pickRadianceForWavelength(wvl));
% atmo
% 
% pass_sim = PassSimulation( ...
%     sim_satellite, ...
%     decoyBB84_Protocol, ...
%     sim_ground_station, ...
%     Background_Sources=atmo);
% 
% pass_result = Simulate(pass_sim);
% plot(pass_result)
% 
% % okay... right, so... we need to make something like the Atmosphere class that
% % was designed for use with SMARTS data work with the libRadtran data.
% % Best way to do this is to probably add new methods to the Atmosphere class
% % and then pass it in as we would normally, i.e. set the atmosphere_file_location
% % for the ground station. atmosphere_file_location should point to a file that 
% % contain a struct with an atmosphere field.
% % Alternatively would it make more sense to alter the 
% % ComputeTotalBackgroundCountRate function inside of Ground_Station to accept
% % a radiance map, might be easier for now.. Also this is probably time to start
% % migrating everything over to use enums and switch statements...
% % lets update things for now to make use of the radiance_file class...
