function loss = AtmosphericLoss(receiver, transmitter, options)
    % Calculate the amount of loss contribution from the atmosphere between the
    % transmitter and receiver
    arguments
        receiver {mustBeA(receiver, ["nodes.Satellite", "nodes.Ground_Station"])}
        transmitter {mustBeA(transmitter, ["nodes.Satellite", "nodes.Ground_Station"])}
        % FIX: should be an array of visibilities, this is current form due to
        % the specifics of the 'Atmosphere_Spectral_Filter' class
        options.Visibility {mustBeText} = '50km'
    end


    % When we look at the original Satellite_Link_Model.m we can see that 
    % regardless of whether we are working with a downlink or uplink model the
    % elevations that we want to capture are always produced with:
    %   RelativeHeadingAndElevation(Satellite, Ground_Station);
    switch class(transmitter)
    case "nodes.Satellite"
        [~, elevations, ~] = transmitter.RelativeHeadingAndElevation(receiver);
    case "nodes.Ground_Station"
        [~, elevations, ~] = receiver.RelativeHeadingAndElevation(transmitter);
    end


    % FIX: 'Atmosphere_Spectral_Filter.m' needs replacing
    atmosphere_spectral_filter = Atmosphere_Spectral_Filter( ...
        elevations, transmitter.Source.Wavelength, {options.Visibility});

    loss = atmosphere_spectral_filter.ComputeTransmission( ...
        transmitter.Source.Wavelength);

    n = max(receiver.N_Position, transmitter.N_Position);
    loss = utilities.validateLoss(loss, n);
end
