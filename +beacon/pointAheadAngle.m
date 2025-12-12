% pointAheadAngle
%
% Returns a 2×n vector of angles in radians representing the point-ahead
% angle of a beacon from transmitter to receiver. The first row is heading,
% the second row is elevation. These axes are defined in the ENU (East-North-Up)
% frame of reference at the transmitter.
%
% Syntax:
% [heading_paa, elevation_paa] = namespace.object.pointAheadAngle(receiver, transmitter)
%
% Inputs:
% receiver - (1x1) object, must be a Free_Space_Optical_Node subclass.
% transmitter - (1x1) object, must be a Free_Space_Optical_Node subclass.
%
% Outputs:
% heading_paa – (1xn) double, heading component of point-ahead angle.
% elevation_paa – (1xn) double, elevation component of point-ahead angle.

function [heading_paa, elevation_paa] = pointAheadAngle(receiver, transmitter)

    arguments
        receiver {utilities.mustBeSubclassOf(receiver, 'nodes.FreeSpaceOpticalNode')}
        transmitter {utilities.mustBeSubclassOf(transmitter, 'nodes.FreeSpaceOpticalNode')}
    end


    %% Get basic information

    direction = nodes.LinkDirection.determineLinkDirection(receiver, transmitter);

    switch direction
        case nodes.LinkDirection.Downlink
            times = transmitter.time';
        case nodes.LinkDirection.Uplink
            times = receiver.time';
        case nodes.LinkDirection.Intersatellite
            times = transmitter.time';
        case nodes.LinkDirection.Terrestrial
            error("UNIMPLEMENTED")
    end


    %% Compute relative geometry

    % Heading and elevation of receiver relative to transmitter
    [headings, elevations] = receiver.relativeHeadingAndElevation(transmitter);

    % Position of receiver relative to transmitter in ENU frame (meters)
    enus = transmitter.computeRelativeCoords(receiver)';


    %% Compute relative velocities

    c = 2.998e8;  % Speed of light in m/s

    relative_velocities(1, :) = (enus(1, 1:end-1) - enus(1, 2:end)) ...
        ./ seconds(times(1:end-1) - times(2:end));

    relative_velocities(2, :) = (enus(2, 1:end-1) - enus(2, 2:end)) ...
        ./ seconds(times(1:end-1) - times(2:end));

    relative_velocities(3, :) = (enus(3, 1:end-1) - enus(3, 2:end)) ...
        ./ seconds(times(1:end-1) - times(2:end));

    % Pad to match original array size
    relative_velocities = [relative_velocities, relative_velocities(:, end)];


    %% Compute point-ahead angle

    heading_paa = (2 / c) * ( ...
        relative_velocities(1, :) .* cosd(headings) ./ cosd(elevations) ...
        - relative_velocities(2, :) .* sind(headings) ./ cosd(elevations) );

    elevation_paa = (2 / c) * ( ...
        relative_velocities(1, :) .* sind(headings) .* sind(elevations) ...
        + relative_velocities(2, :) .* cosd(headings) .* sind(elevations) ...
        + relative_velocities(2, :) .* sind(elevations) );

end