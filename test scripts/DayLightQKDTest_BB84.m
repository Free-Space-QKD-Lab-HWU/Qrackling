%% simulate an E91 QKD pass with the sun above
clear all
close all

orbit_data_root = '/home/bp38/Projects/QKD_Sat_Link/smarts_integration/orbit modelling resources/orbit LLAT files/';

% Declare common values
Transmitter_Diameter = 0.08;
Receiver_Diameter = 0.7;
OrbitDataFileLocation = '500kmOrbitLLAT.txt';
OrbitDataFileLocation= '500kmSSOrbitLLAT.txt';
Time_Gate_Width = 10^-9;
%Time_Gate_Width = 1;
Repetition_Rate = 1;
Spectral_Filter_Width = 10e-3;
Spectral_Filter_Width = 1;
Spectral_Filter_Width_arr = 10 .^ linspace(-4, 0, 25);
% Spectral_Filter_Width_arr = 10 .^ linspace(0, 0, 1);
Wavelength = 850;

disp(OrbitDataFileLocation);

total_skr = zeros(size(Spectral_Filter_Width_arr));

% declare common components
% Transmitter_Telescope = Telescope(Transmitter_Diameter,Wavelength);
% Receiver_Telescope = Telescope(Receiver_Diameter,Wavelength);
Transmitter_Telescope = Telescope(Transmitter_Diameter, "Wavelength", Wavelength);
Receiver_Telescope = Telescope(Receiver_Diameter, "Wavelength", Wavelength);

% import sun object
Sun = getfield(load('Sun.mat'),'Sun');
Sun = Sun.SetPosition('LLA', [53, 60, Sun.Altitude], 'Name', Sun.Location_Name);

BB84_S = BB84_Source(Wavelength);
%BB84_P = BB84_Protocol();
BB84_P = protocol(qkd_protocols.BB84);
BB84_D = MPD_Detector(Wavelength, ...
                      Repetition_Rate, ...
                      Time_Gate_Width, ...
                      Spectral_Filter_Width_arr(1));

%make generic components
SimSatellite = Satellite(BB84_S, Transmitter_Telescope, ...
                         'OrbitDataFileLocation',OrbitDataFileLocation, ...
                         'Protocol', BB84_P);

SimGround_Station = Errol_OGS(BB84_D, Receiver_Telescope);

% BB84_Pass = PassSimulation(SimSatellite, BB84_P, SimGround_Station, ...
%     'Background_Sources', Sun);
BB84_Pass = PassSimulation(SimSatellite, BB84_P, SimGround_Station);
BB84_Pass = Simulate(BB84_Pass);
BB84_Pass.plot()

%%

% activeSatLat = SimSatellite.Latitude(BB84_Pass.Communicating_Flags == 1);
% activeSatLon = SimSatellite.Longitude(BB84_Pass.Communicating_Flags == 1);
%  
% activeOgsLat = SimGround_Station.Latitude .* ones(numel(activeSatLat), 1);
% activeOgsLon = SimGround_Station.Longitude .* ones(numel(activeSatLon), 1);
%  
% azimuth(activeOgsLat, activeOgsLon, activeSatLat, activeSatLon)

% NOTE: The commented block above gives returns the same values as the 
%   headings in the pass simulation -> headings should be renamed azimuth
active_azimuth = BB84_Pass.Headings(BB84_Pass.Communicating_Flags == 1);
active_elevations = BB84_Pass.Elevations(BB84_Pass.Communicating_Flags == 1);

% N_B = BB84_Pass.Background_Sources.GetDirectedLight(SimGround_Station, 16.35);
% disp(N_B);



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

hours = linspace(0, 23, 24);
% hours = linspace(9, 12, 4);

