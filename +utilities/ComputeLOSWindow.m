function angle = computeLOSWindow(H, Elevation_Limit)
    %% computeLosWindow
    % compute the angular distance (coordinate change) which a 
    % ground station can communicate with at a given altitude
    %
    % Syntax:
    % angle = computeLosWindow(H, Elevation_Limit)
    %
    % Inputs:
    % H - altitude above Earth's surface [km]
    % Elevation_Limit - minimum elevation angle [degrees]
    %
    % Output:
    % angle - angular window [radians]

    R = earthRadius;
    v = cosd(Elevation_Limit);
    b = R ./ (R + H);

    angle = acos(v.^2 .* b + sqrt((v.^4) .* (b.^2) - (v.^2) .* (b.^2 + 1) + 1));
end