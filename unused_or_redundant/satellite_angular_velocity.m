function ang_vel = satellite_angular_velocity(altitude)
    r_e = 6378e3;
    m_e = 5.972e24;
    gravitational_constant = 6.674e-11;
    radius = altitude + r_e;
    %period = 2 .* pi .* sqrt((altitude .^ 3) / (gravitational_constant .* m_e));
    %ang_vel = (2 .* pi) ./ period;
    ang_vel = sqrt((m_e * gravitational_constant) ./ ...
            (radius + (altitude .^ 2)));
end
