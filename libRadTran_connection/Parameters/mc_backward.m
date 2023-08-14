classdef mc_backward
    properties (SetAccess = protected)
        Start_X
        Start_Y
        Stop_X
        Stop_Y
    end
    methods
        function mc = mc_backward(options)
            arguments
                options.start_x
                options.start_y
                options.stop_x
                options.stop_y
            end

            fields = fieldnames(options);

            switch numel(fields)
                case 0
                    return
                case 2
                    assert(numel(contains(fields, "start_")) == 2, ...
                        'Must supply both "start_x" and "start_y"');
                    mc.Start_X = options.start_x;
                    mc.Start_Y = options.start_y;
                    return
                case 4
                    mc.Start_X = options.start_x;
                    mc.Start_Y = options.start_y;
                    mc.Stop_X = options.stop_x;
                    mc.Stop_Y = options.stop_y;
                    return
            end
        end
    end
end
