function mustHaveSource(transmitter)
% mustHaveSource
%
% Validates that each transmitter object has a non-empty Source property.
%
% Syntax:
% mustHaveSource(transmitter)
%
% Inputs:
% transmitter - scalar or cell array of transmitter objects with a Source property

    if isscalar(transmitter) && ~isa(transmitter, "cell")
        if isempty(transmitter.source)
            error('%s has no source object and cannot be used as a transmitter', transmitter.name)
        end
        return
    end

    for i = 1:numel(transmitter)
        t = transmitter(i);
        if isempty(t.source)
            error('%s has no source object and cannot be used as a transmitter', t.name)
        end
    end
end