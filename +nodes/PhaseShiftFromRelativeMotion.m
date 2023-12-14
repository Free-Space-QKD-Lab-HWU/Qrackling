function phi = PhaseShiftFromRelativeMotion(receiver, transmitter)
    arguments
        receiver {mustBeA(receiver, ["nodes.Satellite", "nodes.Ground_Station"])}
        transmitter {mustBeA(transmitter, ["nodes.Satellite", "nodes.Ground_Station"])}
    end

    assert(~isempty(transmitter.Times), ...
        ["transmitter { ", inputname(2), " } does not have any timestamps"]);

    distances = receiver.ComputeDistanceBetween(transmitter);
    times = transmitter.Times;

    c=2.998E8;

    wavelength = transmitter.Source.Wavelength * (1e-9);
    rep_rate = transmitter.Source.Repetition_Rate;

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
