classdef aerosol < card

    properties

        aerosol_opts = {'''S&F_RURAL''', '''S&F_URBAN''', '''S&F_MARIT''', '''S&F_TROPO''', ...
                        '''SRA_CONTL''', '''SRA_URBAN''', '''SRA_MARIT''', '''B&D_C''', ...
                        '''B&D_C1''', '''USER'''};
        model = '';
        amount;

        alpha1;
        alpha2;
        omegl;
        gg;

    end

    methods

        function aerosol = aerosol(varargin)
            aerosol.no_flag = true;
            aerosol.flag = 1;
            aerosol.card_type = 'Aeros (aerosol model)';
            aerosol.card_num = 8;
            aerosol.groups = {{'alpha1', 'alpha2', 'omegl', 'gg'}, {}};
            aerosol.suffix = {'a'};

            p = inputParser;
            addParameter(p, 'aeros', '');
            addParameter(p, 'alpha1', nan);
            addParameter(p, 'alpha2', nan);
            addParameter(p, 'omegl', nan);
            addParameter(p, 'gg', nan);

            parse(p, varargin{:});

            if any(ismember(aerosol.aerosol_opts, ...
                    ['''', upper(p.Results.aeros), '''']))

                aerosol.model = upper(['''', upper(p.Results.aeros), '''']);
                aerosol.amount = aerosol.model;

            else

                aerosol.model = 'USER';
                aerosol.amount = aerosol.model;
                aerosol.alpha1 = p.Results.alpha1;
                aerosol.alpha2 = p.Results.alpha2;
                aerosol.omegl = p.Results.omegl;
                aerosol.gg = p.Results.gg;
                aerosol.flag = 0;

            end
        end

    end

end
