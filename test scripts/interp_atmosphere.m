%% preamble
clear all
close all

%% build atmosphere
smarts_path = '/home/bp38/Downloads/smarts-295-linux-tar/SMARTS_295_Linux/';
results_path = '/home/bp38/Documents/MATLAB/SMARTS/gen_atmosphere_again/';
config = solar_background_errol(executable_path=smarts_path, stub=results_path);
genAtmos = GenerateAtmosphere(config, step_size_aziumth=5, step_size_elevation=5);
output_atmosphere_path = '/home/bp38/Documents/MATLAB/test_atmosphere_2.mat';
genAtmos.ExportAtmosphere(output_atmosphere_path);
atmosphere = genAtmos.LoadAtmosphere(output_atmosphere_path);
data = readtable(sprintf('%s.ext.txt', genAtmos.result_files{1}), VariableNamingRule='preserve' );

%% plot
close all
figure
hold on
fields = fieldnames(atmosphere.values{1}.data);
cases = {'irradiance', 'transmit'};
n_opt = linspace(1, numel(cases), numel(cases));
count = 0;
axs = {subplot(2, 1, 1), subplot(2, 1, 2)};
keys = {{}, {}};
totals = ones(1, numel(cases));
for i = 1 : numel(fields)
    fn = fields{i};
    res = sum(cellfun(@(c) contains(fn, c), cases) .* n_opt);
    switch res
        case 0
            continue
        otherwise
            axes(axs{res});
            hold on
            plot(atmosphere.wavelengths, table2array(atmosphere.values{1}.data(:,i)))
            hold off
            keys{res}{totals(res)} = fn;
            totals(res) = totals(res) + 1;
    end
end

for a = 1 : numel(totals)
    axes(axs{a});
    legend(cellfun(@(s) replace(s, '_', ' '), keys{a}, UniformOutput=false))
end

%% satellite pass

circAreaFromDiameter = @(d) pi * (d / 2)^2;
obscurationRatio = @(d, obs) 1 - (circAreaFromDiameter(d*obs) / circAreaFromDiameter(d));

OrbitDataFileLocation= '500kmSSOrbitLLAT.txt';

wvl = 808;
wvl = 785;

if 808 == wvl
    eta_back = 0.9;
    eta_back = 0.81;
elseif 785 == wvl
    eta_back = 0.935;
    eta_back = 0.81;
else
    eta_back = 1;
end

n_ph_opts = linspace(0.3, 0.8, 6);
n_ph = n_ph_opts(1);
reprate = 200e6;
time_gate = 10^-9;
spectral_filter = 1;
dcr = 1000; % optionally 200

central_obscuration_ratio_rx = 0.3;
diameter_tx = 0.08;
diameter_rx = 0.7;

protocol = decoyBB84_Protocol();

source = Source(wvl, ...
                Repetition_Rate = 50e6, ...
                Mean_Photon_Number = [n_ph, 0.8, 0], ...
                State_Prep_Error = 0.025, ...
                State_Probabilities = [0.7,0.2,0.1] );

detector = Excelitas_Detector(wvl, 50e6, time_gate, ...
                              spectral_filter, Dead_Time = 1e-6);

telescope_tx = Telescope(diameter_tx, Wavelength = wvl);
telescope_rx = Telescope(diameter_rx, Wavelength = wvl);

telescope_rx.Optical_Efficiency = eta_back ...
                                  * obscurationRatio(diameter_rx, ...
                                                     central_obscuration_ratio_rx);

ogs = Errol_OGS(detector, telescope_rx);

satellite = Satellite(source, telescope_tx, ...
                      'OrbitDataFileLocation', OrbitDataFileLocation);

decoybb84_pass = PassSimulation(satellite, protocol, ogs, Visibility='clear');
decoybb84_pass = Simulate(decoybb84_pass);


%% Positions

azimuth = decoybb84_pass.Headings(decoybb84_pass.Elevation_Limit_Flags);
elevation = decoybb84_pass.Elevations(decoybb84_pass.Elevation_Limit_Flags);

reorderAngles = @(angles) mod((angles - 180), 360);
azimuth = reorderAngles(azimuth);
elevation = reorderAngles(elevation);

figure
plot(azimuth, elevation)
