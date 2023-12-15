classdef FreeSpaceReceiver
    properties (SetAccess = protected)
        detector components.Detector
        telescope components.Telescope
        location nodes.Located_Object
        timestamps = []
    end

    methods

        function fs_rx = FreeSpaceReceiver(detector, telescope, location, ...
            options)

            arguments
                detector components.Detector
                telescope components.Telescope
                location nodes.Located_Object
                options.timestamps = []
            end
            fs_rx.detector = detector;
            fs_rx.telescope = telescope;
            fs_rx.location = location;

            if contains(fieldnames(options), "timestamps")
                if ~isempty(options.timestamps)
                    fs_rx.timestamps = options.timestamps;
                end
            end
        end

    end
end
