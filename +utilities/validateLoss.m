function valid_loss = validateLoss(loss, n)
    arguments
        loss
        n
    end

    valid_loss = loss;

    if ~all(isreal(valid_loss) & valid_loss >= 0)
        error('valid_loss must be a non-negative array of numeric values')
    end
    if isscalar(valid_loss)
        %if provided a scalar, put this into everywhere in the array 
        valid_loss = valid_loss * ones(1, n);
    elseif isrow(valid_loss)
    elseif iscolumn(valid_loss)
        valid_loss = valid_loss'; %can transpose lengths to match dimensions of Link_Models
    else
        error('Array must be a vector or scalar');
    end
end

