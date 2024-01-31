function [heading_PAA,elevation_PAA] = PointAheadAngle(Receiver,Transmitter)
    %function returns a 2xn vector of angles in radians representing the point
    %ahead angle of a beacon from transmitter to receiver. The first row is in
    %the heading axis, the second row is in the elevation axis. These two axes
    %are related to the ENU (East-North-Up) frame of reference at the
    %transmitter
    arguments
        Receiver {mustBeA(Receiver, ["nodes.Satellite", "nodes.Ground_Station"])}
        Transmitter {mustBeA(Transmitter, ["nodes.Satellite", "nodes.Ground_Station"])}
    end

    %% get basic information
    direction = nodes.LinkDirection.DetermineLinkDirection(Receiver,Transmitter);
    switch direction
    case nodes.LinkDirection.Downlink
        Times = Transmitter.Times;
    case nodes.LinkDirection.Uplink
        Times = Receiver.Times;
    case nodes.LinkDirection.Intersatellite
        Times = Transmitter.Times;
    case nodes.LinkDirection.Terrestrial
        %FIX: warn and return nan?
        error("UNIMPLEMENTED")
    end

%heading and elevation of receiver relative to transmitter
[headings, elevations] = RelativeHeadingAndElevation(Receiver,Transmitter);
%position of receiver relative to transmitter in m east-north-up (evolves
%with time)
ENUs = ComputeRelativeCoords(Transmitter,Receiver)';

    c = 2.998E8;

    % compute relative velocities (in ENU frame)
    relative_velocities(1,:) = (ENUs(1,1:end-1)-ENUs(1,2:end))./seconds(Times(1:end-1)-Times(2:end));
    relative_velocities(2,:) = (ENUs(2,1:end-1)-ENUs(2,2:end))./seconds(Times(1:end-1)-Times(2:end));
    relative_velocities(3,:) = (ENUs(3,1:end-1)-ENUs(3,2:end))./seconds(Times(1:end-1)-Times(2:end));
    %need to pad this calculation to be same size array
    relative_velocities = [relative_velocities,relative_velocities(:,end)];

%% compute PAA
%heading
heading_PAA = (2/c) * (relative_velocities(1,:).*cosd(headings)./cosd(elevations) + ...
                        -relative_velocities(2,:).*sind(headings)./cosd(elevations));

    elevation_PAA = (2/c) * (relative_velocities(1,:).*sind(headings).*sind(elevations) + ...
                             relative_velocities(2,:).*cosd(headings).*sind(elevations) + ...
                             relative_velocities(2,:).*sind(elevations));
end
