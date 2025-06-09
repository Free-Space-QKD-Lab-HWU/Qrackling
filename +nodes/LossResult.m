classdef LossResult
    properties
        kind = []
        losses (:,1) cell
        numLosses (1,1) {mustBeNumeric}
        length (1,1) {mustBeNumeric}
    end
    methods
        function result = LossResult(kind, Loss)

            arguments
                kind {mustBeMember(kind, ["beacon", "qkd"])} = "qkd"
            end
            arguments(Repeating)
                Loss units.Loss
            end

            result.kind = kind;

            %return straight away if called to construct empty object
            if isempty(Loss)
                return
            end

            %store losses in an array
            result.losses = Loss;
            num_different_losses = numel(Loss);
            num_loss_points = numel(Loss{1});
            for i=1:num_different_losses

                assert(numel(result.losses{i})==num_loss_points,...
                    'all losses stored must have the same number of elements')
            end

        end

        function n = get.numLosses(result)
            n=numel(result.losses);
        end

        function n = get.length(result)
            if result.numLosses==0
                n=0;
                return
            end
            n=numel(result.losses{1});
        end

        function loss = TotalLoss(result)
            arguments
                result nodes.LossResult
            end

            %create memory
            loss = double(result.losses{1});

            %iterate over losses, multiplying
            if ~(result.numLosses==1)
                for i=2:result.numLosses
                    loss = loss .* result.losses{i};
                end
            end

            %convert back to loss objevt
            loss = units.Loss(loss,'Total');
        end

        function plotLosses(result, x_axis, x_label, options)
            arguments
                result nodes.LossResult
                x_axis
                x_label
                options.mask = [];
            end

            if isempty(options.mask)
                options.mask = true(result.length,1);
            end
            labels = {};
            loss_dB = [];
            for i=1:result.numLosses
                whole_loss_dB = result.losses{i}.dB;
                if any(whole_loss_dB~=0)
                    labels = [labels,result.losses{i}.name];
                    mask_loss_dB = whole_loss_dB(options.mask);
                    loss_dB = [loss_dB;mask_loss_dB]; %#ok<*AGROW>
                end
            end

            area(x_axis(options.mask),loss_dB')
            xlabel(x_label)
            ylabel("Losses (dB)")
            legend(labels,'location','south',...
                'Orientation','horizontal')
            grid on

        end


        function names = Names(result)
            %return a cell array of characters with the names of different
            %calculated losses (those which are not empty)
            names = cellfun(@(x) x.name,result.losses,'UniformOutput',false);
        end

        function losses = get(result,Loss_Names)
            %%GET return a single loss object, or cell array of loss
            %%objects, which have the specified name(s)
            arguments
                result nodes.LossResult
            end
            arguments(Repeating)
                Loss_Names {mustBeText}
            end


            losses = {};
            %iterating through requested names
            for loss_name = Loss_Names
                loss_name = loss_name{1};
                found = false;
                %iterating through elements of result, comparing names
                for loss = result.losses'
                    loss = loss{1};
                    if isequal(loss_name,loss.name)
                        losses = [losses,{loss}];
                        found = true;
                        break
                    end
                end
                if found
                    break
                else
                    error('cannot find loss named %s in lossResult',loss_name);
                end
            end



        end

        function result = addLoss(result,loss)
            %%ADDLOSS add a new loss term to the LossResult
            arguments
                result nodes.LossResult
            end
            arguments(Repeating)
                loss units.Loss
            end

            %check that losses have same length
            length = result.length;
            assert(all(cellfun(@(x) numel(x)==length, loss)),...
                'added losses must have same length as existing losses')

            %append losses
            result.losses = [result.losses;loss];
        end
    end
end
