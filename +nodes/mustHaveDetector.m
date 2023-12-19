function mustHaveDetector(receiver)
% a validation function which returns only if the receiver object has a
% valid detector property

if isempty(receiver.Detector)
    error('%c has no detector object and so cannot be used as a receiver',receiver.Name)
end