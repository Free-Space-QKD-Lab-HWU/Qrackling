function mustHaveDetector(receiver)
% mustHaveDetector
%
% Validates that each receiver object has a non-empty Detector property.
%
% Syntax:
% mustHaveDetector(receiver)
%
% Inputs:
% receiver - scalar or array of receiver objects with a Detector property

    if isscalar(receiver) && ~isa(receiver, "cell")
        if isempty(receiver.detector)
            error('%s has no detector object and cannot be used as a receiver', receiver.Name)
        end
        return
    end

    for i = 1:numel(receiver)
        r = receiver(i);
        if isempty(r.detector)
            error('%s has no detector object and cannot be used as a receiver', r.Name)
        end
    end
end