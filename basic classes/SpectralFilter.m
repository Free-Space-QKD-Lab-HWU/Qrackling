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
            addParameter(p, 'data', []);
            parse(p, varargin{:});

            if isempty(p.Results.data)
                error(['No paths to data provided.', ...
                       newline, 'Supply either:', ...
                       newline, char(9), 'a single path to a file or', ...
                       newline, char(9), 'a cell array of filepaths']);
            end

            if ~iscell(p.Results.data)
                [SpectralFilter, wl, tr] = read_file(SpectralFilter, ...
                                                     data=p.Results.data);
                SpectralFilter.files{1} = p.Results.data;
                SpectralFilter.wavelengths = wl;
                SpectralFilter.transmission = tr;
                cache_wavelengths = wl;
                cache_transmission = tr;
            else
                N = length(p.Results.data);
                cache_wavelengths = {};
                cache_transmission = {};
                for i = 1 : N
                    [SpectralFilter, wl, tr] = read_file(SpectralFilter, ...
                                                         data=p.Results.data{i});
                    SpectralFilter.files{i} = p.Results.data;
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
            addParameter(p, 'data', []);
            addParameter(p, 'wavelength', []);
            addParameter(p, 'transmission', []);
            parse(p, varargin{:});

            if isempty(p.Results.data)
                error('No data given');
            end

            if ~isfile(p.Results.data)
                error('File does not exist or path to file is incorrect');
            end

            table = readtable(p.Results.data, VariableNamingRule='preserve');
            SpectralFilter.N = SpectralFilter.N + 1;

            if isempty(p.Results.wavelength)
                wavelengths = get_column_from_name(SpectralFilter, ...
                                                   table, ...
                                                   'wavelength');
            else
                wavelengths = get_column_from_name(SpectralFilter, ...
                                                   table, ...
                                                   p.Results.wavelength);
            end

            if isempty(p.Results.transmission)
                transmission = get_column_from_name(SpectralFilter, ...
                                                    table, ...
                                                    'transmission') ./ 100;
            else
                transmission = get_column_from_name(SpectralFilter, ...
                                                    table, ...
                                                    p.Results.transmission) ./ 100;
            end
        end

        function column = get_column_from_name(self, table, column_name)
            fields = fieldnames(table);
            i = 1;
            found = false;
            while found == false
                if contains(lower(fields{i}), lower(column_name))
                    found = true;
                    break;
                end
                i = i + 1;
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

        function SpectralFilter = add_filter(self, data)
            [SpectralFilter, wl, tr] = self.read_file(data=data);
            SpectralFilter = interpolate_onto(SpectralFilter, wl, tr);
        end

    end
end
