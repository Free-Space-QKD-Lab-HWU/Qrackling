function visibility = Visibility(receiver, transmitter)
% compute visibility of an interferometer when doppler and arrival time
% changes are caused by satellite velocity
    arguments
        receiver {mustBeA(receiver, ["nodes.Satellite", "nodes.Ground_Station"])}
        transmitter {mustBeA(transmitter, ["nodes.Satellite", "nodes.Ground_Station"])}
    end

    differences = ...
        nodes.Doppler_Shift(receiver, transmitter) ...
        - transmitter.Source.Wavelength;

    phase_relative_motion = ...
        nodes.PhaseShiftFromRelativeMotion(receiver, transmitter);

    c = 2.998e8;
    phase_offset = ...
        (2 * pi * differences * c) ...
        / (transmitter.Source.Repetition_Rate ...
           * (transmitter.Source.Wavelength * 1e-9) ^ 2) ...
        + phase_relative_motion;


    phase_difference = cos(phase_offset) - cos(phase_offset + pi);
    phase_total = cos(phase_offset) + cos(phase_offset + pi);

    visibility = abs(phase_difference) ./ (2 + phase_total);

end
