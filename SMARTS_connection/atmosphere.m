classdef atmosphere < card
    properties

        air_temperature{mustBeNumeric} = 0;

        relative_humidity{mustBeNumeric} = 0;

        daily_temperature{mustBeNumeric} = 0;

        reference_atmosphere{mustBeText} = '';
        referernce_atmosphere_opts = {'USSA', 'MLS', 'MLW', 'SAS', 'SAW', ...
                                      'TRL', 'STS', 'STW', 'AS', 'AW'};

        season{mustBeText} = '';
        season_opt = {'SUMMER', 'WINTER'};

    end

    methods

        function atmosphere = atmosphere(varargin)

            atmosphere.card_type = 'IATMOS';
            atmosphere.card_num = 3;
            atmosphere.groups = { {'air_temperature', 'relative_humidity', ...
                                   'season', 'daily_temperature'}, ...
                                 {'reference_atmosphere'} };
            atmosphere.suffix = {'a', 'a'};

            p = inputParser;
            addParameter(p, 'tair', 0);
            addParameter(p, 'rh', 0);
            addParameter(p, 'season', '');
            addParameter(p, 'tday', 0);
            addParameter(p, 'atmos', '');

            parse(p, varargin{:});

            if any(ismember(atmosphere.referernce_atmosphere_opts, ...
                            p.Results.atmos))
                atmosphere.reference_atmosphere = ['''', ...
                    upper(p.Results.atmos), ''''];
                atmosphere.flag = 1;
                return

            elseif ~isempty(p.Results.season)
                atmosphere.air_temperature = p.Results.tair;
                atmosphere.relative_humidity = p.Results.rh;
                atmosphere.daily_temperature = p.Results.tday;

                if strcmp('SPRING', upper(p.Results.season));
                    atmosphere.season = ['''', 'SUMMER', ''''];
                elseif strcmp('AUTUMN', upper(p.Results.season))
                    atmosphere.season = ['''', 'WINTER', ''''];
                else
                    if any(ismember(atmosphere.season_opt, upper(p.Results.season)))
                        atmosphere.season = upper(p.Results.season);
                    else
                        error('No season set');
                    end
                end
                atmosphere.flag = 0;

            else
                atmosphere.flag = 0;
            end
        end

    end
end
