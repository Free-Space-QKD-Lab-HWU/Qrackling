% Author: Peter Barrow
%
% Ref: Gruneisen, M. T., Eickhoff, M. L., et al. (2021),
% Adaptive-Optics-Enabled Quantum Communication: A Technique for Daytime
% Space-To-Earth Links, 10.1103/PhysRevApplied.16.014067.
%
% Calculate the number of sky photons coupled into the telescope

function N = sky_photons(radiance, FOV, rx_diameter, wavelength, ...
                         filter_width, integration_time)
    h = 6.62607015*10^-34; % plank's constant
    c = 299792458; % speed of light
    N = ( radiance .* FOV .* pi .* (rx_diameter .^ 2) .* wavelength ...
          .* filter_width .* integration_time ) ./ (4 * h * c);
end
