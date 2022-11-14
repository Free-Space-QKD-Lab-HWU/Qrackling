classdef water_vapour < card
    properties
        preciptable_water;
        amount;
    end

    methods
        function water_vapour = water_vapour(varargin)

            water_vapour.card_type = 'IH20';
            water_vapour.card_num = 4;
            water_vapour.groups = {{}, {'preciptable_water'}};
            water_vapour.suffix = {'', 'a'};

            p = inputParser;
            addParameter(p, 'w', -1);

            parse(p, varargin{:});

            if -1 == p.Results.w
                water_vapour.flag = 1;
            else
                assert(p.Results.w >= 0);
                assert(p.Results.w <= 12);
                water_vapour.preciptable_water = p.Results.w;
                water_vapour.flag = 0;
                water_vapour.amount = p.Results.w;
            end
        end
    end
end
