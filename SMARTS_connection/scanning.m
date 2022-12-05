classdef scanning < card

    properties

        filtering;
        wavelength_min;
        wavelength_max;
        step;
        fwhm;

    end

    methods

        function scanning = scanning(varargin)

            scanning.card_type = 'ISCAN';
            scanning.card_num = 14;
            scanning.groups = {{}, {'wavelength_min', 'wavelength_max', ...
                                'step', 'fwhm'}};
            scanning.suffix = {'', 'a'};

            p = inputParser;
            addParameter(p, 'filtering', nan);
            addParameter(p, 'wavelength_min', 280);
            addParameter(p, 'wavelength_max', 4000);
            addParameter(p, 'step', nan);
            addParameter(p, 'fwhm', nan);

            parse(p, varargin{:});

            scanning.flag = 0;
            
            if ~any(isnan([p.Results.filtering, p.Results.wavelength_min, ...
                           p.Results.wavelength_max, p.Results.step, ...
                           p.Results.fwhm]))

                assert(p.Results.filtering == 0 | p.Results.filtering == 1, ...
                       '"Filtering" must be -> {0: Gaussian, 1: Triangular}');

                assert(p.Results.wavelength_max - p.Results.wavelength_min ...
                       > 2 * p.Results.fwhm, ...
                       '"wavelength_max" - "wavelength_min" > 2 * "fwhm" must hold');
            end
                scanning.flag = 1;
                scanning.wavelength_min = p.Results.wavelength_min;
                scanning.wavelength_max = p.Results.wavelength_max;
                scanning.step = p.Results.step;
                scanning.fwhm = p.Results.fwhm;

            

        end

    end

end
