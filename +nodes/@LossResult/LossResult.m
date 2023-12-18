classdef LossResult
    properties (SetAccess = protected)
        kind
        geometric units.Loss
        optical units.Loss
        apt units.Loss
        turbulence units.Loss
        atmospheric units.Loss
    end
    methods
        function result = LossResult(kind, options)

            arguments
                kind {mustBeMember(kind, ["beacon", "qkd"])}
                options.geometric
                options.optical
                options.apt
                options.turbulence
                options.atmospheric
            end

            result.kind = kind;

            for fieldname = fieldnames(options)'
                switch fieldname{1}
                case "geometric"
                    result.geometric = options.geometric;
                case "optical"
                    result.optical = options.optical;
                case "apt"
                    result.apt = options.apt;
                case "turbulence"
                    result.turbulence = options.turbulence;
                case "atmospheric"
                    result.atmospheric = options.atmospheric;
                end
            end
        end

        % TODO: add in optional argument for "extra losses"
        function loss = TotalLoss(result, unit)
            arguments
                result nodes.LossResult
                unit {mustBeMember(unit, ["probability", "dB"])}
            end

            props = properties(result);
            loss_props = props(~contains(props, {'kind'}))';
            valid_props = ~cellfun(@(p) isempty(result.(p)), loss_props);

            valid_props = loss_props(valid_props);

            switch unit
            case "probability"
                total = ones(size(result.(valid_props{1})));
                for property = valid_props
                    total = total .* result.(property{1}).As("probability");
                end

            case "dB"
                total = zeros(size(result.(valid_props{1})));
                for property = valid_props
                    total = total + result.(property{1}).As("dB");
                end
            end

            loss = units.Loss(unit, "Total Loss", total);
        end

        function plotLosses(result, x_axis, x_label, options)
            arguments
                result nodes.LossResult
                x_axis
                x_label
                options.mask
            end

            have_mask = any(contains(fieldnames(options), "mask"));

            loss_arrays = {};
            props = properties(result);
            labels = cell([1, length(props)]);
            i = 1;
            for property = props(~contains(props, {'kind'}))'
                loss = result.(property{1}).As("dB");

                if have_mask
                    loss = loss(options.mask);
                end

                loss_arrays.(property{1}) = loss;

                labels{i} = result.(property{1}).label;
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