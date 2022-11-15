classdef extra_spectral < card

    properties

        Spectral_Min{mustBeNumeric, ...
                     mustBeGreaterThanOrEqual(Spectral_Min, 280), ...
                     mustBeLessThanOrEqual(Spectral_Min, 4000)};

        Spectral_Max{mustBeNumeric, ...
                     mustBeGreaterThanOrEqual(Spectral_Max, 280), ...
                     mustBeLessThanOrEqual(Spectral_Max, 4000)};

        correction_factor;
        solar_constant;

    end

    methods

        function extra_spectral = extra_spectral(varargin)

            extra_spectral.no_flag = true;
            extra_spectral.card_type = '';
            extra_spectral.card_num = 11;
            extra_spectral.groups = {{'Spectral_Min', 'Spectral_Max', ...
                                      'correction_factor', 'solar_constant'}};
            extra_spectral.suffix = {''};

            p = inputParser;
            addParameter(p, 'wlmin', 280);
            addParameter(p, 'wlmax', 4000);
            addParameter(p, 'suncor', 1);
            addParameter(p, 'solarc', 1367);

            parse(p, varargin{:});

            extra_spectral.flag = 0;
            extra_spectral.Spectral_Min = p.Results.wlmin;
            extra_spectral.Spectral_Max = p.Results.wlmax;
            extra_spectral.correction_factor = p.Results.suncor;
            extra_spectral.solar_constant = p.Results.solarc;

        end

    end

end
