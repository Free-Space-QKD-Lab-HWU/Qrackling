function [turbulence_loss,turbulent_beam_width,r0] = TurbulenceLoss(kind, receiver, transmitter, direction, turbulence_model, options)
    arguments
        kind (1,1) {mustBeMember(kind, ["beacon", "qkd"])}
        receiver (1,1) {utilities.mustBeSubclassOf(receiver,'nodes.Located_Object')}
        transmitter (1,1) {utilities.mustBeSubclassOf(transmitter,'nodes.Located_Object')}
        direction (1,1) nodes.LinkDirection
        turbulence_model (1,1) environment.Turbulence_Model = environment.Turbulence_Model("Preset","HV5-7");
        options.SpotSize = []
    end

    % wavelength must come from a source, this will be in nm
    % wavelength = units.Magnitude.Convert("nano", "none", transmitter.source.Wavelength);
    switch kind
    case "beacon"
        if isempty(transmitter.Beacon)
            error(['Transmitter.Beacon of ', inputname(1), ' must not be empty'])
        end

        if isempty(receiver.Camera)
            error(['Receiver.Camera of ', inputname(2), ' must not be empty'])
        end

        wavelength = transmitter.Beacon.Wavelength;
    case "qkd"
        wavelength = transmitter.Source.Wavelength;
    end

    if contains(fieldnames(options), 'Elevations')
        error('UNIMPLEMENTED: we should be able to pass elevations in, currently we have to determine which of the inputs is the satellite and which is the ground station.');
    end

    %% compute link geometry
    [~, elevation, length] = RelativeHeadingAndElevation(transmitter,receiver);

    %also need to work out start and end altitudes
    switch direction
        case "Downlink"
            BottomHeight = receiver.Altitude;
            TopHeight = transmitter.Altitude;
        case "Uplink"
            TopHeight = receiver.Altitude;
            BottomHeight = transmitter.Altitude;
            %if this is an uplink, elevation will be negative, but for turbulence
            %calculations we want positive elevation
            elevation = elevation+180;
    end

    %% compute what times need calculating for
    %we only need to calculate turbulence loss for links which have line of
    %sight, i.e have elevation>0
    elevation_flags = elevation > 0;


    %% calculate turbulence beam spreading

    %first, we need the initial spot size of the link, before turbulence
    %effects
    geometric_spot_size = options.SpotSize;
    if isempty(options.SpotSize)
        [~,geometric_spot_size] = nodes.GeometricLoss(kind,receiver,transmitter,"LinkLength",length(elevation_flags));
    elseif isequal(size(geometric_spot_size),size(length))
        %might also need to cut geometric_spot_size down to correct length
        geometric_spot_size = geometric_spot_size(elevation_flags);
    end

    %then we can calculate the beam width after turbulence
    [turbulent_beam_width,r0] = BeamSpread(turbulence_model,...
                direction,...
                wavelength,...
                elevation(elevation_flags),...
                length(elevation_flags),...
                geometric_spot_size,...
                'BottomHeight',BottomHeight,...
                'TopHeight',TopHeight);


     %% calculate loss using turbulent beam width
     turbulence_loss = zeros(size(elevation_flags));
     turbulence_loss(elevation_flags) = (geometric_spot_size ./ turbulent_beam_width).^2;
     %convert to loss object
     turbulence_loss = units.Loss('probability','Turbulence',turbulence_loss);
end
