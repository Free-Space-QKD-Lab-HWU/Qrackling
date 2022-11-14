classdef turbidity < card
    
    properties

        TAU5;
        BETA;
        BCHUEP;
        RANGE;
        VISI;
        TAU550;
        
        param_opts = {'TAU5', 'BETA', 'BCHUEP', 'RANGE', 'VISI', 'TAU550'};

    end

    methods

        function turbidity = turbidity(varargin)

            turbidity.card_type = 'ITURB';
            turbidity.card_num = 9;
            turbidity.groups = {{'TAU5'}, {'BETA'}, {'BCHUEP'}, {'RANGE'}, ...
                                {'VISI'}, {'TAU550'}};
            turbidity.suffix = {'a', 'a', 'a', 'a', 'a', 'a'};

            p = inputParser;
            addParameter(p, 'TAU5', nan);
            addParameter(p, 'BETA', nan);
            addParameter(p, 'BCHUEP', nan);
            addParameter(p, 'RANGE', nan);
            addParameter(p, 'VISI', nan);
            addParameter(p, 'TAU550', nan);
    
            parse(p, varargin{:});

            nan_check = ~isnan([p.Results.TAU5, p.Results.BETA, ...
                               p.Results.BCHUEP, p.Results.RANGE, ...
                               p.Results.VISI, p.Results.TAU550]);

            if sum(nan_check) > 1
                error('Please only supply one input argument');
            end

            arg_idx = find(nan_check);
            param = turbidity.param_opts{arg_idx};

            turbidity.(param) = p.Results.(param);

            turbidity.flag = arg_idx - 1;

        end

    end

end
