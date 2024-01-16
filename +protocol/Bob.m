classdef Bob
    properties
        detector components.Detector
        channel_efficiency {mustBeNumeric} = 1
        dark_count_probability {mustBeNumeric} = 0
    end

    methods
        function bob = Bob(has_detector, channel_efficiency, dark_count_probability)
            arguments
                has_detector {protocol.isOrHasDetector}
                channel_efficiency {mustBeNumeric} = 1
                dark_count_probability {mustBeNumeric} = 0
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
            bob.channel_efficiency = channel_efficiency;
            bob.dark_count_probability = dark_count_probability;
        end
    end

end
