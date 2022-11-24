%% run

clear all
close all

smarts_path = '/home/bp38/Downloads/smarts-295-linux-tar/SMARTS_295_Linux/';
results_path = '/home/bp38/Documents/MATLAB/SMARTS/gen_atmosphere/';
config = solar_background_errol(executable_path=smarts_path, stub=results_path);

genAtmos = GenerateAtmosphere(config);
genAtmos.ExportAtmosphere('/home/bp38/Documents/MATLAB/test_atmosphere.mat');

% need to do further tests
