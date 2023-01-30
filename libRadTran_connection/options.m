classdef options
    properties(SetAccess=protected, Hidden=true)
        labeled;
        labels;
    end
    properties
        opts;
    end
    methods
        function options = options(opts)
            if isnumeric(opts)
                options.opts = opts;
                options.labeled = false;
            else
                %if iscell(o(1))
                %    disp(opts);
                %    options.opts = cellfun(@(x) x{1}, opts, UniformOutput=false);
                %    options.labels = cellfun(@(x) x{2}, opts, UniformOutput=false);
                %else
                %end
                if contains(opts(1), ',')
                    halfs = split(opts, ', ');
                    options.opts = halfs(:, :, 1);
                    options.labels = halfs(:, :, 2);
                    options.labeled = true;
                else
                    options.opts = linspace(1, numel(opts), numel(opts));
                    options.labels = opts;
                    options.labeled = true;
                end
            end
        end

        function show(options)
            for i = 1:numel(options.opts)
                if options.labeled == true
                    if isnumeric(options.opts(i))
                        o = num2str(options.opts(i));
                    else
                        o = options.opts{i};
                    end
                    disp([o, char(9), options.labels{i}]);
                else
                    disp(options.opts(i));
                end
            end
        end
    end
end
