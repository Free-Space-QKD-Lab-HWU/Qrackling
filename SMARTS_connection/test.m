%%run tests
test = sitePressure('spr', 1000);
test.cardString()

test = sitePressure('spr', 1000, 'altit', 10, 'height', 30);
test.cardString()

test = atmosphere('atmos', 'USSA');
test.cardString()

test = atmosphere(tair=20, rh=10, season='spring', tday=25);
test.cardString()

test = water_vapour();
test.cardString()

test = water_vapour(w=3);
test.cardString()

test = ozone();
test.cardString()

test = ozone(ialt=1, abO3=1);
test.cardString()

test = gas_atmospheric_absorption();
test.cardString()

test = gas_atmospheric_absorption(iload=2);
test.cardString()

test = gas_atmospheric_absorption(...
            'iload', 0, ...
            'ApCH2O', 1, ...
            'ApCH4', 1, ...
            'ApCO', 1, ...
            'ApHNO2', 1, ...
            'ApHNO3', 1, ...
            'ApNO', 1, ...
            'ApNO2', 1, ...
            'ApNO3', 1, ...
            'ApO3', 1, ...
            'ApSO2', 1);
test.cardString()

test = carbon_dioxide();
test.cardString()

test = aerosol(aeros='S&F_RURAL');
test.cardString()

test = aerosol(alpha1=0, alpha2=0, omegl=0.5, gg=0.5);
test.cardString()

test = turbidity(TAU5=1);
test.cardString()

test = turbidity(TAU550=1);
test.cardString()

% %% far field albedo
% clear all
% clc
% disp(newline);

test = far_field_albedo(spectral_reflectance=4);
test.cardString()

test = far_field_albedo(spectral_reflectance=-1, rhox=2);
test.cardString()

% test = far_field_albedo(spectral_reflectance=-1, rhox=2, tilt=37);
% % test.cardString()
% test.suffix{test.flag}

test = far_field_albedo(spectral_reflectance=-1, rhox=2, tilt=37, wazim=0, ialbdg=4);
test.cardString()

test = far_field_albedo(spectral_reflectance=4, ialbdg=4, ...
                        tilt=37, wazim=180);
test.cardString()

test = far_field_albedo(spectral_reflectance=4, ialbdg=-1, ...
                        tilt=37, wazim=180, rhog=1);
test.cardString()

% %% ...

test = extra_spectral();
test.cardString()

% test = printing();
% test.show_options()
% test

test = circum_solar();
test.cardString()

test = circum_solar(slope=1, apert=2, limit=3);
test.cardString()

test = scanning();
test.cardString()

test = scanning(filtering=1, wavelength_min=280, wavelength_max=4000, ...
                step=2, fwhm=100);
test.cardString()

test = illuminance(value=1);
test.cardString()

test = broadband_uv();
test.cardString()

test = broadband_uv(value=1);
test.cardString()

%test = solar_position_and_airmass(...
%            zenith=1, ...
%            azimuth=2, ...
%            elevation=3, ...
%            amass=4, ...
%            dateAndTime=datetime('now'), ...
%            latitude=5, ...
%            longitude=6, ...
%            dstep=7 ...
%    );

test = solar_position_and_airmass(zenith=1, azimuth=2);
test.cardString()

test = solar_position_and_airmass(azimuth=2, elevation=3);
test.cardString()

test = solar_position_and_airmass(amass=4);
test.cardString()

test = solar_position_and_airmass(dateAndTime=datetime('now'), latitude=5, ...
                                    longitude=6);
test.cardString()

test = solar_position_and_airmass(...
            dateAndTime=datetime('now'), latitude=5, dstep=7);
test.cardString()

