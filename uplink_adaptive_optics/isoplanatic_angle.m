function theta = isoplanatic_angle(zenith_angles, ...
                                   wavenumber, ...
                                   satellite_altitude, ...
                                   ghv_args)
    
    fun = @(x) generalised_hufnagel_valley(ghv_args, x) .* (x .^ (5/3));
    result = integral(@(x) fun(x), 0, satellite_altitude);

    theta = ((2.91 * (wavenumber ^ 2)) .* (...
                sec(zenith_angles) .^ (8/3))...
            .* result) .^ (-3/5);
end
