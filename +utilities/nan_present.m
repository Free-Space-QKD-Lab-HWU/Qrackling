function total = nan_present(varargin)
    total = 0;
    for arg = varargin
        try
            total = total + ~isnan(arg);
        catch
            total = total;
        end
    end
end
