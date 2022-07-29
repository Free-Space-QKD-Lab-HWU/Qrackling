classdef SpectralFilter
    properties
        N = 0;
        files = {string.empty(0)};
        wavelengths = [];
        transmission = [];
        stepSize;
    end

    methods
        function SpectralFilter = SpectralFilter(varargin)
            p = inputParser;
            addParameter(p, 'input_file', []);
            addParameter(p, 'wavelengths', []);
            addParameter(p, 'transmission', []);
            parse(p, varargin{:});

            %if isempty(p.Results.input_file)
            if all(arrayfun(@isempty, [p.Results.input_file, ...
                                       p.Results.wavelengths, ...
                                       p.Results.transmission]))
                error(['No paths to input_file provided.', ...
                       newline, 'Supply either:', ...
                       newline, char(9), 'a single path to a file,', ...
                       newline, char(9), 'a cell array of filepaths, or' ...
                       newline, char(9), 'wavelength and transmission data for a single filter']);
            end

            if sum(arrayfun(@isempty, [p.Results.wavelengths, ...
                                      p.Results.transmission])) ~= 0;
                SpectralFilter.wavelengths = p.Results.wavelengths;
                SpectralFilter.transmission = p.Results.transmission;
                disp(1);
                return
            end

            if ~iscell(p.Results.input_file)
                [SpectralFilter, wl, tr] = read_file(SpectralFilter, ...
                                                     input_file=p.Results.input_file);
                SpectralFilter.files{1} = p.Results.input_file;
                SpectralFilter.wavelengths = wl;
                SpectralFilter.transmission = tr;
                cache_wavelengths = wl;
                cache_transmission = tr;
            else
                N = length(p.Results.input_file);
                cache_wavelengths = {};
                cache_transmission = {};
                for i = 1 : N
                    [SpectralFilter, wl, tr] = read_file(SpectralFilter, ...
                                                         input_file=p.Results.input_file{i});
                    SpectralFilter.files{i} = p.Results.input_file;
                    cache_wavelengths{i} = wl;
                    cache_transmission{i} = tr;
                end
            end

            if 1 < SpectralFilter.N
                [SpectralFilter, j] = maxStep(SpectralFilter, cache_wavelengths);
                max_step = max(SpectralFilter.stepSize);
                SpectralFilter.wavelengths = cache_wavelengths{j};
                SpectralFilter.transmission = cache_transmission{j};

                I = (1 : SpectralFilter.N);
                for i = I(~ismember(I, [j]))
                    SpectralFilter = interpolate_onto(SpectralFilter, ...
                                                      cache_wavelengths{i}, ...
                                                      cache_transmission{i});
                end
            end
        end

        function [SpectralFilter, wavelengths, transmission] = read_file(SpectralFilter, varargin)
            p = inputParser;
            addParameter(p, 'input_file', []);
            addParameter(p, 'wavelength', 'wavelength');
            addParameter(p, 'transmission', 'transmission');
            parse(p, varargin{:});

            if isempty(p.Results.input_file)
                error('No input_file given');
            end

            if ~isfile(p.Results.input_file)
                error('File does not exist or path to file is incorrect');
            end

            table = readtable(p.Results.input_file, VariableNamingRule='preserve');
            SpectralFilter.N = SpectralFilter.N + 1;

            wavelengths = get_column_from_name(SpectralFilter, ...
                                               table, ...
                                               p.Results.wavelength);

            transmission = get_column_from_name(SpectralFilter, ...
                                                table, ...
                                                p.Results.transmission) ./ 100;
        end

        function column = get_column_from_name(self, table, column_name)
            fields = fieldnames(table);
            [Nx, Ny] = size(fields);
            N = Nx;
            i = 1;
            for i = 1 : N
                if contains(lower(fields{i}), lower(column_name))
                    break;
                end
            end
            column = table.(fields{i})';
        end

        function [SpectralFilter, j] = maxStep(SpectralFilter, wl)
            j = 0;
            if 1 == SpectralFilter.N
                SpectralFilter.stepSize = stepsize(wl);
                return; 
            end

            SpectralFilter.stepSize = zeros(1, SpectralFilter.N);
            step = 0;
            j = 1;
            for i = 1 : SpectralFilter.N
                SpectralFilter.stepSize(i) = stepsize(SpectralFilter, wl{i});
                if step < SpectralFilter.stepSize(i)
                    j = i;
                end
            end
        end

        function s = stepsize(self, arr)
            l = length(arr);
            if ~(mod(l, 2) == 0);
                l = l - 1;
            end
            s = mean(abs(arr(2:2:l) - arr(1:2:l)));
        end

        function SpectralFilter = interpolate_onto(SpectralFilter, wl, tr)
            pw_poly = interp1(wl, tr, 'cubic', 'pp');
            interpolated = ppval(pw_poly, SpectralFilter.wavelengths);
            SpectralFilter.transmission = SpectralFilter.transmission ...
                                          .* interpolated;
        end

        function SpectralFilter = add_from_file(self, input_file)
            [SpectralFilter, wl, tr] = self.read_file(input_file=input_file);
            SpectralFilter = interpolate_onto(self, wl, tr);
        end

        function SpectralFilter = add(self, varargin)
            p = inputParser;
            addParameter(p, 'spectral_filter', []);
            addParameter(p, 'input_file', '');
            addParameter(p, 'wavelengths', []);
            addParameter(p, 'transmission', []);
            parse(p, varargin{:})

            if ~isempty(p.Results.spectral_filter)
                SpectralFilter = interpolate_onto(self, ...
                                    p.Results.spectral_filter.wavelengths, ...
                                    p.Results.spectral_filter.transmission);
                return
            end

            if ~isempty(p.Results.input_file)
                SpectralFilter = add_from_file(self, p.Results.input_file);
                return
            end

            if ~any(arrayfun(isempty, [p.Results.wavelengths, p.Results.transmission]))
                SpectralFilter = interpolate_onto(SpectralFilter, ...
                                                  p.Results.wavelengths, ...
                                                  p.Results.transmission);
                return
            end

        end

    end
end
