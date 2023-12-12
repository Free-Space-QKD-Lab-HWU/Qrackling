classdef BeaconResult
    properties (SetAccess = protected)
        losses nodes.LossResult
        total_loss_db = []
        background_counts = []
        received_power = []
        snr = []
        snr_db = []
    end

    methods
        function result = BeaconResult(losses, total_loss_db, ...
            background_counts, received_power, snr, snr_db)
            arguments
                losses nodes.LossResult
                total_loss_db = []
                background_counts = []
                received_power = []
                snr = []
                snr_db = []
            end
            result.losses = losses;
            result.total_loss_db = total_loss_db;
            result.background_counts = background_counts;
            result.received_power = received_power;
            result.snr = snr;
            result.snr_db = snr_db;
        end

        function plotLosses(result, x_axis, x_label, options)
            arguments
                result beacon.BeaconResult
                x_axis
                x_label
                options.mask
            end

            have_mask = any(contains(fieldnames(options), "mask"));

            loss_arrays = {};
            props = properties(result.losses);
            labels = cell([1, length(props)]);
            i = 1;
            for property = props(~contains(props, {'unit', 'kind', 'turbulence'}))'
                if ~strcmp(result.losses.unit, "decibel")
                    loss = utilities.decibelFromPercentLoss(result.losses.(property{1}));
                else
                    loss = result.losses.(property{1});
                end

                if have_mask
                    loss = loss(options.mask);
                end

                loss_arrays.(property{1}) = loss;

                switch property{1}
                case "geometric"
                    labels{i} = "Geometric";
                case "optical"
                    labels{i} = "Optical";
                case "apt"
                    labels{i} = "Acquisition Pointing and Tracking";
                case "turbulence"
                    labels{i} = "Turbulence";
                case "atmospheric"
                    labels{i} = "Atmospheric";
                end
                i = i + 1;
            end

            area(x_axis(options.mask), cell2mat(struct2cell(loss_arrays))');
            legend(labels(1:i-1), "Orientation", "horizontal", "Location", "south")
            xlabel(x_label)
            ylabel("Losses (dB)")
            grid on

        end

    end
end

