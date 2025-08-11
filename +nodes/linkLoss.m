function [losses, extras] = linkLoss(kind, receiver, transmitter, loss, options)
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
    end

    arguments (Repeating)
        loss {mustBeMember(loss, {'geometric', 'optical', 'apt', 'turbulence', 'atmospheric'})}
    end

    arguments
        options.dB logical = false
        options.SpotSize = []
        options.LinkLength = []
    end


    %% Initialize
    spot_size = options.SpotSize;
    beam_width = [];
    r0 = [];


    %% Geometric loss
    if any(contains(string(loss), "geometric"))
        [res, spot_size, ~] = nodes.geometricLoss(kind, receiver, transmitter);
        losses = nodes.LossResult('qkd', units.Loss(res, 'geometric'));
    end


    %% Turbulence loss
    if any(contains(string(loss), "turbulence"))
        switch class(receiver)
            case "nodes.GroundStation"
                direction = nodes.LinkDirection.Downlink;
            case "nodes.Satellite"
                direction = nodes.LinkDirection.Uplink;
        end

        [res, beam_width, r0] = nodes.turbulenceLoss(kind, ...
            receiver, transmitter, direction, "SpotSize", spot_size);

        losses = losses.addLoss(units.Loss(res, 'turbulence'));
    end


    %% Optical efficiency loss
    if any(contains(string(loss), "optical"))
        res = nodes.opticalEfficiencyLoss(kind, receiver, transmitter);
        losses = losses.addLoss(units.Loss(res, 'optical'));
    end


    %% Acquisition, pointing, and tracking loss
    if any(contains(string(loss), "apt"))
        res = nodes.aptLoss(kind, receiver, transmitter);
        losses = losses.addLoss(units.Loss(res, 'apt'));
    end


    %% Atmospheric loss
    if any(contains(string(loss), "atmospheric"))
        res = nodes.atmosphericLoss(kind, receiver, transmitter, direction);
        losses = losses.addLoss(units.Loss(res, 'atmospheric'));
    end


    %% Package extras
    extras = struct();
    extras.turbulent_beam_width = beam_width;
    extras.r0 = r0;
    extras.total_loss = losses.total_loss;
end