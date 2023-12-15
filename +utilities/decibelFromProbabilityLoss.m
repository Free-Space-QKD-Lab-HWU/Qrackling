function db = decibelFromProbabilityLoss(loss)
    arguments
        loss {mustBeNumeric}
    end

    db = -10 * log10(loss);

end

