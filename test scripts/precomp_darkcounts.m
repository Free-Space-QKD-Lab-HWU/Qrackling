%% Pre comp..
clear all
close all

orbit_data_root = '/home/bp38/Projects/QKD_Sat_Link/smarts_integration/orbit modelling resources/orbit LLAT files/';

% Declare common values
Transmitter_Diameter = 0.08;
Receiver_Diameter = 0.7;
OrbitDataFileLocation = '100kmOrbitLLAT.txt';
% OrbitDataFileLocation= '500kmSSOrbitLLAT.txt';
Time_Gate_Width = 10^-9;
Repetition_Rate = 1;
Spectral_Filter_Width = 1;
Wavelength = 850;
n_ph_opts = linspace(0.3, 0.8, 6);
n_ph = n_ph_opts(1);

disp(OrbitDataFileLocation);

telescope_tx = Telescope(Transmitter_Diameter, "Wavelength", Wavelength);
telescope_rx = Telescope(Receiver_Diameter, "Wavelength", Wavelength);

source = Source(Wavelength, ...
                Repetition_Rate = Repetition_Rate, ...
                Mean_Photon_Number = [n_ph, 1-n_ph,0], ...
                State_Prep_Error = 0.025, ...
                State_Probabilities =[0.7,0.2,0.1]);

protocol = decoyBB84_Protocol();

detector = Excelitas_Detector(Wavelength, Repetition_Rate, ...
                               Time_Gate_Width, Spectral_Filter_Width);

%make generic components
sat = Satellite(source, telescope_tx, ...
                'OrbitDataFileLocation',OrbitDataFileLocation, ...
                'Protocol', protocol);

ogs = Errol_OGS(detector, telescope_rx);

ispr = sitePressure(spr=1013.25, altit=0, height=0);
iatmos = atmosphere(atmos='STS');
ih20 = water_vapour(w=1);
i03 = ozone();
igas = gas_atmospheric_absorption(iload=0); 
ico2 = carbon_dioxide(amount=370);
iaeros = aerosol(aeros='S&F_RURAL');
iturb = turbidity(visi=50);
ialbdx = far_field_albedo(spectral_reflectance=38, tilt=45, wazim=0, ialbdg=38);
isolar = extra_spectral(wlmin=280, wlmax=4000, suncor=1, solarc=1367);
iprt = printing(output_options=linspace(2, 8, 7), wpmn=280, wpmx=4000, intvl=0.5);
icirc = circum_solar(slope=0, apert=2.9, limit=0);
iscan = scanning(filtering=0);
illum = illuminance(value=0);
iuv =  broadband_uv(value=0);

hour = 10;
start_time = datetime(2022, 8, 15, hour, 0, 0);
file_path = ['/home/bp38/Documents/MATLAB/SMARTS/precomptest', num2str(hour), '/'];
file_path = ['/home/bp38/Documents/MATLAB/SMARTS/newtest', num2str(hour), '/'];
file_path = ['/home/bp38/Documents/MATLAB/SMARTS/anothertest', num2str(hour), '/'];
disp(file_path);
imass = solar_position_and_airmass(dateAndTime=start_time, ...
        latitude=56.405, longitude=-3.183);

inputs = {ispr, iatmos, ih20, i03, igas, ico2, iaeros, iturb, ialbdx, ...
          isolar, iprt, icirc, iscan, illum, iuv, imass};

smarts_path = '/home/bp38/Downloads/smarts-295-linux-tar/SMARTS_295_Linux/';
s = SMARTS_input(comment='this is a test', ...
                 args=inputs, ...
                 executable_path=smarts_path, ...
                 stub=file_path);

sat_pass = PassSimulation(sat, protocol, ogs);
sat_pass = Simulate(sat_pass);
sat_pass.plot();

sat_pass = PassSimulation(sat, protocol, ogs, SMARTS=s);
sat_pass = Simulate(sat_pass);
sat_pass.plot();

