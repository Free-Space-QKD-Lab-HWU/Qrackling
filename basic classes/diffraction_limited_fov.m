function fov = diffraction_limited_fov(wavelength, rx_diameter)
    fov = pi * ((1.22 * wavelength) / rx_diameter)^2;
end
