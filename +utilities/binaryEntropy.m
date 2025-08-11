function entropy = binaryEntropy(x)
    % Returns the binary entropy of a probability value or array.
    %
    % Syntax:
    % entropy = binaryEntropy(x)
    %
    % Description:
    % Computes the Shannon entropy for binary distributions:
    % H(x) = -x·log2(x) - (1−x)·log2(1−x)
    % Handles vectorized input.

    arguments
        x {mustBeNumeric}
    end

    inverse = 1 - x;
    entropy = -x .* log2(x) - (inverse .* log2(inverse));
end