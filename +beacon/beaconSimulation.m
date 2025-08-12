% beaconSimulation
%
% Simulate a beacon link from transmitter to receiver.
%
% Syntax:
% result = beaconSimulation(transmitter, receiver, options)
%
% Inputs:
% transmitter - scalar FreeSpaceOpticalNode, the source of the beacon
% receiver - scalar FreeSpaceOpticalNode, the receiver of the beacon
% 
% Outputs:
% result – scalar BeaconResult, object containing simulation results


function result = beaconSimulation(transmitter, receiver, options)
    arguments
        transmitter {utilities.mustBeSubclassOf(transmitter,'nodes.FreeSpaceOpticalNode')}
        receiver {utilities.mustBeSubclassOf(receiver,'nodes.FreeSpaceOpticalNode')}        
        options.Environment environment.Environment
    end

    %% determine link geometry
    direction = nodes.LinkDirection.determineLinkDirection(receiver, transmitter);

    switch direction
    case nodes.LinkDirection.Downlink
        [headings, elevations, ranges] = transmitter.relativeHeadingAndElevation(receiver);
        elevation_limit_mask = elevations > receiver.elevation_limit;
        times = transmitter.times;

    case nodes.LinkDirection.Uplink
        [headings, elevations, ranges] = receiver.relativeHeadingAndElevation(transmitter);
        elevation_limit_mask = elevations > transmitter.elevation_limit;
        times = receiver.times;

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

    has_env = contains(fieldnames(options), "Environment");

    if has_env
        [link_loss, ~] = nodes.linkLoss( ...
            "beacon", receiver, transmitter, ...
            "apt", "optical", "geometric", "turbulence", "atmospheric", ...
            dB=true, ...
            environment=options.Environment);
    else
        [link_loss, ~] = nodes.linkLoss( ...
            "beacon", receiver, transmitter, ...
            "apt", "optical", "geometric", "turbulence", ...
            dB=true);
    end
    received_power = transmitter.beacon.power .* link_loss.totalLoss;

    %% compute SNR
    background_power = [];

    %only use environment for background if camera is on the ground
    Camera_In_Environment = ...
        (direction == direction == nodes.LinkDirection.Downlink) ...
        || (direction == direction==nodes.LinkDirection.Terrestrial);

    if Camera_In_Environment&&has_env
        % NOTE: why does this need "abs" around headings and elevations?
        % NOTE: SOLVED: add in mask by elevation limit (or other equivalent)
        % NOTE: mask by elevation >= 0
        background_radiance = options.Environment.Interp( ...
            "spectral_radiance", abs(headings), abs(elevations), ...
            transmitter.Beacon.Wavelength);
        background_power = background_radiance * (receiver.camera.fov)^2 * receiver.camera.collecting_area * receiver.camera.spectral_filter_width;
        [snr, snr_db] = SNR(receiver.camera, received_power, background_power);

     else
        [snr, snr_db] = receiver.camera.snr(received_power);
    end


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
        snr,...
        PAA);

end
