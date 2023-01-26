
%% create an atmosphere file for each of several times

Times = datetime(2022,12,24,6,40,0):hours(1):datetime(2022,12,25,6,40,0); %from christmas eve to christmas day 2022
Num_Times = numel(Times);
Step_Size_azimuth = 40;
Step_Size_elevation = 10;
SMARTS_Path = 'C:\Git\SMARTS\';

results_path = [pwd,filesep,'SMARTS_connection',filesep,'SMARTS cache',filesep];
output_atmosphere_path = [pwd,filesep,'SMARTS_connection',filesep,'SMARTS cache',filesep,'Errol_Atmosphere'];

Atmospheres = repmat(GenerateAtmosphere(),[1,Num_Times]);


for i=1:numel(Times)
config = solar_background_errol(executable_path=SMARTS_Path, stub=results_path,...
    dateAndTime=Times(i));

genAtmos = GenerateAtmosphere(config, step_size_aziumth=Step_Size_azimuth, step_size_elevation=Step_Size_elevation);
genAtmos.ExportAtmosphere(strcat(output_atmosphere_path,string(Times(i),'HH')));

Atmospheres(i)=genAtmos;
save([output_atmosphere_path,'_winter_times'],"Atmospheres");
end