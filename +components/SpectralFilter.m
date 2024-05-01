classdef SpectralFilter
    %% a spectral filter class which inherits the ability to form heterogenous arrays

    
    properties
        N = 0;
        files = {string.empty(0)};
        wavelengths = [];
        transmission = [];
        stepSize;
    end

    methods
        function SpectralFilter = SpectralFilter(options)
            arguments
                options.input_file {mustBeFile}
                options.wavelengths (1,:) {mustBeNonnegative} = []
                options.transmission (1,:) {mustBeNonnegative,mustBeLessThanOrEqual(options.transmission,1)} = []
                options.Wavelength_Scale (1,1) units.Magnitude = units.Magnitude.nano;
            end

            %if isempty(options.input_file)
            if (isempty(options.wavelengths)||isempty(options.transmission))&&~exist(options.input_file,"file")
                error(['No paths to input_file provided.', ...
                    newline, 'Supply either:', ...
                    newline, char(9), 'a single path to a file,', ...
                    newline, char(9), 'a cell array of filepaths, or' ...
                    newline, char(9), 'wavelength and transmission data for a single filter']);
            end

            factor = units.Magnitude.Factor("nano", options.Wavelength_Scale);

            if ~(isempty(options.wavelengths)&&isempty(options.transmission))
                SpectralFilter.wavelengths = options.wavelengths .* factor;
                SpectralFilter.transmission = options.transmission;
                return
            end

            if ~iscell(options.input_file)
                [SpectralFilter, wl, tr] = read_file(SpectralFilter, ...
                    options.input_file);
                SpectralFilter.files{1} = options.input_file;
                SpectralFilter.wavelengths = wl;
                SpectralFilter.transmission = tr;
                cache_wavelengths = wl;
                cache_transmission = tr;
            else
                N = length(options.input_file);
                cache_wavelengths = {};
                cache_transmission = {};
                for i = 1 : N
                    [SpectralFilter, wl, tr] = read_file(SpectralFilter, ...
                        options.input_file{i});
                    SpectralFilter.files{i} = options.input_file;
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

        function [SpectralFilter, wavelengths, transmission] = read_file(SpectralFilter, input_file)
            arguments
                SpectralFilter components.SpectralFilter
                input_file {mustBeFile}
            end

            table = readtable(input_file, VariableNamingRule='preserve');
            SpectralFilter.N = SpectralFilter.N + 1;

            wavelengths = get_column_from_name(SpectralFilter, ...
                table,'wavelength');

            transmission = get_column_from_name(SpectralFilter, ...
                table, ...
                'transmission');

            %if any transmission is above 1, this is probably a percentage
            if any(transmission>1)
                transmission=transmission./100;
            end
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
            if ~(mod(l, 2) == 0)
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

        function SpectralFilter = add_from_file(SpectralFilter, input_file)
            [SpectralFilter, wl, tr] = SpectralFilter.read_file(input_file);
            SpectralFilter = interpolate_onto(SpectralFilter, wl, tr);
        end

        function SpectralFilter = add(self, varargin)
            p = inputParser;
            addParameter(p, 'spectral_filter', []);
            addParameter(p, 'input_file', '');
            addParameter(p, 'wavelengths', []);
            addParameter(p, 'transmission', []);
            parse(p, varargin{:})

            if ~isempty(options.spectral_filter)
                SpectralFilter = interpolate_onto(self, ...
                    options.spectral_filter.wavelengths, ...
                    options.spectral_filter.transmission);
                return
            end

            if ~isempty(options.input_file)
                SpectralFilter = add_from_file(self, options.input_file);
                return
            end

            if ~any(arrayfun(@isempty, [options.wavelengths, options.transmission]))
                SpectralFilter = interpolate_onto(SpectralFilter, ...
                    options.wavelengths, ...
                    options.transmission);
                return
            end

        end

        function Transmission  = ComputeTransmission(SpectralFilter,Wavelength)
                %%COMPUTETRANSMISSION return the transmission from a spectral
                %%filter vector at the specified wavelengths

                %% input validation
                assert(isvector(SpectralFilter),'Spectral filter groups must be formatted as vectors')
                assert(isvector(Wavelength),'Wavelengths must be formatted as vectors')

                %% sort into rows and columns
                %formally, the spectral filters will be a row vector and
                %wavelengths a column vector. The transmission data is formatted
                %so that it is the result of the spectral filter of its row and
                %the wavelength of its column
                Transmission=zeros(numel(Wavelength),numel(SpectralFilter));

                %% iterating over the elements of the spectral filter array
                for i=1:numel(SpectralFilter)

                    %% two cases, either wavelength is already set correctly or interpolation is required
                    if numel(SpectralFilter(i).wavelengths)==1&&SpectralFilter(i).wavelengths==Wavelength
                        Transmission(:,i)=SpectralFilter(i).transmission;
                    else
                    %interpolate onto spectral filter data
                    Transmission(:,i)  = interp1(SpectralFilter(i).wavelengths,SpectralFilter(i).transmission,Wavelength);
                    end
                end
        end
    
        function Axes = Plot(SpectralFilter,Axes)
            %%PLOT plot the transmission of this spectral filter
            arguments
                SpectralFilter components.SpectralFilter
                Axes matlab.graphics.axis.Axes = axes();
            end

            plot(Axes,SpectralFilter.wavelengths,SpectralFilter.transmission)
            xlabel(Axes,'Wavelength (nm)')
            ylabel(Axes,'Transmission')
        end
    end
end
