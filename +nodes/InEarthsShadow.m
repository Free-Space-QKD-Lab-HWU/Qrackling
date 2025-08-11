function shadowed = inEarthsShadow(A, B)
% inEarthsShadow
%
% Determine whether the line-of-sight between two located objects passes
% through the Earth.
%
% Syntax:
% shadowed = inEarthsShadow(A, B)
%
% Inputs:
% A - nodes.Located_Object (e.g., satellite or ground station)
% B - nodes.Located_Object
%
% Output:
% shadowed - logical array indicating whether the path is obstructed by Earth

    arguments
        A nodes.Located_Object
        B nodes.Located_Object
    end


    %% Get XYZ positions of both objects
    [x1, y1, z1] = getXyz(A);
    pos_a = [x1, y1, z1];

    [x2, y2, z2] = getXyz(B);
    pos_b = [x2, y2, z2];


    %% Compute minimum radius from Earth's center along the line AB
    dot_product = sum(pos_a .* pos_b, 2);

    lambda_min = (utilities.Row2Norms(pos_a).^2 - dot_product) ...
        ./ (utilities.Row2Norms(pos_a).^2 + utilities.Row2Norms(pos_b).^2 - 2 .* dot_product);

    pos_min = pos_a .* (1 - lambda_min) + pos_b .* lambda_min;


    %% Clamp lambda to endpoints if outside [0, 1]
    if isvector(pos_a)
        pos_min(lambda_min < 0, :) = ones(sum(lambda_min < 0), 1) * pos_a;
    else
        pos_min(lambda_min < 0, :) = pos_a(lambda_min < 0, :);
    end

    if isvector(pos_b)
        pos_min(lambda_min > 1, :) = ones(sum(lambda_min > 1), 1) * pos_b;
    else
        pos_min(lambda_min > 1, :) = pos_b(lambda_min > 1, :);
    end


    %% Determine whether minimum point is inside Earth's radius
    r_min = vecnorm(pos_min,2,2);
    shadowed = r_min < A.earth_radius;
end