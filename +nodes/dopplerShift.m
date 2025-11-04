function shifted_wavelength = dopplerShift(receiver, transmitter)
% dopplerShift
%
% Compute the Doppler-shifted wavelength of a signal between a transmitter
% and receiver based on their relative motion and timestamps.
%
% Syntax:
% shifted_wavelength = dopplerShift(receiver, transmitter)
%
% Inputs:
% receiver    - nodes.Satellite or nodes.Ground_Station object
% transmitter - nodes.Satellite or nodes.Ground_Station object
%
% Output:
% shifted_wavelength - numeric array of Doppler-shifted wavelengths

    arguments
        receiver {mustBeA(receiver, ["nodes.Satellite", "nodes.GroundStation"])}
        transmitter {mustBeA(transmitter, ["nodes.Satellite", "nodes.GroundStation"])}
    end


    %% Determine link direction and timestamps
    link_direction = nodes.LinkDirection.determineLinkDirection(receiver, transmitter);

    switch link_direction
        case 'Uplink'
            times = receiver.time';

        case 'Downlink'
            times = transmitter.time';

        case 'Intersatellite'
            times = transmitter.time';

        otherwise
            error('At least one of receiver and transmitter must have time stamps');
    end


    %% Compute relative distances and wavelength
    distances = receiver.computeDistanceBetween(transmitter);
    wavelength = receiver.telescope.wavelength;


    %% Compute Doppler velocity
    doppler_velocity = ...
        (distances(2:end) - distances(1:end-1)) ...
        ./ seconds(times(2:end) - times(1:end-1));

    % Append last value to match array length
    doppler_velocity = [doppler_velocity, doppler_velocity(end)];


    %% Apply Doppler shift
    c = 2.998E8;  % Speed of light in m/s
    shifted_wavelength = (1 + (doppler_velocity / c)) .* wavelength;
end