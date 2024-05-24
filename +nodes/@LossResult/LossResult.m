classdef LossResult
    properties (SetAccess = protected)
        kind = []
        geometric units.Loss = units.Loss.empty(0, 1)
        optical units.Loss = units.Loss.empty(0, 1)
        apt units.Loss = units.Loss.empty(0, 1)
        turbulence units.Loss = units.Loss.empty(0, 1)
        atmospheric units.Loss = units.Loss.empty(0, 1)
    end
    methods
        function result = LossResult(kind, options)

            arguments
                kind {mustBeMember(kind, ["beacon", "qkd"])} = "qkd"
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

        function loss = TotalLoss(result, unit, extra_loss, extra_unit)
            arguments
                result nodes.LossResult
                unit {mustBeMember(unit, ["probability", "dB"])}
            end
            arguments (Repeating)
                extra_loss nodes.LossResult
                extra_unit {mustBeMember(extra_unit, ["probability", "dB"])}
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

            for i = 1:numel(extra_loss)
                l = extra_loss{i};
                u = extra_unit{i};
                switch u
                case "probability"
                    total = ones(size(result.(valid_props{1})));
                    for property = valid_props
                        total = total .* l.As("probability");
                    end

                case "dB"
                    total = zeros(size(result.(valid_props{1})));
                    for property = valid_props
                        total = total + l.As("dB");
                    end
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
                if ~isempty(result.(property{1}))
                loss = result.(property{1}).As("dB");

                if have_mask
                    loss = loss(options.mask);
                end

                loss_arrays.(property{1}) = loss;

                labels{i} = result.(property{1}).label;
                i = i + 1;
                end
            end

            area(x_axis(options.mask), cell2mat(struct2cell(loss_arrays))');
            legend(labels(1:i-1), "Orientation", "horizontal", "Location", "south")
            xlabel(x_label)
            ylabel("Losses (dB)")
            grid on

        end

    end
end
