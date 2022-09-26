function range = slant_range(altitude, elevation) 
    geo_centre_ground_station = 0;
    earth_radius = 6378e3;
    geo_centre_ground_station = geo_centre_ground_station + earth_radius;
    orbit_radius = altitude + earth_radius;
    
    elevation_rad = deg2rad(elevation);
    
    %B = earth_radius;
    %orbit_radius = altitude + earth_radius;
    %range = sqrt(((B + cosd(elevation)) .^ 2) + (orbit_radius ^2) ...
    %              - (B ^ 2)) - (B .* cosd(elevation));

    range = ( ...
        sqrt(((geo_centre_ground_station .* cos(elevation_rad)) .^ 2) ...
              + (orbit_radius .^ 2) - (geo_centre_ground_station .^ 2)) ...
        - (geo_centre_ground_station .* cos(elevation_rad)) ...
    );
    % a = 2 * (earth_radius ^ 2);
    % b = 2 * (orbit_radius ^ 2);
    % c = 2 * earth_radius * orbit_radius;
    % el_cos = cos(deg2rad(fliplr(elevation)));

    % d = (elevation .* el_cos) - a + (b .* el_cos);
    % e = c .* ((2 .* el_cos) - 1);
    % Gamma = (2 * pi * c) - acos(d / e);

    % range_sq = (orbit_radius ^ 2) + (earth_radius ^2 ) - (c .* cos(Gamma));
    % range = sqrt(range_sq);
end
