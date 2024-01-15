function [alice, bob] = deriveAliceAndBob(transmitter, receiver, options)
    arguments
        transmitter {protocol.isOrHasSource}
        receiver {protocol.isOrHasDetector}
        options.BackgroundSources = []
        options.
    end

    kind_r = protocol.isOrHasSource(transmitter);
    kind_t = protocol.isOrHasDetector(receiver);

    if (kind_r == 1 ) && (kind_t == 1)
    elseif any(kind_r == [2, 3]) && any(kind_t == [2, 3])
        source = transmitter.Source;
        detector = receiver.Detector;
    else
        source = transmitter.Source;
        detector = receiver.detector;
    end

end
