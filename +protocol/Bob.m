classdef Bob
    properties
        detector components.Detector
        channel_loss {mustBeNumeric} = 1
        background_count_rate {mustBeNumeric} = 0
    end

    methods
        function bob = Bob(has_detector, channel_loss, background_count_rate)
            arguments
                has_detector {protocol.isOrHasDetector}
                channel_loss {mustBeNumeric} = 1
                background_count_rate {mustBeNumeric} = 0
            end

            switch class(has_detector)
            case 'components.Detector'
                detector = has_detector;
            case 'nodes.Satellite'
                detector = has_detector.Detector;
            case 'nodes.Ground_Station'
                detector = has_detector.Detector;
            otherwise
                detector = utilites.getPropertyFromObject(has_detector, 'components.Detector');
            end

            bob.detector = detector;
            bob.channel_loss = channel_loss;
            bob.background_count_rate = background_count_rate;
        end
    end

end
