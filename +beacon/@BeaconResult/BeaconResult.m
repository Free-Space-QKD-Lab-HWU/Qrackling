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

        function fig = plot(result, x_axis, x_label, options)
            arguments
                result beacon.BeaconResult
                x_axis
                x_label
                options.mask
            end

            have_mask = any(contains(fieldnames(options), "mask"));

            fig = figure();
            subplot(3, 1, 1)
            if have_mask
                plot(x_axis(options.mask), result.received_power(options.mask))
            else
                plot(x_axis, result.received_power)
            end
            ylabel("Beacon Power (W)");
            xlabel(x_label);

            subplot(3, 1, 2)
            hold on
            if have_mask
                result.losses.plotLosses(x_axis, x_label, "mask", options.mask);
            else
                result.losses.plotLosses(x_axis, x_label);
            end
            hold off

            subplot(3, 1, 3)
            if have_mask
                plot(x_axis(options.mask), result.snr_db(options.mask))
            else
                plot(x_axis, result.snr_db)
            end
            ylabel("SNR (dB)");
            xlabel(x_label);

        end

    end
end

