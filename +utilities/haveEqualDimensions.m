function result = haveEqualDimensions(A)
    % Returns true if all input arrays have equal dimensions.
    %
    % Syntax:
    % result = haveEqualDimensions(A1, A2, ...)
    %
    % Description:
    % Compares the size of each input array against the first.
    % If all dimensions match, returns true. Otherwise, returns false.

    arguments (Repeating)
        A
    end

    a = A{1}; % Initialize a with the first input argument

    for i = 2:length(A)
        if ~isequal(size(a), size(A{i}))
            result = false;
            return;
        end
    end

    result = true;
end