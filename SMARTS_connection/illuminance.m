classdef illuminance < card

    properties

        amount;

    end

    methods

        function illuminance = illuminance(varargin)

            illuminance.flag = 0;
            illuminance.no_flag = true;
            illuminance.card_type = 'ILLUM';
            illuminance.card_num = 15;
            illuminance.groups = {{}};
            illuminance.suffix = {''};

            p = inputParser;
            addParameter(p, 'value', nan);

            parse(p, varargin{:});

            if ~isnan(p.Results.value)
                %assert(p.Results.value ~= 0);
                %assert(p.Results.value >= -2 & p.Results.value <= 2);

                illuminance.amount = p.Results.value;
            end

        end

    end

end
