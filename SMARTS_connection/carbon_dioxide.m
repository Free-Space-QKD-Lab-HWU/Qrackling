classdef carbon_dioxide < card
    properties

    amount;
    extraterrestrial_spectrum;
        
    end

    methods

        function carbon_dioxide = carbon_dioxide(varargin)

            carbon_dioxide.no_flag = true;
            carbon_dioxide.flag = 1;
            carbon_dioxide.card_type = 'C02 amount (ppm)';
            carbon_dioxide.card_num = 7;
            carbon_dioxide.groups = {{'extraterrestrial_spectrum'}, {''}};
            carbon_dioxide.suffix = {'a', ''};

            p = inputParser;
            addParameter(p, 'amount', 370);
            addParameter(p, 'extraterrestrial_spectrum', 1);

            parse(p, varargin{:});

            assert(p.Results.extraterrestrial_spectrum >= -1, ...
                   '"extraterrestrial_spectrum" must be >= -1');

            assert(p.Results.extraterrestrial_spectrum <= 8, ...
                   '"extraterrestrial_spectrum" must be <= 9');

            % TODO -> test case of "extraterrestrial_spectrum" = -1 to see if
            % the input file exists, has correct extension etc...

            carbon_dioxide.amount = p.Results.amount;
            carbon_dioxide.flag = p.Results.amount;
            carbon_dioxide.extraterrestrial_spectrum = p.Results.extraterrestrial_spectrum;

        end

    end
end
