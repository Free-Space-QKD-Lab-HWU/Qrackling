classdef circum_solar < card

    properties

        slope;
        aperture;
        limit;

    end

    methods

        function circum_solar = circum_solar(varargin)

            circum_solar.card_type = 'ICIRC';
            circum_solar.card_num = 13;
            circum_solar.groups = {{}, {'slope', 'aperture', 'limit'}};
            circum_solar.suffix = {'', 'a'};

            p = inputParser;
            addParameter(p, 'slope', nan);
            addParameter(p, 'apert', nan);
            addParameter(p, 'limit', nan);

            parse(p, varargin{:});

            circum_solar.flag = 0;

            if ~any(isnan([p.Results.slope, p.Results.apert, p.Results.limit]))
                % assert(p.Results.slope < p.Results.apert ...
                %        & p.Results.apert < p.Results.limit, ...
                %        'Condition "slope" < "apert" < "limit" must hold');
                circum_solar.flag = 1;
                circum_solar.slope = p.Results.slope;
                circum_solar.aperture = p.Results.apert;
                circum_solar.limit = p.Results.limit;
            end

        end

    end

end
