%% run

clear all
close all

smarts_path = '/home/bp38/Downloads/smarts-295-linux-tar/SMARTS_295_Linux/';
results_path = '/home/bp38/Documents/MATLAB/SMARTS/gen_atmosphere/';
config = solar_background_errol(executable_path=smarts_path, stub=results_path);

genAtmos = GenerateAtmosphere(config)

%% read files


atmosphere = cell(numel(genAtmos.azimuth), numel(genAtmos.elevation));

for i = 1 : numel(genAtmos.azimuth)
    a = genAtmos.azimuth(i);
    for j = 1 : numel(genAtmos.elevation)
        e = genAtmos.azimuth(j);
        fp = convertCharsToStrings(genAtmos.result_files{i, j}) + ".ext.txt";
        disp(fp)
        data = readtable(fp, 'VariableNamingRule', 'preserve');
        temp.azimuth = a;
        temp.elevation = e;
        temp.transmittance = data.Mixed_gas__transmittance;
        temp.global_tilted_irradiance = data.Global_tilted_irradiance;
        atmosphere{i, j} = temp;
    end
end

%%

a = genAtmos.azimuth;
e = genAtmos.elevation;

A = linspace(1, 4, 4);
E = linspace(1, 3, 3);

[AE, EE] = meshgrid(A, E);
opts = [AE(:), EE(:)]
opts(2, :)
reshape(opts, [3, 4, 2])
EE