for h = hours
    hour = h;
    start_time = datetime(2022, 8, 15, hour, 0, 0);
    file_path = ['/home/bp38/Documents/MATLAB/SMARTS/PassAt', num2str(hour), '/'];
    disp(file_path);
    imass = solar_position_and_airmass(dateAndTime=start_time, ...
            latitude=56.405, longitude=-3.183);
    
    inputs = {ispr, iatmos, ih20, i03, igas, ico2, iaeros, iturb, ialbdx, ...
              isolar, iprt, icirc, iscan, illum, iuv, imass};
    
    smarts_path = '/home/bp38/Downloads/smarts-295-linux-tar/SMARTS_295_Linux/';
    %s = SMARTS_input(comment='this is a test', args=inputs, executable_path=smarts_path);
    % [s, success, destination] = s.run_smarts(file_name='test');
    % assert(success, 'Something failed...');
    
    file_names = cell(size(active_azimuth));
    
    for i = 1 : numel(active_azimuth)
        file_name = num2str(i);
        disp(file_name);
        file_names{i} = file_name;
        ialbdx = far_field_albedo(spectral_reflectance=38, ...
            tilt=active_elevations(i), wazim=active_azimuth(i), ialbdg=38);
        inputs = {ispr, iatmos, ih20, i03, igas, ico2, iaeros, iturb, ialbdx, ...
                    isolar, iprt, icirc, iscan, illum, iuv, imass};
        s = SMARTS_input(comment='this is a test', args=inputs, executable_path=smarts_path);
        % [s, success, destination] = s.run_smarts(file_path=file_path, file_name=file_name);
        % assert(success, 'Something failed...');
    end
end

%% Sky-photons over pass



%% Process SMARTS data

irradianceToRadiance = @(irradiance) irradiance ./ (2 * pi);
bandpass = @(array, wvl, width) (array > (wvl - (width/2))) & ((array < (wvl + (width/2))));

h = 6.62607015*10^-34; % plank's constant
c = 299792458; % speed of light

N_SKY_PHOTONS = @(RADIANCE, RX_D, FOV, WL, DWL, DT) ...
            (RADIANCE .* (FOV * pi * (RX_D^2) * WL * DWL * DT)) ...
            ./ (4 * h * c);

fd2fov = @(fd_arcmin) 2 * pi ...
                      * (1 - cos(deg2rad((fd_arcmin ./ 60) ./ 2)));

telescope_field_diameter = 16.35;
fov = fd2fov(telescope_field_diameter);

choice_hours = [0, 6, 12, 18];
choice_hours = hours;

diffuse_tilted_irradiance = zeros(numel(choice_hours), numel(file_names));
direct_tilted_irradiance = zeros(numel(choice_hours), numel(file_names));
global_tilted_irradiance = zeros(numel(choice_hours), numel(file_names));
diffuse_tilted_photons = zeros(numel(choice_hours), numel(file_names));
direct_tilted_photons = zeros(numel(choice_hours), numel(file_names));
global_tilted_photons = zeros(numel(choice_hours), numel(file_names));

total_key_timeVsWidth = zeros(numel(choice_hours), numel(Spectral_Filter_Width_arr));
total_skyPhotons_timeVsWidth = zeros(numel(choice_hours), numel(Spectral_Filter_Width_arr));
%sky_photons_over_pass1 = zeros(numel(choice_hours), numel(file_names));
%sky_photons_over_pass2 = zeros(numel(choice_hours), numel(file_names));
%sky_photons_over_pass3 = zeros(numel(choice_hours), numel(file_names));
%sky_photons_over_pass4 = zeros(numel(choice_hours), numel(file_names));
%sky_photons_over_pass5 = zeros(numel(choice_hours), numel(file_names));
sky_photons_over_pass = {...
    zeros(numel(choice_hours), numel(file_names)), ...
    zeros(numel(choice_hours), numel(file_names)), ...
    zeros(numel(choice_hours), numel(file_names)), ...
    zeros(numel(choice_hours), numel(file_names)), ...
    zeros(numel(choice_hours), numel(file_names))};

SimSatellite = Satellite(BB84_S, Transmitter_Telescope, ...
                         'OrbitDataFileLocation',OrbitDataFileLocation, ...
                         'Protocol', BB84_P);

Spectral_Filter_Width_arr = [1e-4, 1e-3, 1e-2, 1e-1 ,1];

