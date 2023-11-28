function phi = PhaseShiftFromRelativeMotion(receiver, transmitter)
    arguments
        receiver nodes.FreeSpaceReceiver
        transmitter nodes.FreeSpaceTransmitter
    end

    assert(~isempty(transmitter.timestamps), ...
        ["transmitter { ", inputnames(2), " } does not have any timestamps"]);

    distances = receiver.location.ComputeDistanceBetween(transmitter.location);
    times = transmitter.timestamps;

    c=2.998E8;

    wavelength = transmitter.source.Wavelength;
    rep_rate = transmitter.source.Repetition_Rate;

    % differentiate wrt time
    relative_velocity = ...
        (distances(2:end) - distances(1:end-1)) ...
        ./ seconds(times(2:end) - times(1:end-1));

    %append last result to fill end slot
    relative_velocity = [relative_velocity, relative_velocity(end)];

    %% compute phase shift
    phi = -2 * pi ...
        * ( c/(wavelength * rep_rate) ) ...
        * ( relative_velocity ./ (relative_velocity + c) );
end
