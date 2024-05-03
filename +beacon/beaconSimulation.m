function result = beaconSimulation( Receiver,Transmitter, options)
    arguments
        Receiver {mustBeA(Receiver, ["nodes.Satellite", "nodes.Ground_Station"])}
        Transmitter {mustBeA(Transmitter, ["nodes.Satellite", "nodes.Ground_Station"])}
        options.Environment environment.Environment
        options.startTime (1,1) datetime = datetime(2000,1,1,0,0,0);
        options.stopTime (1,1) datetime = datetime(2000,1,2,0,0,0);
        options.sampleTime (1,1) duration = seconds(1);
    end

    %% if needed, produce a new satelliteScenario
    % create a satellite scenario to simulate the link
    scenario = satelliteScenario(options.startTime,...
                        options.stopTime,...
                        seconds(options.sampleTime));

    %% determine link geometry
    direction = nodes.LinkDirection.DetermineLinkDirection(Receiver, Transmitter);

    switch direction
    case nodes.LinkDirection.Downlink
         [scenario,Transmitter] = AddSimulatorSatellite(Transmitter,scenario);
         [scenario,Receiver] = AddSimulatorOGS(Receiver,scenario);

        [headings, elevations, ranges] = Transmitter.RelativeHeadingAndElevation(Receiver);
        elevation_limit_mask = elevations > Receiver.Elevation_Limit;
        times = Transmitter.Times;

    case nodes.LinkDirection.Uplink
        %add satellite and ground station to scenario
        [scenario,Transmitter] = AddSimulatorOGS(Transmitter,scenario);
        [scenario,Receiver] = AddSimulatorSatellite(Receiver,scenario);
        [headings, elevations, ranges] = Receiver.RelativeHeadingAndElevation(Transmitter);
        elevation_limit_mask = elevations > Transmitter.Elevation_Limit;
        times = Receiver.Times;

    case nodes.LinkDirection.Intersatellite
        %FIX: IMPLEMENT
        error("UNIMPLEMENTED")

    case nodes.LinkDirection.Terrestrial
        %FIX: IMPLEMENT
        error("UNIMPLEMENTED")
    end
    line_of_sight_mask = elevations > 0;

    %% perform link modelling    
    if isempty(Transmitter.Beacon)
        error(['Transmitter.Beacon of ', inputname(1), ' must not be empty'])
    end

    if isempty(Receiver.Camera)
        error(['Receiver.Camera of ', inputname(2), ' must not be empty'])
    end

    has_env = contains(fieldnames(options), "Environment");

    if has_env
        [link_loss, ~] = nodes.linkLoss( ...
            "beacon", Receiver, Transmitter, ...
            "apt", "optical", "geometric", "turbulence", "atmospheric", ...
            dB=true, ...
            environment=options.Environment);
    else
        [link_loss, ~] = nodes.linkLoss( ...
            "beacon", Receiver, Transmitter, ...
            "apt", "optical", "geometric", "turbulence", ...
            dB=true);
    end
    received_power = Transmitter.Beacon.Power .* link_loss.TotalLoss("probability").values;

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
            Transmitter.Beacon.Wavelength);
        background_power = background_radiance * (Receiver.Camera.FOV)^2 * Receiver.Camera.Collecting_Area * Receiver.Camera.Spectral_Filter_Width;
        [snr, snr_db] = SNR(Receiver.Camera, received_power, background_power);

     else
        [snr, snr_db] = SNR(Receiver.Camera, received_power);
    end


    %% compute PAA
    [heading_PAA, elevation_PAA] = beacon.PointAheadAngle(Receiver,Transmitter);
    PAA = [heading_PAA; elevation_PAA];
    %% record result
    result = beacon.BeaconResult(...
        utilities.node_name(Transmitter),...
        utilities.node_name(Receiver),...
        headings,...
        elevations,...
        ranges,...
        times,...
        elevation_limit_mask,...
        line_of_sight_mask,...
        link_loss, ...
        link_loss.TotalLoss("dB"), ...
        received_power,...
        snr,...
        snr_db,...
        direction,...
        background_power,...
        PAA,...
        scenario);

end
