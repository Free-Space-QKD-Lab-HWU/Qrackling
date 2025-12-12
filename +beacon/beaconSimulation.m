% beaconSimulation
%
% Simulate a beacon link from transmitter to receiver.
%
% Syntax:
% result = beaconSimulation(transmitter, receiver)
%
% Inputs:
% transmitter - scalar FreeSpaceOpticalNode, the source of the beacon
% receiver - scalar FreeSpaceOpticalNode, the receiver of the beacon
%
% Outputs:
% result – scalar BeaconResult, object containing simulation results


function result = beaconSimulation(transmitter, receiver)
arguments
    transmitter {utilities.mustBeSubclassOf(transmitter,'nodes.FreeSpaceOpticalNode')}
    receiver {utilities.mustBeSubclassOf(receiver,'nodes.FreeSpaceOpticalNode')}
end

%% determine link geometry
direction = nodes.LinkDirection.determineLinkDirection(receiver, transmitter);

switch direction
    case nodes.LinkDirection.Downlink
        [headings, elevations, ranges] = transmitter.relativeHeadingAndElevation(receiver);
        elevation_limit_mask = elevations > receiver.elevation_limit;
        times = transmitter.time;
        Environment = receiver.environment;

    case nodes.LinkDirection.Uplink
        [headings, elevations, ranges] = receiver.relativeHeadingAndElevation(transmitter);
        elevation_limit_mask = elevations > transmitter.elevation_limit;
        times = receiver.time;
        Environment = transmitter.environment;

    case nodes.LinkDirection.Intersatellite
        error("UNIMPLEMENTED")

    case nodes.LinkDirection.Terrestrial
        error("UNIMPLEMENTED")

    otherwise
        error('unrecognised LinkDirection case')
end
line_of_sight_mask = elevations > 0;


%% perform link modelling
if isempty(transmitter.beacon)
    error(['Transmitter.Beacon of ', inputname(1), ' must not be empty'])
end

if isempty(receiver.camera)
    error(['Receiver.Camera of ', inputname(2), ' must not be empty'])
end

    [link_loss, ~] = nodes.linkLoss( ...
        "beacon", receiver, transmitter);

received_power = transmitter.beacon.power .* link_loss.totalLoss;

%% compute SNR
background_radiance = Environment.interp( ...
    "spectral_radiance", abs(headings), abs(elevations), ...
    transmitter.beacon.wavelength);
background_power = background_radiance * (receiver.camera.fov)^2 * receiver.camera.collecting_area * receiver.camera.spectral_filter_width;
[signal_noise_ratio, ~] = snr(receiver.camera, received_power, background_power);


%% compute PAA
[heading_PAA, elevation_PAA] = beacon.pointAheadAngle(receiver,transmitter);
PAA = [heading_PAA; elevation_PAA];
%% record result
result = beacon.BeaconResult(...
    transmitter,...
    receiver,...
    direction,...
    headings,...
    elevations,...
    ranges,...
    times,...
    elevation_limit_mask,...
    line_of_sight_mask,...
    link_loss, ...
    link_loss.totalLoss.dB, ...
    background_power,...
    received_power,...
    signal_noise_ratio,...
    PAA);

end
