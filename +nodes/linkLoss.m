function [losses, extras] = linkLoss(kind, receiver, transmitter, options)
% linkLoss
%
% Compute cumulative link loss between a transmitter and receiver for
% a specified signal type and set of physical loss mechanisms.
%
% Syntax:
% [losses, extras] = linkLoss(kind, receiver, transmitter, loss, options)
%
% Inputs:
% kind        - string, either "beacon" or "qkd"
% receiver    - nodes.Satellite or nodes.GroundStation object
% transmitter - nodes.Satellite or nodes.GroundStation object
% loss        - cell array of strings specifying loss types to include
% options     - struct with optional fields:
%               .dB         - logical, whether to return loss in dB
%               .SpotSize   - numeric, optional beam spot size
%               .LinkLength - numeric, optional link length
%
% Outputs:
% losses - nodes.LossResult object containing cumulative losses
% extras - struct with additional outputs (e.g., beam width, r0)

    arguments
        kind {mustBeMember(kind, ["beacon", "qkd"])}
        receiver {mustBeA(receiver, ["nodes.Satellite", "nodes.GroundStation"])}
        transmitter {mustBeA(transmitter, ["nodes.Satellite", "nodes.GroundStation"])}

        %the various different kinds of simulatable losses
        options.geometric (1,1) logical = true
        options.turbulence (1,1) logical = true
        options.apt (1,1) logical = true
        options.atmospheric (1,1) logical = true
        options.detection_efficiency (1,1) logical = true
        options.source_efficiency (1,1) logical = true
        options.transmitter_telescope_efficiency (1,1) logical = true
        options.receiver_telescope_efficiency (1,1) logical = true
        options.jitter (1,1) logical = true
        options.filter_efficiency (1,1) logical = true
        options.camera_efficiency (1,1) logical = true
        options.beacon_efficiency (1,1) logical = true

        % do you want the output in dB?
        options.dB (1,1) logical = false
    end


    %% Geometric loss
    if options.geometric
        [res, spot_size, ~] = nodes.geometricLoss(kind, receiver, transmitter);
        losses = nodes.LossResult('qkd', units.Loss(res, 'geometric'));
    end

    %% Turbulence loss
    if options.turbulence
        switch class(receiver)
            case "nodes.GroundStation"
                direction = nodes.LinkDirection.Downlink;
            case "nodes.Satellite"
                direction = nodes.LinkDirection.Uplink;
        end

        [res, beam_width, r0] = nodes.turbulenceLoss(kind, ...
            receiver, transmitter, direction, "SpotSize", spot_size);

        losses = losses.addLoss(units.Loss(res, 'turbulence'));
    else
        beam_width = spot_size;
        r0 = 0;
    end

    %% Acquisition, pointing, and tracking loss
    if options.apt
        res = nodes.aptLoss(kind, receiver, transmitter);
        losses = losses.addLoss(units.Loss(res, 'apt'));
    end

    %% Atmospheric loss
    if options.atmospheric
        res = nodes.atmosphericLoss(kind, receiver, transmitter, direction);
        losses = losses.addLoss(units.Loss(res, 'atmospheric'));
    end

    %% Transmitter telescope efficiency
    if options.transmitter_telescope_efficiency
        res = transmitter.telescope.optical_efficiency;
        losses = losses.addLoss(units.Loss(res,'transmitter telescope efficiency'));
    end

    %% Receiver telescope efficiency
    if options.receiver_telescope_efficiency
        res = receiver.telescope.optical_efficiency;
        losses = losses.addLoss(units.Loss(res,'receiver telescope efficiency'));
    end

    %% these losses are for QKD links only
    if kind == "qkd"
        %% Detection efficiency
        if options.detection_efficiency
            res = receiver.detector.detection_efficiency;
            losses = losses.addLoss(units.Loss(res,'detection efficiency'));
        end

        %% Source efficiency
        if options.source_efficiency
            res = transmitter.source.efficiency;
            losses = losses.addLoss(units.Loss(res,'source efficiency'));
        end

        %% Timing Jitter
        if options.jitter
            res = receiver.detector.jitter_loss;
            losses = losses.addLoss(units.Loss(res,'jitter'));
        end

        %% Filter efficiency
        if options.filter_efficiency
            shifted_wavelength = nodes.dopplerShift(receiver, transmitter);
            res = receiver.detector.spectral_filter.computeTransmission(shifted_wavelength)';
            losses = losses.addLoss(units.Loss(res,'filter efficency'));
        end
    end

    %% these losses are for beacon links only
    if kind == "beacon"
        %% camera efficiency
        if options.camera_efficiency
            res = receiver.camera.quantum_efficiency;
            losses = losses.addLoss(units.Loss(res,'camera efficiency'));
        end

        %% beacon efficiency
        if options.beacon_efficiency
            res = transmitter.beacon.power_efficiency;
            losses = losses.addLoss(units.Loss(res,'beacon efficiency'));
        end
    end


    %% Package extras
    extras = struct();
    extras.turbulent_beam_width = beam_width;
    extras.r0 = r0;
    extras.total_loss = losses.totalLoss;
end