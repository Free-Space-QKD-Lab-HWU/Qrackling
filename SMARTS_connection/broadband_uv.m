classdef broadband_uv < card

    properties
        amount;
    end

    methods

        function broadband_uv = broadband_uv(varargin)

            broadband_uv.flag = 0;
            broadband_uv.no_flag = true;
            broadband_uv.card_type = 'IUV';
            broadband_uv.card_num = 16;
            broadband_uv.groups = {{}};
            broadband_uv.suffix = {''};

            p = inputParser;
            addParameter(p, 'value', 0);

            parse(p, varargin{:});

            if ~isnan(p.Results.value)
                assert(p.Results.value >= 0 & p.Results.value <= 1);

                broadband_uv.amount = p.Results.value;
            end


        end

    end

end
