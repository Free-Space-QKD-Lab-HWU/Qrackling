function range = slant_range(altitude, elevation, options)
    arguments
        altitude
        elevation
        options.geo_centre_ground_station = 0
        options.earth_radius = 6378e3
        options.angle_unit = Angle.Radians
    end

    geo_centre_ground_station = ...
        options.geo_centre_ground_station + options.earth_radius;
    orbit_radius = altitude + options.earth_radius;

    elevation_rad = options.angle_unit.ToRadians(elevation);

    rcosz = geo_centre_ground_station .* cos(elevation_rad);

    range = sqrt( ...
        (rcosz .^ 2) ...
        + (orbit_radius .^ 2) ...
        - (geo_centre_ground_station .^ 2)) ...
        - rcosz;
end
