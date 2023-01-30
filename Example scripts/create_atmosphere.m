%% run

clear all
close all

smarts_path = 'C:\Git\SMARTS\';
results_path = [pwd,filesep,'SMARTS_connection',filesep,'SMARTS cache',filesep];
config = solar_background_errol(executable_path=smarts_path, stub=results_path);

genAtmos = GenerateAtmosphere(config, step_size_aziumth=40, step_size_elevation=10);
output_atmosphere_path = [pwd,filesep,'SMARTS_connection',filesep,'SMARTS cache',filesep,'Errol_Atmosphere.mat'];
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