for i = 1 : numel(choice_hours)
    hour = choice_hours(i);
    file_path = ['/home/bp38/Documents/MATLAB/SMARTS/PassAt', num2str(hour), '/'];
    disp(file_path)

    for f = 1 : numel(file_names)
        data_file = [file_path, file_names{f}, '.ext.txt'];
        data = readtable(data_file);

        for j = 1 : numel(Spectral_Filter_Width_arr)
            if ~isempty(data.Variables)
                wavelengths = data.Wvlgth;
                wl = 850;
                width = Spectral_Filter_Width_arr(j);
                wl_filter = bandpass(wavelengths, wl, width);
                % wavelengths = wavelengths / 1000;
                % diffuse_tilted_irradiance(i,f) = sum(data.Difuse_tilted_irradiance ./ wavelengths);
                % direct_tilted_irradiance(i,f) = sum(data.Direct_tilted_irradiance ./ wavelengths);
                % global_tilted_irradiance(i,f) = sum(data.Global_tilted_irradiance ./ wavelengths);

                % difuse_tilted_radiance = data.Difuse_tilted_irradiance(wl_filter) ./ (2 * pi);
                % diffuse_tilted_photons(i,f) = sum(N_SKY_PHOTONS(difuse_tilted_radiance, 0.7, fov, ...
                %                               wl * (1e-9), width * (1e-9), 1));

                % direct_tilted_radiance = data.Direct_tilted_irradiance(wl_filter) ./ (2 * pi);
                % direct_tilted_photons(i,f) = sum(N_SKY_PHOTONS(direct_tilted_radiance, 0.7, fov, ...
                %                               wl * (1e-9), width * (1e-9), 1));

                global_tilted_radiance = data.Global_tilted_irradiance(wl_filter) ./ (2 * pi);
                global_tilted_photons(i,f) = sum(N_SKY_PHOTONS(global_tilted_radiance, 0.7, fov, ...
                                              wl * (1e-9), width * (1e-9), 1));
                sky_photons_over_pass{j}(i, f) = global_tilted_photons(i, f);
            end

            % sun_scattered_counts = global_tilted_photons(i, :);
            % total_sky_photons(i,j) = sum(sun_scattered_counts);
            %sky_photons_over_pass{j}(i, :) = global_tilted_photons(i, :);
            %total_skyPhotons_timeVsWidth(i, j) = sum(global_tilted_photons(i, :));
            %total_sky_photons(i, :) = global_tilted_photons(i, :);
            % total_background = zeros(1, numel(BB84_Pass.Communicating_Flags));
            % total_background(BB84_Pass.Communicating_Flags == 1) = sun_scattered_counts ...
            %     + BB84_Pass.Background_Count_Rates(BB84_Pass.Communicating_Flags == 1);
            % 
            % [skr, qber] = BB84_P.EvaluateQKDLink(BB84_Pass.Satellite.Source, ...
            %     BB84_Pass.Ground_Station.Detector, BB84_Pass.Link_Losses_dB, total_background);
            % 
            % skr(isnan(skr)) = 0;
            % qber(isnan(qber)) = 0;
            % 
            % key = sum(skr);
            % total_key_timeVsWidth(i,j) = key;

        end

    end
end


%% Plotting

