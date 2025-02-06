function theta_pa = point_ahead_angle(altitude)
    r_e = 6378e3;
    m_e = 5.972e24;
    gravitational_constant = 6.674e-11;
    radius = altitude + r_e;
    velocity = sqrt((gravitational_constant * m_e) ./ radius);
    %velocity = satellite_angular_velocity(altitude);
    theta_pa = 2 .* velocity / (3e8);
end
