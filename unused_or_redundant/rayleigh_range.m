function rr = rayleigh_range(beam_waist, wavelength, refractive_index)
    rr =  (pi * (beam_waist ^ 2) * refractive_index) / wavelength;
end
