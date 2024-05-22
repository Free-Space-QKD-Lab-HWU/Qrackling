function mustHaveDetector(receiver)
% a validation function which returns only if the receiver object has a
% valid detector property

    if isscalar(receiver)
        if isempty(receiver.Detector)
            error('%c has no detector object and so cannot be used as a receiver', receiver.Name)
        end
        return
    end

    for i = 1:numel(receiver)
        r = receiver(i);
        if isempty(r.Detector)
            error('%c has no detector object and so cannot be used as a receiver', receiver.Name)
        end
    end
end
