function [headings, elevations] = headingAndElevation(R)
    %% headingAndElevation
    % compute the heading and elevation in degrees of a nx3 vector r with x,y,z components as row elements
    %
    % Syntax:
    % [headings, elevations] = headingAndElevation(R)
    %
    % Description:
    % Computes azimuthal heading and elevation angle from Cartesian vectors.
    % Heading is measured clockwise from north (Y-axis), elevation from horizontal plane.

    %% input validation
    if ~isnumeric(R)
        error('input to headingAndElevation must be numeric');
    end

    sz = size(R);
    if sz(2) ~= 3
        error('input to headingAndElevation must be a n by 3 array');
    end

    %% separate columns
    Xs = R(:,1);
    Ys = R(:,2);
    Zs = R(:,3);

    %% compute Headings and Elevations
    headings = atan2d(Xs, Ys);
    elevations = atan2d(Zs, vecnorm([Xs,Ys],2,2));

    % keep heading positive between 0 and 360
    headings_too_low = headings < 0;
    headings(headings_too_low) = headings(headings_too_low) + 360;
end