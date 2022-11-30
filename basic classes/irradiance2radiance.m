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

function radiance = irradiance2radiance(irradiance, wavelengths, units)
    wavelengths = wavelengths .* units;
    %radiance = irradiance ./ wavelengths ./ (4 * pi);
    % typically conversion to steradians requires a factor of (4 pi) for a
    % full sphere, however in our case we are working in terms of a hemisphere
    % so require only (2*pi)
    radiance = irradiance ./ wavelengths ./ (2 * pi);
end
