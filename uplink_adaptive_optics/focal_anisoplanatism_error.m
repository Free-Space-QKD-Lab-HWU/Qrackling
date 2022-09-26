function zeta_fa = focal_anisoplanatism_error(zenith_angles, ...
                                              wavelength, ...
                                              guide_star_altitude, ...
                                              ghv_args, ...
                                              transmitter_diameter)

    fun = @(x) generalised_hufnagel_valley(ghv_args, x) .* ...
                                        ((x ./ guide_star_altitude) .^ (5/3));
    result = integral(@(x) fun(x), 0, guide_star_altitude);
    d = (wavelength ^ (6/5)) .* ((...
        (19.77 .* sec(zenith_angles) .* result)) .^ (-3 / 5));

    zeta_fa = (transmitter_diameter ./ d) .^ (5 / 6);
end
