classdef LossResult
% LossResult
%
% Stores and manages multiple loss objects for beacon or QKD systems.
%
% Syntax:
% result = nodes.LossResult(kind, loss1, loss2, ...)

    properties
        % kind - type of loss result ('beacon' or 'qkd')
        kind (1, 1) string {mustBeMember(kind, ["beacon", "qkd"])} = "qkd"

        % losses - cell array of units.Loss objects
        losses (:, 1) cell

        % numLosses - number of loss objects
        numLosses (1, 1) {mustBeNumeric}

        % length - number of points in each loss object
        length (1, 1) {mustBeNumeric}
    end


    methods
        function result = LossResult(kind, Loss)
        % LossResult constructor
        %
        % Syntax:
        % result = LossResult(kind, loss1, loss2, ...)
        %
        % Inputs:
        % kind - string ("beacon" or "qkd")
        % Loss - one or more units.Loss objects

            arguments
                kind {mustBeMember(kind, ["beacon", "qkd"])} = "qkd"
            end
            arguments(Repeating)
                Loss units.Loss
            end

            result.kind = kind;

            if isempty(Loss)
                return
            end

            result.losses = Loss;
            num_different_losses = numel(Loss);
            num_loss_points = numel(Loss{1});

            for i = 1:num_different_losses
                assert(numel(result.losses{i}) == num_loss_points, ...
                    'All losses must have the same number of elements');
            end
        end


        function n = get.numLosses(result)
        % Get number of loss objects
            n = numel(result.losses);
        end


        function n = get.length(result)
        % Get number of points in each loss object
            if result.numLosses == 0
                n = 0;
                return
            end
            n = numel(result.losses{1});
        end


        function loss = totalLoss(result)
        % totalLoss
        %
        % Compute the total loss by multiplying all loss objects.
        %
        % Output:
        % loss - units.Loss object representing total loss

            arguments
                result nodes.LossResult
            end

            loss = double(result.losses{1});
            for i = 2:result.numLosses
                loss = loss .* result.losses{i};
            end
            loss = units.Loss(loss, 'Total');
        end


        function plotLosses(result, x_axis, x_label, options)
        % plotLosses
        %
        % Plot all non-zero loss components.
        %
        % Inputs:
        % x_axis - x-axis data
        % x_label - label for x-axis
        % options.mask - logical mask for data selection

            arguments
                result nodes.LossResult
                x_axis
                x_label
                options.mask = []
            end

            if isempty(options.mask)
                options.mask = true(result.length, 1);
            end

            labels = {};
            loss_dB = [];

            for i = 1:result.numLosses
                whole_loss_dB = result.losses{i}.dB;
                if any(whole_loss_dB ~= 0)
                    labels = [labels, result.losses{i}.name];
                    mask_loss_dB = whole_loss_dB(options.mask);
                    loss_dB = [loss_dB; mask_loss_dB]; %#ok<AGROW>
                end
            end

            area(x_axis(options.mask), loss_dB')
            xlabel(x_label)
            ylabel("Losses (dB)")
            legend(labels, 'Location', 'south', 'Orientation', 'horizontal')
            grid on
        end


        function names = Names(result)
        % Names
        %
        % Return names of all stored loss objects.
        %
        % Output:
        % names - cell array of strings

            names = cellfun(@(x) x.name, result.losses, 'UniformOutput', false);
        end


        function losses = get(result, Loss_Names)
        % get
        %
        % Retrieve loss objects by name.
        %
        % Syntax:
        % losses = result.get("name1", "name2", ...)
        %
        % Output:
        % losses - cell array of units.Loss objects

            arguments
                result nodes.LossResult
            end
            arguments(Repeating)
                Loss_Names {mustBeText}
            end

            losses = {};
            for loss_name = Loss_Names
                loss_name = loss_name{1};
                found = false;

                for loss = result.losses'
                    loss = loss{1};
                    if isequal(loss_name, loss.name)
                        losses = [losses, {loss}];
                        found = true;
                        break
                    end
                end

                if ~found
                    error('Cannot find loss named "%s" in LossResult', loss_name);
                end
            end
        end


        function result = addLoss(result, loss)
        % addLoss
        %
        % Add new loss objects to the result.
        %
        % Syntax:
        % result = result.addLoss(loss1, loss2, ...)
        %
        % Inputs:
        % loss - one or more units.Loss objects

            arguments
                result nodes.LossResult
            end
            arguments(Repeating)
                loss units.Loss
            end

            length = result.length;
            assert(all(cellfun(@(x) numel(x) == length, loss)), ...
                'Added losses must have same length as existing losses');

            result.losses = [result.losses; loss];
        end
    end
end