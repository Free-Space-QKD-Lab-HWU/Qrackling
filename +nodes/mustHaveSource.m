function mustHaveSource(transmitter)
% a validation function which returns only if the receiver object has a
% valid source property

    if isscalar(transmitter) && ~isa(transmitter, "cell")
        if isempty(transmitter.Source)
            error('%c has no source object and so cannot be used as a transmitter',transmitter.Name)
        end
        return
    end

    for i = 1:numel(transmitter)
        t = transmitter{i};
        if isempty(t.Source)
            error('%c has no source object and so cannot be used as a transmitter',t.Name)
        end
    end
end
