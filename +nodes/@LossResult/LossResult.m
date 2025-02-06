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

        function loss = TotalLoss(result)
            arguments
                result nodes.LossResult
            end

            valid_props = result.Names;
            total = ones(size(result.(valid_props{1})));
            for property = valid_props
                current_loss = result.(property{1});
                total = total .* current_loss;
            end

            loss = units.Loss(total);
        end

        function plotLosses(result, x_axis, x_label, options)
            arguments
                result nodes.LossResult
                x_axis
                x_label
                options.mask
                options.axes
            end

            have_mask = any(contains(fieldnames(options), "mask"));

            loss_arrays = {};
            labels = result.Names;
            i = 1;
            for name = labels
                if ~isempty(result.(name{1}))
                    loss = result.(name{1}).dB;

                    if have_mask
                        loss = loss(options.mask);
                    end

                    loss_arrays.(name{1}) = loss;
                    i = i + 1;
                end
            end

            if ismember(fieldnames(options), "axes")
                area(options.axes, x_axis(options.mask), cell2mat(struct2cell(loss_arrays))');
            else
                area(x_axis(options.mask), cell2mat(struct2cell(loss_arrays))');
            end

            lgd = legend(labels(1:i-1), "Orientation", "horizontal", "Location", "south");
            lgd.NumColumns = 1;

            xlabel(x_label)
            ylabel("Losses (dB)")
            grid on

        end

    
        function names = Names(result)
            %return a cell array of characters with the names of different
            %calculated losses (those which are not empty)


            props = properties(result);
            loss_props = props(~contains(props, {'kind'}))';
            i=1;
            for loss_property = loss_props
                if ~isempty(result.(loss_property{1}))
                names{i} = loss_property{1};
                i = i + 1;
                end
            end
        end
    end
end
