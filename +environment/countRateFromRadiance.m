% Author: Peter Barrow
%
% Ref: Gruneisen, M. T., Eickhoff, M. L., et al. (2021),
% Adaptive-Optics-Enabled Quantum Communication: A Technique for Daytime
% Space-To-Earth Links, 10.1103/PhysRevApplied.16.014067.
%
% Calculate the number of sky photons coupled into the telescope

function counts = countRateFromRadiance(radiance, FOV, receiver_diameter, ...
    filter_width, integration_time, wavelengths, unit)
    arguments
        radiance {mustBeNumeric}
        FOV (1, 1) {mustBeNumeric}
        receiver_diameter (1, 1) {mustBeNumeric}
        filter_width (1, 1) {mustBeNumeric}
        integration_time (1, 1) {mustBeNumeric}
        wavelengths (:, 1) {mustBeNumeric}
        unit units.Magnitude = "nano"
    end

    size_radiance = size(radiance);
    n_wavelengths = numel(wavelengths);

    assert(n_wavelengths == size_radiance[1], ...
        ['Incompatible sizes for radiance and wavelength. ', ...
         'Must be size(radiance) = (A, B) with size(wavelengths) = (1, A)']);

    wavelengths_nm = units.Magnitude.Convert(unit, "none", wavelengths);

    h = 6.62607015*10^-34; % plank's constant
    c = 299792458; % speed of light

    counts = ( ...
        radiance .* FOV .* pi ...
        .* (receiver_diameter ^ 2) ...
        .* wavelengths_nm ...
        .* filter_width ...
        .* integration_time ) ...
        ./ ( 4 * h * c);
end
