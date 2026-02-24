function [latOut, longOut] = moveAlongSurface(latIn, longIn, arc, heading)
    %% moveAlongSurface
    % move by an arc angle (arcdistance over sphere radius) at a
    % given heading on the surface of a sphere using geographical coords
    %
    % Syntax:
    % [latOut, longOut] = moveAlongSurface(latIn, longIn, arc, heading)

    %% input validation
    if numel(arc) > 1 || numel(latIn) > 1 || numel(longIn) > 1
        error('this function must be used for a single arc angle and input lat,lon pair at a time');
    end

    % check for arc = 180. this produces heading-independent results
    if abs(arc) == pi
        latOut = -latIn * ones(size(heading));
        longOut = (longIn - 180) * ones(size(heading));
    else
        % convert arcdistance to degrees
        arcDeg = arc * 180 / pi;

        % initial computation
        latOut = latIn + arcDeg * cosd(heading);

        % do all computations
        longOut = longIn + tand(heading) * (180 / pi) * ...
            (atanh(sind(latIn + arcDeg * cosd(heading))) - atanh(sind(latIn)));

        % then redo those with heading = +-90 to remove inf results
        if any(abs(heading) == 90)
            longOut(abs(heading) == 90) = longIn + ...
                sign(heading(abs(heading) == 90)) .* arcDeg ./ cosd(latIn);
        end

        % if latitude is +-90, longitude is poorly defined
        longOut(abs(latOut) == 90) = 0;
    end

    %% check for out of range values
    % latitude range
    % bound into +-360
    latOut(latOut >= 360) = latOut(latOut >= 360) - 360;
    latOut(latOut <= -360) = latOut(latOut <= -360) + 360;

    % bound into +-90
    longOut(abs(latOut) > 90) = longOut(abs(latOut) > 90) - 180;
    latOut(abs(latOut) > 90) = 180 - latOut(abs(latOut) > 90);

    % longitude range
    % bound to +-180
    longOut(longOut > 180) = longOut(longOut > 180) - 360;
    longOut(longOut < -180) = longOut(longOut < -180) + 360;
end