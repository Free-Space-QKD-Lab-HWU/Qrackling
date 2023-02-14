%% create an atmosphere file for each of several times

Times = datetime(2022,12,24,6,40,0):hours(1):datetime(2022,12,25,6,40,0); %from christmas eve to christmas day 2022
Num_Times = numel(Times);
Step_Size_azimuth = 45;
Step_Size_elevation = 10;
Visibility = 10;            %meterological visibility in km
Wavelength_Min = 500;       %min simulated wavelength (nm)
Wavelength_Max = 1800;      %max simulated wavelength (nm)
Wavelength_Step = 10;       %interval in simulated wavelengths (nm)
SMARTS_Path = 'C:\Git\SMARTS\';

results_path = [pwd,filesep,'SMARTS_connection',filesep,'SMARTS cache',filesep];
output_atmosphere_path = [pwd,filesep,'SMARTS_connection',filesep,'SMARTS cache',filesep,'Errol_Atmosphere'];

Atmospheres = repmat(GenerateAtmosphere(),[1,Num_Times]);


for i=1:Num_Times
config = solar_background_errol(executable_path=SMARTS_Path, stub=results_path,...
    dateAndTime=Times(i),...
    Wavelength_Min=Wavelength_Min, Wavelength_Max=Wavelength_Max,Wavelength_Step=Wavelength_Step,...
    Visibility=Visibility);

genAtmos = GenerateAtmosphere(config, step_size_aziumth=Step_Size_azimuth, step_size_elevation=Step_Size_elevation);
genAtmos.ExportAtmosphere(strcat(output_atmosphere_path,string(Times(i),'HH')));

Atmospheres(i)=genAtmos;
save([output_atmosphere_path,'_Visibility_',sprintf('%i',Visibility),'km_winter_times'],"Atmospheres");
end