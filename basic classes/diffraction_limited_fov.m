function fov = diffraction_limited_fov(wavelength, rx_diameter)
%%DIFFRACTION_LIMITED_FOV computes the diffraction-limit FOV (rads) of a telescope
%%at a particular wavelength (m) with a given diameter (m)

    fov = pi * ((1.22 * wavelength) / rx_diameter)^2;
end

%% see
%Chunmei Zhang, Alfonso Tello, Ugo Zanforlin, Gerald S. Buller, and Ross J.
%Donaldson "Link loss analysis for a satellite quantum communication down-link",
%Proc. SPIE 11540, Emerging Imaging and Sensing Technologies for Security and Defence V;
%and Advanced Manufacturing Technologies for Micro- and Nanosystems in Security and Defence III,
% 1154007 (20 September 2020); https://doi.org/10.1117/12.2573489