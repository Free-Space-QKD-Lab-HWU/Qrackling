    function result = beaconSimulation( Receiver,Transmitter)
        arguments
            Receiver {mustBeA(Receiver, ["nodes.Satellite", "nodes.Ground_Station"])}
            Transmitter {mustBeA(Transmitter, ["nodes.Satellite", "nodes.Ground_Station"])}
        end
        

        %% determine link geometry
        direction = nodes.LinkDirection.DetermineLinkDirection(Receiver, Transmitter);
        switch direction
        case nodes.LinkDirection.Downlink
            [headings, elevations, ranges] = Transmitter.RelativeHeadingAndElevation(Receiver);
            elevation_limit_mask = elevations > Receiver.Elevation_Limit;
            times = Transmitter.Times;
    
            receiver_location = nodes.Located_Object();
            receiver_location = receiver_location.SetPosition( ...
               'Latitude', Receiver.Latitude, ...
               'Longitude', Receiver.Longitude, ...
               'Altitude', Receiver.Altitude);
    
            transmitter_location = nodes.Located_Object();
            transmitter_location = transmitter_location.SetPosition( ...
               'Latitude', Transmitter.Latitude, ...
               'Longitude', Transmitter.Longitude, ...
               'Altitude', Transmitter.Altitude);
    
        case nodes.LinkDirection.Uplink
            [headings, elevations, ranges] = Receiver.RelativeHeadingAndElevation(Transmitter);
            elevation_limit_mask = elevations > Transmitter.Elevation_Limit;
            times = Receiver.Times;
    
            receiver_location = nodes.Located_Object();
            receiver_location = receiver_location.SetPosition( ...
               'Latitude', Receiver.Latitude, ...
               'Longitude', Receiver.Longitude, ...
               'Altitude', Receiver.Altitude);
    
            transmitter_location = nodes.Located_Object();
            transmitter_location = transmitter_location.SetPosition( ...
               'Latitude', Transmitter.Latitude, ...
               'Longitude', Transmitter.Longitude, ...
               'Altitude', Transmitter.Altitude);
    
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
    
        [link_loss, link_extras] = nodes.linkLoss("beacon", Receiver, Transmitter, ...
            "apt", "optical", "geometric", "turbulence", "atmospheric", dB=true);
    
        received_power = Transmitter.Beacon.Power .* link_loss.TotalLoss("probability").values;
    
        %% compute SNR
        background_power = [];
    
        has_atm_file = any(contains(properties(Receiver), "Atmosphere_File_Location"));
        has_atm = false;
        if has_atm_file
            has_atm = ~isempty(Receiver.Atmosphere_File_Location);
        end
    
        if has_atm
        %computed beacon channel noise
            sky_radiance = interp1( ...
                Receiver.Wavelengths, ...
                Receiver.Sky_Radiance', ...
                Transmitter.Beacon.Wavelength);
            background_power = sky_radiance * Receiver.Camera.FOV;
            [snr, snr_db] = SNR(Receiver.Camera, received_power, background_power);
    
        else
            [snr, snr_db] = SNR(Receiver.Camera, received_power);
        end

        %% compute PAA
        [heading_PAA,elevation_PAA] = beacon.PointAheadAngle(Receiver,Transmitter);
        PAA = [heading_PAA;elevation_PAA];
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
            PAA);
    
    end
