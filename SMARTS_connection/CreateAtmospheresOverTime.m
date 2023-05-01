%% create an atmosphere file for each of several times

Times = datetime(2022,12,24,6,0,0):hours(6):datetime(2022,12,25,6,0,0); %from christmas eve to christmas day 2022
Num_Times = numel(Times);
Step_Size_azimuth = 90;
Step_Size_elevation = 45;
Visibility = 10;            %meterological visibility in km
Wavelength_Min = 600;       %min simulated wavelength (nm)
Wavelength_Max = 1000;      %max simulated wavelength (nm)
Wavelength_Step = 50;       %interval in simulated wavelengths (nm)
SMARTS_Path = 'C:\Git\SMARTS\';

results_path = [pwd,filesep,'SMARTS_connection',filesep,'SMARTS cache',filesep];
output_atmosphere_path = [pwd,filesep,'SMARTS_connection',filesep,'SMARTS cache',filesep,'Errol_Atmosphere'];


%simulate and export and individual .mats
for i=1:Num_Times
config = solar_background_errol(executable_path=SMARTS_Path, stub=results_path,...
    dateAndTime=Times(i),...
    Wavelength_Min=Wavelength_Min, Wavelength_Max=Wavelength_Max,Wavelength_Step=Wavelength_Step,...
    Visibility=Visibility);

genAtmos = GenerateAtmosphere(config, step_size_aziumth=Step_Size_azimuth, step_size_elevation=Step_Size_elevation);
genAtmos.ExportAtmosphere(strcat(output_atmosphere_path,string(Times(i),'HH')));
end

%load these exported atmospheres in and save them as one .mat file with the
%hours they represent
Atmospheres = cell(1,Num_Times);
Hours = zeros(1,Num_Times);
for i=1:Num_Times
    atmosphere = load(strcat(output_atmosphere_path,string(Times(i),'HH')));
    Atmospheres{i} = atmosphere;
    Hours(i) = hour(Times(i));
end
save([pwd,filesep,'SMARTS_connection',filesep,'SMARTS cache',filesep,'Errol_Atmosphere_Visibility_',sprintf('%i',Visibility),'km_winter_times'],...
    "Atmospheres","Hours",'-v7.3');

%delete old exported atmospheres
for i=1:Num_Times
    delete(strcat(output_atmosphere_path,string(Times(i),'HH'),'.mat'));
end