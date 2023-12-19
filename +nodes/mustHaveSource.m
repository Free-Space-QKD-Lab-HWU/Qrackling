function mustHaveSource(transmitter)
% a validation function which returns only if the receiver object has a
% valid source property

if isempty(transmitter.Source)
    error('%c has no source object and so cannot be used as a transmitter',transmitter.Name)
end