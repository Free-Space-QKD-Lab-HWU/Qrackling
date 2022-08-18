% calcuate the amount of point ahead angle needed for both the elevation and 
% azimuthal angles for a given time and slant range (link distance)

function [a, b] = alpha_beta(az, el, dist, timeStamps)
    c = 3e8;
    N = numel(timeStamps);
    dt = seconds(timeStamps(2 : N) - timeStamps(1 : N-1));

    a = ((2 .* (az(2:N) - az(1:N-1))) .* dist(1:N-1)) ./ (c * dt);
    b = ((2 .* (el(2:N) - el(1:N-1))) .* dist(1:N-1)) ./ (c * dt);
end
