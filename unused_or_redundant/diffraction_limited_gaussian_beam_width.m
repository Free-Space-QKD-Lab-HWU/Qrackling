function width = diffraction_limited_gaussian_beam_width(beam_waist, L, ...
                                                         rayleigh_range)
                                                         
    width = sqrt((beam_waist .^ 2) .* (1 + ((L.^2) ./ (rayleigh_range .^ 2))));
end
