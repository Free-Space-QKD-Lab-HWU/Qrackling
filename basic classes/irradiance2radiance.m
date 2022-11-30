% Author: Peter Barrow

% Convert irradiance values to radiance.
% SMARTS outputs values in irradiance, this is not the most useful unit for us,
% converting to radiance allows us to calculate rates of photons arriving at
% the telescope / detector.
% Usage:
% Irradiance: W / (m^2)
% Wavelengths: 'Units'
% Units: units for wavelengths
% The 'units' argument is needed to perform the correct calculation to spectral
% radiance, for SMARTS data this would be '1e-9'.
%{
function radiance = irradiance2radiance(irradiance, wavelengths, units)
    wavelengths = wavelengths .* units;
    radiance = irradiance ./ wavelengths ./ (4 * pi);
end
%}


%% is this correct? should we be dividing by wavelength or by wavelength interval?

% i would go with
%radiance = power / {(solid angle)*(area)}
%irradiance = power / {area}
%so radiance  = irradiance/{solid angle}

%presumably, the exposed surface solid angle is a hemisphere, so 2pi steradians

%so...
function radiance = irradiance2radiance(irradiance, wavelengths, units)
    %wavelengths = wavelengths .* units;
    radiance = irradiance ./(2 * pi);
end