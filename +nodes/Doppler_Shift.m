function shifted_wavelength = Doppler_Shift(receiver, transmitter)
    arguments
        receiver nodes.FreeSpaceReceiver
        transmitter nodes.FreeSpaceTransmitter
    end

    assert(~isempty(transmitter.timestamps), ...
        ["transmitter { ", inputnames(2), " } does not have any timestamps"]);

    distances = receiver.location.ComputeDistanceBetween(transmitter.location);
    times = transmitter.timestamps;
    wavelength = receiver.telescope.Wavelength;

    % differentiate wrt time
    doppler_velocity = ...
        (distances(2:end) - distances(1:end-1)) ...
        ./seconds(times(2:end) - times(1:end-1));

    % append last result to fill end slot
    doppler_velocity = [doppler_velocity, doppler_velocity(end)];

    shifted_wavelength = ( 1 + (doppler_velocity / c) ) .* wavelength;

end

