function qber = combineQBER(QBER)
    % combineQBER
    %
    % QBERs add like probabilities, with odd numbers of errors causing
    % errors and even numbers of errors cancelling one another. This
    % combination is implemented recursively
    %
    % Syntax:
    % qber = combineQBER(QBER1, QBER2, QBER3,...)

    arguments(Repeating)
        QBER (1,:) {mustBeNonnegative, mustBeLessThanOrEqual(QBER,0.5)}
    end

    %% validate that all QBERs are of equal length or scalar
    length = [];
    for current_qber=QBER
        if ~isscalar(current_qber)
            if ~isempty(length)
                assert(length(current_qber)==length, "QBERs provided to combineQBER must be scalar or match in length")
            else
                length = length(current_qber);
            end
        end
    end

    %% compute QBER recursively
    % first, discard case with 1 QBER
    if isscalar(QBER)
        qber = QBER{1};
        return
    end

    % implement recursion
    current_qber = QBER{1};
    for current_index = 2:numel(QBER)
        current_qber = current_qber.*(1-QBER{current_index}) + QBER{current_index}.*(1-current_qber);
    end

    % return result
    qber = current_qber;