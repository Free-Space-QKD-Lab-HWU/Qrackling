function prob = probabilityFromDecibelLoss(loss)
    arguments
        loss {mustBeNumeric}
    end
    prob = 10 .^ (-loss / 10);
end
