function wind = bufton_wind_model(altitude, ...
                                  bufton_wind_model_args)

    ground_wind_speed = bufton_wind_model_args.ground_wind_speed;
    high_altitude_wind_speed = bufton_wind_model_args.high_altitude_wind_speed;
    peak_altitude = bufton_wind_model_args.peak_altitude;
    scale_height = bufton_wind_model_args.scale_height;

    apparent_satellite_ang_vel = satellite_angular_velocity(altitude);

    ratio = ((altitude - peak_altitude) ./ scale_height) .^ 2;
    wind = (ground_wind_speed + (high_altitude_wind_speed ...
            .* exp(-1 * ratio)) + (altitude .* apparent_satellite_ang_vel));
end
