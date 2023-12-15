classdef FreeSpaceTransmitter
    properties (SetAccess = protected)
        source components.Source
        telescope components.Telescope
        location nodes.Located_Object
        timestamps = []
    end

    methods

        function fs_tx = FreeSpaceTransmitter(source, telescope, location, ...
            options)

            arguments
                source components.Source
                telescope components.Telescope
                location nodes.Located_Object
                options.timestamps = [];
            end
            fs_tx.source = source;
            fs_tx.telescope = telescope;
            fs_tx.location = location;

            if contains(fieldnames(options), "timestamps")
                if ~isempty(options.timestamps)
                    fs_tx.timestamps = options.timestamps;
                end
            end
        end

    end
end
