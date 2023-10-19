classdef protocolInterface < handle

    methods (Abstract, Hidden)
        sourceRequirements(obj, source)
        detectorRequirements(obj, detector)
        [sifted_key_rate, secure_key_rate, qber] = protocolImplementation(...
            obj, source, ...
            detector_alice, detector_bob, ...
            loss_alice, loss_bob, ...
            background_counts_alice, background_counts_bob, ...
            sifting_rate, error_correction_efficiency)
    end

    methods

        function [sifted, secure, qber] = CalculateKeyRatesAndError(obj, ...
            source, detector_alice, detector_bob, loss_alice, loss_bob, options)
            arguments
                obj
                source Source {mustBeNonempty}
                detector_alice Detector {mustBeNonempty}
                detector_bob Detector = []
                loss_alice = []
                loss_bob = []
                options.background_counts_alice = []
                options.background_counts_bob = []
                options.sifting_rate = []
                options.error_correction_efficiency = []
            end

            obj.sourceRequirements(source);
            obj.detectorRequirements(detector_alice);
            obj.detectorRequirements(detector_bob);

            [sifted, secure, qber] = obj.protocolImplementation(source, ...
                detector_alice, detector_bob, loss_alice, loss_bob, ...
                options.background_counts_alice, ...
                options.background_counts_bob, ...
                options.sifting_rate, ...
                options.error_correction_efficiency);
        end

    end
end
