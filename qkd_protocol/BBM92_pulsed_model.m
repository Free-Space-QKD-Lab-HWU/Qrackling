function [secret_key_rate, qber, sifted_key_rate] = ...
    BBM92_pulsed_model(source, dark_count_probability, loss, ...
        protocol_efficiency, detector)

    arguments
        source Source
        % TODO: is "dark_count_probability" here the way we get the counts from
        % atmospheric / solar background?
        dark_count_probability {mustBeNumeric}
        loss {mustBeNumeric}
        protocol_efficiency {mustBeNumeric}
        detector Detector
    end
end