H = sat_pass.Headings(sat_pass.Communicating_Flags == 1);
E = sat_pass.Elevations(sat_pass.Communicating_Flags == 1);
T = sat_pass.Times(sat_pass.Communicating_Flags == 1);
disp(size(H));

%% SMARTS

ispr = sitePressure(spr=1013.25, altit=0, height=0);
iatmos = atmosphere(atmos='STS');
ih20 = water_vapour(w=1);
i03 = ozone();
igas = gas_atmospheric_absorption(iload=0); 
ico2 = carbon_dioxide(amount=370);
iaeros = aerosol(aeros='S&F_RURAL');
iturb = turbidity(visi=50);
ialbdx = far_field_albedo(spectral_reflectance=38, tilt=45, wazim=0, ialbdg=38);
isolar = extra_spectral(wlmin=280, wlmax=4000, suncor=1, solarc=1367);
iprt = printing(output_options=linspace(2, 8, 7), wpmn=280, wpmx=4000, intvl=0.5);
icirc = circum_solar(slope=0, apert=2.9, limit=0);
iscan = scanning(filtering=0);
illum = illuminance(value=0);
iuv =  broadband_uv(value=0);

hour = 10
start_time = datetime(2022, 8, 15, hour, 0, 0);
file_path = ['/home/bp38/Documents/MATLAB/SMARTS/precomptest', num2str(hour), '/'];
file_path = ['/home/bp38/Documents/MATLAB/SMARTS/newtest', num2str(hour), '/'];
disp(file_path);
imass = solar_position_and_airmass(dateAndTime=start_time, ...
        latitude=56.405, longitude=-3.183);

inputs = {ispr, iatmos, ih20, i03, igas, ico2, iaeros, iturb, ialbdx, ...
          isolar, iprt, icirc, iscan, illum, iuv, imass};

smarts_path = '/home/bp38/Downloads/smarts-295-linux-tar/SMARTS_295_Linux/';
s = SMARTS_input(comment='this is a test', ...
                 args=inputs, ...
                 executable_path=smarts_path, ...
                 stub=file_path);

file_names = cell(size(H));

for i = 1 : numel(H)
    az = H(i);
    el = E(i);
    file_name = num2str(i);
    disp(file_name);
    file_names{i} = file_name;
    ialbdx = far_field_albedo(spectral_reflectance=38, ...
                              tilt=el, ...
                              wazim=az, ...
                              ialbdg=38);
    inputs = {ispr, iatmos, ih20, i03, igas, ico2, iaeros, iturb, ialbdx, ...
                isolar, iprt, icirc, iscan, illum, iuv, imass};
    [s, success, destination] = s.run_smarts(file_path=s.file_path_stub, ...
                                             file_name=file_name);
    assert(success, 'Something failed...');
end

%% calc radiance

file_path = ['/home/bp38/Documents/MATLAB/SMARTS/PassAt', num2str(hour), '/'];

data_file = [file_path, num2str(1), '.ext.txt'];
data = readtable(data_file);

wavelengths = data.Wvlgth;

global_titled_irradiance = zeros(numel(az), numel(wavelengths));
radiance = zeros(size(global_titled_irradiance));

n_ph_sky = zeros(size(radiance));
fov = telescope_rx.FOV ^ 2;

for i = 1 : numel(H)
    data_file = [file_path, num2str(i), '.ext.txt'];
    data = readtable(data_file);
    global_titled_irradiance(i, :) = data.Global_tilted_irradiance;
    radiance(i, :) = irradiance2radiance(global_titled_irradiance(i, :), ...
                                         wavelengths', 1e-9);
    n_ph_sky(i, :) = sky_photons(radiance(i, :), fov, telescope_rx.Diameter, ...
                              wavelengths', 1e-9, 1);
end

%% sky photons during pass

figure
plot(sum(n_ph_sky, 2))

