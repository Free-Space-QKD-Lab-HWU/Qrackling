%%test input
clear all
clc
%
% Matlab script to recreate the default the config file for SMARTS, the ...
%     "smarts295.inp.txt" file bundled with the software
%
% 'Example_6:USSA_AOD=0.084'		  !Card 1 Comment
% 1			!Card 2 ISPR
% 1013.25 0. 0.		!Card 2a Pressure, altitude, height
% 1			!Card 3 IATMOS
% 'USSA'			!Card 3a Atmos
% 1			!Card 4 IH2O
% 1			!Card 5 IO3
% 1			!Card 6 IGAS
% 370.0			!Card 7 CO2 amount (ppm)
% 1			!Card 7a ISPCTR
% 'S&F_RURAL'		!Card 8 Aeros (aerosol model)
% 0			!Card 9 ITURB
% 0.084			!Card 9a Turbidity coeff. (TAU5)
% 38			!Card 10 IALBDX
% 1			!Card 10b ITILT
% 38 37. 180.			!Card 10c Tilt variables (IALBDG, receiver's tilt & azimuth)
% 280 4000 1.0 1367.0		!Card 11 Min & max wavelengths; sun-earth distance correction; solar constant
% 2			!Card 12 IPRT
% 280 4000 .5		!Card12a Min & max wavelengths to be printed; ideal printing step size
% 4			!Card12b Number of Variables to Print
% 8 9 10 30			!Card12c Variable codes
% 1			!Card 13 ICIRC
% 0 2.9 0			!Card 13a Receiver geometry (3 angles)
% 0			!Card 14 ISCAN
% 0			!Card 15 ILLUM
% 0			!Card 16 IUV
% 2			!Card 17 IMASS
% 1.5			!Card 17a Air mass

ispr = sitePressure(spr=1013.25, altit=0, height=0);
iatmos = atmosphere(atmos='USSA');
ih20 = water_vapour(w=1);
i03 = ozone();
igas = gas_atmospheric_absorption(iload=0); 
ico2 = carbon_dioxide(amount=370);
iaeros = aerosol(aeros='S&F_RURAL');
iturb = turbidity(TAU5=0.084);
ialbdx = far_field_albedo(spectral_reflectance=38, tilt=37, wazim=180, ialbdg=38);
isolar = extra_spectral(wlmin=280, wlmax=4000, suncor=1, solarc=1367);
iprt = printing(output_options=[8, 9, 10, 30], wpmn=280, wpmx=4000, intvl=0.5);
icirc = circum_solar(slope=0, apert=2.9, limit=0);
iscan = scanning(filtering=0);
illum = illuminance(value=0);
iuv =  broadband_uv(value=0);
imass = solar_position_and_airmass(amass=1.5);

inputs = {ispr, iatmos, ih20, i03, igas, ico2, iaeros, iturb, ialbdx, ...
          isolar, iprt, icirc, iscan, illum, iuv, imass};

smarts_path = '/home/bp38/Downloads/smarts-295-linux-tar/SMARTS_295_Linux/';
s = SMARTS_input(comment='this is a test', args=inputs, executable_path=smarts_path);
[s, success, destination] = s.run_smarts();
assert(success, 'Something failed...');
%disp(s.input_string);

into_path = @(arraylike, i, j) subsref(...
                                  strsplit(arraylike, '/'), ...
                                  struct('type', ...
                                         '()', ...
                                         'subs', ...
                                  {{i:j }} ) );

directory_of = @(path) join(into_path(path, 2, sum(path == '/')), '/'), 1;

test = directory_of(destination);


test = strrep(destination, 'inp', 'ext');
test

data = s.read_file();
