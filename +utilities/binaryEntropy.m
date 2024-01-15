function entropy = binaryEntropy(x)
    arguments
        x {mustBeNumeric}
    end

    inverse = 1 - x;
    entropy = -x .* log2(x) - (inverse .* log2(inverse));
end