figure
axes('XScale', 'linear', 'YScale', 'log')
grid on
hold on
title(['Total Collected Solar Background Photons During', newline', 'Satellite Pass at Different Hours of the Day']);
xlabel('Hour of Day')
ylabel('Total #-Sun Scattered Photons Collected')
plot(hours, sum(sky_photons_over_pass{1}, 2))
plot(hours, sum(sky_photons_over_pass{2}, 2))
plot(hours, sum(sky_photons_over_pass{3}, 2))
plot(hours, sum(sky_photons_over_pass{4}, 2))
plot(hours, sum(sky_photons_over_pass{5}, 2))
legend('10^{-4} nm', '10^{-3} nm', '10^{-2} nm', '10^{-1}nm' , '1nm')
xlim([0,24])
hold off

%[X,Y] = meshgrid(hours, linspace(1, numel(file_names), file_names));

figure
hold on
title('Sky photons (Hz) from Diffuse Tilted irradiance');
% contourf(X, Y, total_key_timeVsWidth', 100, 'LineColor','none')
%contourf(X, Y, sky_photons_over_pass{1}', 100, 'LineColor','none')
contourf(sky_photons_over_pass{5}', 100, 'LineColor','none')
colorbar;
xlabel('Hour of Day');
ylabel('Filter Width (nm)')
hold off


%difuse_tilted_radiance = data.Difuse_tilted_irradiance(wl_filter) ./ (2 * pi);

%N_sky_photons = N_SKY_PHOTONS(...
%                difuse_tilted_radiance, 0.7, fov, wl * (1e-9), width * (1e-9), ...
%                1); % 1 second integration time (DT in ...
%                    % N_SKY_PHOTONS) gives us total number of 
%                    % counts per second
%                %Ground_Station.Detector.Time_Gate_Width);

%% Calculate total key for given hour and filter width

total_key_timeVsWidth = zeros(numel(hours), numel(Spectral_Filter_Width_arr));

for i = 1 : numel([1])
    i = 10
    radiance = irradianceToRadiance(global_tilted_irradiance(6, :));
    for j = 1 : numel(Spectral_Filter_Width_arr)
        sun_scattered_counts = N_SKY_PHOTONS(radiance, ...
                        0.7, fov, Wavelength * (1e-9), ...
                        Spectral_Filter_Width_arr(j) * (1e-9), 1);
        
        total_background = zeros(1, numel(BB84_Pass.Communicating_Flags));
        total_background(BB84_Pass.Communicating_Flags == 1) = sun_scattered_counts ...
            + BB84_Pass.Background_Count_Rates(BB84_Pass.Communicating_Flags == 1);
        
        [skr, qber] = BB84_P.EvaluateQKDLink(BB84_Pass.Satellite.Source, ...
            BB84_Pass.Ground_Station.Detector, BB84_Pass.Link_Losses_dB, total_background);
        
        skr(isnan(skr)) = 0;
        qber(isnan(qber)) = 0;
        
        key = sum(skr);
        total_key_timeVsWidth(i,j) = key;
    end
end


%% Plotting



%% extra...


% [Computed_Sifted_Key_Rates, Computed_QBERs] = EvaluateQKDLink(...
%     PassSimulation.Protocol,
%     PassSimulation.Satellite.Source,
%     PassSimulation.Ground_Station.Detector,
%     [Computed_Link_Models(Elevation_Limit_Flags).Link_Loss_dB],
%     [Background_Count_Rates(Elevation_Limit_Flags)]);


disp("Starting");
for i = 1 : length(Spectral_Filter_Width_arr)
    disp(i);
    Spectral_Filter_Width = Spectral_Filter_Width_arr(i);
    % BB84
    %declare specific components
    BB84_D = MPD_Detector(Wavelength, ...
                          Repetition_Rate, ...
                          Time_Gate_Width, ...
                          Spectral_Filter_Width);
    
    %make generic components
    SimSatellite = Satellite(BB84_S, Transmitter_Telescope, ...
                             'OrbitDataFileLocation',OrbitDataFileLocation, ...
                             'Protocol', BB84_P);

    SimGround_Station = Errol_OGS(BB84_D, Receiver_Telescope);
    
    % BB84_Pass = PassSimulation(SimSatellite, BB84_P, SimGround_Station, ...
    %     'Background_Sources', Sun);
    BB84_Pass = PassSimulation(SimSatellite, BB84_P, SimGround_Station);
    
    % N_B = BB84_Pass.Background_Sources.GetDirectedLight(SimGround_Station, 16.35);
    % disp(N_B);
    
    BB84_Pass = Simulate(BB84_Pass);
    total_skr(i) = BB84_Pass.Total_Sifted_Key;
    disp(total_skr);
    %plot(BB84_Pass)
end

figure
semilogx(Spectral_Filter_Width_arr, total_skr);
xlabel('Spectral Filter Width (nm)');
ylabel('Secure Key Rate per Pass (Bits)');
hold off

%% hmmm...
[skr, QBER] = EvaluateQKDLink(BB84_P, BB84_S, BB84_D, 
                            BB84_Pass.Link_Loss_dB, Background_Count_Rate)
