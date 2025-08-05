% beaconSimulation(Receiver, Transmitter, options)
%
% simulate a beacon link from transmitter to receiver

function result = beaconSimulation(transmitter, receiver, options)
    arguments
        transmitter {utilities.mustBeSubclassOf(transmitter,'nodes.Free_Space_Optical_Node')}
        receiver {utilities.mustBeSubclassOf(receiver,'nodes.Free_Space_Optical_Node')}        
        options.Environment environment.Environment
    end

    %% determine link geometry
    receiver_location = nodes.Located_Object();
    transmitter_location = nodes.Located_Object();
    direction = nodes.LinkDirection.DetermineLinkDirection(receiver, transmitter);

    switch direction
    case nodes.LinkDirection.Downlink
        [headings, elevations, ranges] = transmitter.RelativeHeadingAndElevation(receiver);
        elevation_limit_mask = elevations > receiver.Elevation_Limit;
        times = transmitter.Times;

        receiver_location = receiver_location.SetPosition( ...
           'Latitude', receiver.Latitude, ...
           'Longitude', receiver.Longitude, ...
           'Altitude', receiver.Altitude);

        transmitter_location = transmitter_location.SetPosition( ...
           'Latitude', transmitter.Latitude, ...
           'Longitude', transmitter.Longitude, ...
           'Altitude', transmitter.Altitude);

    case nodes.LinkDirection.Uplink
        [headings, elevations, ranges] = receiver.RelativeHeadingAndElevation(transmitter);
        elevation_limit_mask = elevations > transmitter.Elevation_Limit;
        times = receiver.Times;

        receiver_location = receiver_location.SetPosition( ...
           'Latitude', receiver.Latitude, ...
           'Longitude', receiver.Longitude, ...
           'Altitude', receiver.Altitude);

        transmitter_location = transmitter_location.SetPosition( ...
           'Latitude', transmitter.Latitude, ...
           'Longitude', transmitter.Longitude, ...
           'Altitude', transmitter.Altitude);

    case nodes.LinkDirection.Intersatellite
        error("UNIMPLEMENTED")

    case nodes.LinkDirection.Terrestrial
        error("UNIMPLEMENTED")
    
    otherwise
        error('unrecognised LinkDirection case')
    end
    line_of_sight_mask = elevations > 0;


    %% perform link modelling    
    if isempty(transmitter.Beacon)
        error(['Transmitter.Beacon of ', inputname(1), ' must not be empty'])
    end

    if isempty(receiver.Camera)
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
    received_power = transmitter.Beacon.Power .* link_loss.TotalLoss;

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
        background_power = background_radiance * (receiver.Camera.FOV)^2 * receiver.Camera.Collecting_Area * receiver.Camera.Spectral_Filter_Width;
        [snr, snr_db] = SNR(receiver.Camera, received_power, background_power);

     else
        [snr, snr_db] = SNR(receiver.Camera, received_power);
    end


    %% compute PAA
    [heading_PAA, elevation_PAA] = beacon.PointAheadAngle(receiver,transmitter);
    PAA = [heading_PAA; elevation_PAA];
    %% record result
    result = beacon.BeaconResult(...
        utilities.node_name(transmitter),...
        utilities.node_name(receiver),...
        headings,...
        elevations,...
        ranges,...
        times,...
        elevation_limit_mask,...
        line_of_sight_mask,...
        link_loss, ...
        link_loss.TotalLoss.dB, ...
        received_power,...
        snr,...
        snr_db,...
        direction,...
        background_power,...
        PAA);

end
