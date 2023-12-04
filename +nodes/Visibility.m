function visibility = Visibility(receiver, transmitter)
    arguments
        receiver nodes.FreeSpaceReceiver
        transmitter nodes.FreeSpaceTransmitter
    end


    differences = ...
        nodes.Doppler_Shift(receiver, transmitter) ...
        - transmitter.source.Wavelength;

    phase_relative_motion = ...
        nodes.PhaseShiftFromRelativeMotion(receiver, transmitter);

    c = 2.998e8;
    phase_offset = ...
        (2 * pi * differences * c) ...
        / (transmitter.source.Repetition_Rate ...
           * (transmitter.source.Wavelength * 1e-9) ^ 2) ...
        + phase_relative_motion;


    phase_difference = cos(phase_offset) - cos(phase_offset + pi);
    phase_total = cos(phase_offset) + cos(phase_offset + pi);

    visibility = abs(phase_difference) ./ (2 + phase_total);

end
