function [loss, spot_size, link_length] = geometricLoss(kind, receiver, transmitter, options)
% geometricLoss
%
% Compute geometric loss due to beam divergence and receiver aperture,
% for either beacon or QKD signals between two located nodes.
%
% Syntax:
% [loss, spot_size, link_length] = geometricLoss(kind, receiver, transmitter, options)
%
% Inputs:
% kind        - string, either "beacon" or "qkd"
% receiver    - subclass of nodes.Located_Object
% transmitter - subclass of nodes.Located_Object
% options.LinkLength - optional precomputed link length
%
% Outputs:
% loss        - units.Loss object representing geometric attenuation
% spot_size   - beam spot size at receiver
% link_length - distance between transmitter and receiver

    arguments
        kind {mustBeMember(kind, ["beacon", "qkd"])}
        receiver {utilities.mustBeSubclassOf(receiver, 'nodes.LocatedObject')}
        transmitter {utilities.mustBeSubclassOf(transmitter, 'nodes.LocatedObject')}
        options.LinkLength = []
    end


    %% Determine link length
    link_length = options.LinkLength;
    if isempty(link_length)
        link_length = receiver.computeDistanceBetween(transmitter);
    end


    %% Compute loss and spot size
    switch kind
        case "beacon"
            if isempty(transmitter.beacon)
                error(['transmitter.beacon of ', inputname(1), ' must not be empty']);
            end

            if isempty(receiver.camera)
                error(['receiver.camera of ', inputname(2), ' must not be empty']);
            end

            [loss, spot_size] = transmitter.beacon.geoLoss(link_length, receiver.camera);

        case "qkd"
            spot_size = (ones(size(link_length)) * transmitter.telescope.diameter ...
                + link_length * transmitter.telescope.fov);

            loss = (sqrt(pi) / 8) * (receiver.telescope.diameter ./ spot_size) .^ 2;
            loss = min(loss, 1);  % Ensure loss does not exceed 1
    end


    %% Apply Earth shadow mask
    shadowed = nodes.inEarthsShadow(receiver, transmitter);
    loss(shadowed) = 0;


    %% Format output
    n = max(receiver.n_position, transmitter.n_position);
    loss = units.Loss(loss);
end