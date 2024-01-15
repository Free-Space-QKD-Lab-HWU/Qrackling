classdef Alice
    properties
        source components.Source
        detector components.Detector
        channel_efficiency {mustBeNumeric} = []
        background_count_rate {mustBeNumeric} = []
    end

    methods
        function alice = Alice( ...
            has_source, has_detector, channel_efficiency, background_count_rate)
            arguments
                has_source {protocol.isOrHasSource}
                has_detector {protocol.isOrHasDetector} = components.Detector.empty(0)
                channel_efficiency {mustBeNumeric} = 1
                background_count_rate {mustBeNumeric} = 0
            end

            switch class(has_source)
            case 'components.Source'
                source = has_source;
            case 'nodes.Satellite'
                source = has_source.Source;
            case 'nodes.Ground_Station'
                source = has_source.Source;
            otherwise
                source = utilities.getPropertyFromObject(has_source, 'components.Source');
            end
            alice.source = source;

            if ~isempty(has_detector)
                switch class(has_detector)
                case 'components.Detector'
                    alice.detector = has_detector;
                case 'nodes.Satellite'
                    alice.detector = has_detector.Detector;
                case 'nodes.Ground_Station'
                    alice.detector = has_detector.Detector;
                otherwise
                    alice.detector = utilities.getPropertyFromObject(has_detector, 'components.Detector');
                end
            elseif isempty(has_detector) && protocol.isOrHasDetector(has_source)
                alice.detector = utilities.getPropertyFromObject(has_source, 'components.Detector');
            end


            alice.channel_efficiency = channel_efficiency;
            alice.background_count_rate = background_count_rate;
        end
    end
end
