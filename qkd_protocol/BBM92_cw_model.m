% From: Neumann, S. P., Scheidl, T., et al. (2021), Model for Optimizing 
% Quantum Key Distribution with Continuous-Wave Pumped Entangled-Photon 
% Sources, 10.1103/PhysRevA.104.022406.

function [secret_key_rate, qber, sifted_key_rate] = ...
    BBM92_cw_model(source, dark_count_probability, loss, protocol_efficiency, detector)

    arguments
        source Source
        dark_count_probability {mustBeNumeric}
        loss {mustBeNumeric}
        protocol_efficiency {mustBeNumeric}
        detector Detector
    end

    % TODO: Need to add a coincidence window property somewhere
    % Should it go in Source or Detector, that is the question?

    % HACK: Brightness for a downconversion source might require a little bit
    % more information than just mean photon number and repetition rate, for 
    % now this will do.
    brightness = source.Mean_Photon_Number * source.Repetition_Rate;

    % NOTE: We assume Alice transmits and Bob receives, so detection efficiency
    % must be applied to both but channel loss is only needed on Bob for now.
    % TODO: Loss needs to be considered for Alice as well in the case we have a
    % central node that links to a pair of receivers, think double down link.
    efficiency_alice = detector.Detection_Efficiency;
    efficiency_bob = detector.Detection_Efficiency .* loss;
    singles_alice = brightness .* efficiency_alice;
    singles_bob = brightness .* efficiency_bob;
    coincidences = brightness .* efficiency_alice .* efficiency_bob;

    % TODO: The dark count rate for the detectors is enough for now but this
    % needs to be extended to include the effects of the atmospheric/solar 
    % background
    singles_alice_measured = singles_alice + detector.Dark_Count_Rate;
    singles_bob_measured = singles_bob + detector.Dark_Count_Rate;
    coincidences_accidental = AccidentalCoincidences(t_cc, ...
        AccidentalProbability(singles_alice_measured, singles_bob_measured));
    windowing_loss = LossFromCoincidenceWindow(t_cc, timing_imprecision);

    coincidences_measured = (windowing_loss .* coincidences) + coincidences_accidental;
    coincidences_erroneous = ErroneousCoincidences(windowing_loss, ...
        coincidences, source.State_Prep_Error, coincidences_accidental);

    qber = coincidences_erroneous ./ coincidences_measured;

    secret_key_rate = SecretKeyRate(coincidences_measured, bit_error, ...
        phase_error, bit_error_correction_efficiency, protocol_efficiency);

    sifted_key_rate = coincidences_measured;

end


function loss = LossFromCoincidenceWindow(t_cc, timing_imprecision)
    loss = erf(sqrt(log(2)) .* (t_cc ./ timing_imprecision));
end

function probability = AccidentalProbability(singles_alice, singles_bob, t_cc)
    probability = (1 - exp(-1 .* (singles_alice .* t_cc))) ...
        .* (1 - exp(-1 .* (singles_bob .* t_cc)));
end

function accidental_coincidences = AccidentalCoincidences(t_cc, accidental_probability)
    accidental_coincidences = accidental_probability ./ t_cc;
end

function erroneous_coincidences = ErroneousCoincidences(windowing_loss, ...
    true_coincidences, polarisation_error, accidentals_rate)
    erroneous_coincidences = ...
        (windowing_loss .* true_coincidences .* polarisation_error) ...
        + (0.5 .* accidentals_rate);
end

% function measured_coincidences = MeasuredCoincidences()
% end

function entropy = BinaryEntropy(x)
    arguments
        x {mustBeNumeric}
    end

    inverse = 1 - x;
    entropy = -x .* log2(x) - (inverse .* log2(inverse));
end

function secret_key_rate = SecretKeyRate(measured_coincidence_rate, bit_error, ...
    phase_error, bit_error_correction_efficiency, ratio_of_matching_detection)
    arguments
        measured_coincidence_rate
        bit_error
        phase_error
        bit_error_correction_efficiency = 1.1
        ratio_of_matching_detection = 0.5
    end

    postprocessed_rate = ...
        ratio_of_matching_detection .* measured_coincidence_rate;

    bit_entropy = bit_error_correction_efficiency .* BinaryEntropy(bit_error);

    secret_key_rate = ...
        postprocessed_rate .* (1 - bit_entropy - BinaryEntropy(phase_error));

end
