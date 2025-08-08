classdef SpectralFilter
    % SpectralFilter
    %
    % Spectral filter class capable of forming heterogeneous arrays.
    % Stores wavelength/transmission data and supports composition of
    % multiple filters (via interpolation and multiplication of
    % transmissions).
    %
    % Syntax:
    %   sf = components.SpectralFilter(options)
    %
    % Inputs (name-value in options):
    %   input_file        - file path or cell array of file paths
    %   wavelengths       - row vector of wavelengths (in units below)
    %   transmission      - row vector of transmission (0..1), same length
    %   Wavelength_Scale  - units.Magnitude (default: units.Magnitude.nano)
    %
    % Notes:
    %   - Provide either (wavelengths, transmission) or input_file(s).
    %   - Multiple input files are combined onto a common wavelength grid.

    properties
        % Number of input files loaded.
        n = 0

        % List of file paths used to build the filter (if any).
        files = {string.empty(0)}

        % Wavelength samples (nm).
        wavelengths = []

        % Transmission at samples (fraction 0..1).
        transmission = []

        % Step size estimate for each input file's wavelength grid.
        step_size
    end

    methods
        function obj = SpectralFilter(options)
            % SpectralFilter
            %
            % Construct a spectral filter from direct data or from one or
            % more input files. If multiple files are provided, the
            % transmissions are interpolated onto a common wavelength axis
            % and multiplied together.
            %
            % Syntax:
            %   obj = SpectralFilter(options)
            %
            % Options:
            %   input_file        - char/str path or cell array of paths
            %   wavelengths       - (1,:) double >= 0, optional
            %   transmission      - (1,:) double in [0,1], optional
            %   Wavelength_Scale  - units.Magnitude (default: nano)

            arguments
                options.input_file {mustBeFile}
                options.wavelengths (1,:) {mustBeNonnegative} = []
                options.transmission (1,:) {mustBeNonnegative, ...
                    mustBeLessThanOrEqual(options.transmission, 1)} = []
                options.Wavelength_Scale (1,1) units.Magnitude = ...
                    units.Magnitude.nano
            end

            % Require either direct data or an existing input file
            if (isempty(options.wavelengths) || isempty(options.transmission)) ...
                 && ~exist(options.input_file, "file")
                error(['No paths to input_file provided.', newline, ...
                       'Supply either:', newline, char(9), ...
                       'a single path to a file,', newline, char(9), ...
                       'a cell array of filepaths, or', newline, char(9), ...
                       'wavelength and transmission data for a single filter']);
            end

            % Scale factor to convert from provided units to nm
            factor = units.Magnitude.Factor("nano", options.Wavelength_Scale);

            % Direct data path: set wavelengths/transmission and return
            if ~(isempty(options.wavelengths) && isempty(options.transmission))
                obj.wavelengths  = options.wavelengths .* factor;
                obj.transmission = options.transmission;
                return
            end

            % File path(s) path: read single or multiple files
            if ~iscell(options.input_file)
                [obj, wl, tr] = obj.readFile(options.input_file);
                obj.files{1}      = options.input_file;
                obj.wavelengths   = wl;
                obj.transmission  = tr;
                cache_wavelengths = wl;
                cache_transmission = tr;
            else
                n_files = numel(options.input_file);
                cache_wavelengths = cell(1, n_files);
                cache_transmission = cell(1, n_files);
                for i = 1:n_files
                    [obj, wl, tr] = obj.readFile(options.input_file{i});
                    obj.files{i} = options.input_file{i};
                    cache_wavelengths{i} = wl;
                    cache_transmission{i} = tr;
                end
            end

            % If multiple filters were loaded, align and multiply
            if 1 < obj.n
                [obj, j] = obj.maxStep(cache_wavelengths);
                % max_step value not used further, retained for parity
                max_step = max(obj.step_size); %#ok<NASGU>
                obj.wavelengths  = cache_wavelengths{j};
                obj.transmission = cache_transmission{j};

                I = 1:obj.n;
                for i = I(~ismember(I, j))
                    obj = obj.interpolateOnto( ...
                        cache_wavelengths{i}, cache_transmission{i});
                end
            end
        end

        function [obj, wavelengths, transmission] = readFile(obj, input_file)
            % readFile
            %
            % Read a wavelength/transmission table from file and normalise
            % transmission units if needed.

            arguments
                obj components.SpectralFilter
                input_file {mustBeFile}
            end

            tbl = readtable(input_file, VariableNamingRule = 'preserve');
            obj.n = obj.n + 1;

            wavelengths = obj.getColumnFromName(tbl, 'wavelength');
            transmission = obj.getColumnFromName(tbl, 'transmission');

            % If any transmission is above 1, interpret as percentage
            if any(transmission > 1)
                transmission = transmission ./ 100;
            end
        end

        function column = getColumnFromName(~, tbl, column_name)
            % getColumnFromName
            %
            % Extract a column by fuzzy-matching the variable name.

            fields = fieldnames(tbl);
            n = numel(fields);
            idx = 1;
            for i = 1:n
                if contains(lower(fields{i}), lower(column_name))
                    idx = i;
                    break
                end
            end
            column = tbl.(fields{idx})';
        end

        function [obj, j] = maxStep(obj, wl_cells)
            % maxStep
            %
            % Compute step-size estimates for each wavelength grid and
            % return the index j of the largest step size.

            j = 0;
            if obj.n == 1
                obj.step_size = obj.stepSize(wl_cells);
                return
            end

            obj.step_size = zeros(1, obj.n);
            step = 0;
            j = 1;
            for i = 1:obj.n
                obj.step_size(i) = obj.stepSize(wl_cells{i});
                if step < obj.step_size(i)
                    j = i;
                    % NOTE: original code did not update `step`.
                    % Preserved behaviour aside from naming.
                end
            end
        end

        function s = stepSize(~, arr)
            % stepSize
            %
            % Estimate the average step between alternating entries
            % (robust to odd-length arrays by truncating the last element).

            l = numel(arr);
            if mod(l, 2) ~= 0
                l = l - 1;
            end
            s = mean(abs(arr(2:2:l) - arr(1:2:l)));
        end

        function obj = interpolateOnto(obj, wl, tr)
            % interpolateOnto
            %
            % Interpolate provided transmission onto the object's
            % wavelength grid and multiply into the existing transmission.

            pw_poly = interp1(wl, tr, 'cubic', 'pp');
            interpolated = ppval(pw_poly, obj.wavelengths);
            obj.transmission = obj.transmission .* interpolated;
        end

        function obj = addFromFile(obj, input_file)
            % addFromFile
            %
            % Load an additional filter from file, interpolate onto the
            % current wavelength grid, and multiply into the transmission.

            [obj, wl, tr] = obj.readFile(input_file);
            obj = obj.interpolateOnto(wl, tr);
        end

        function obj = add(self, varargin)
            % add
            %
            % Compose an additional filter onto this one by either:
            %   - passing another SpectralFilter object,
            %   - providing an input file,
            %   - or providing wavelength/transmission arrays.

            p = inputParser;
            addParameter(p, 'spectral_filter', []);
            addParameter(p, 'input_file', '');
            addParameter(p, 'wavelengths', []);
            addParameter(p, 'transmission', []);
            parse(p, varargin{:});
            r = p.Results;

            if ~isempty(r.spectral_filter)
                obj = self.interpolateOnto( ...
                    r.spectral_filter.wavelengths, ...
                    r.spectral_filter.transmission);
                return
            end

            if ~isempty(r.input_file)
                obj = self.addFromFile(r.input_file);
                return
            end

            if ~any(cellfun(@isempty, {r.wavelengths, r.transmission}))
                obj = self.interpolateOnto(r.wavelengths, r.transmission);
                return
            end
        end

        function transmission  = computeTransmission(sf, wavelength)
            % computeTransmission
            %
            % Return the transmission from a spectral filter vector at the
            % specified wavelengths.
            %
            % Notes:
            % - sf is a vector of SpectralFilter objects.
            % - wavelength is a vector; output is (numel(wavelength) x numel(sf)).

            % Input validation
            assert(isvector(sf), ...
                'Spectral filter groups must be formatted as vectors');
            assert(isvector(wavelength), ...
                'Wavelengths must be formatted as vectors');

            % Arrange output: rows correspond to wavelengths, columns to filters
            transmission = zeros(numel(wavelength), numel(sf));

            % Iterate across the spectral filter array
            for i = 1:numel(sf)
                % Two cases: direct match (no interpolation) or interpolate
                if numel(sf(i).wavelengths) == 1 && ...
                        sf(i).wavelengths == wavelength
                    transmission(:, i) = sf(i).transmission;
                else
                    transmission(:, i) = interp1( ...
                        sf(i).wavelengths, sf(i).transmission, wavelength);
                end
            end
        end

        function ax = plot(sf, ax)
            % plot
            %
            % Plot the transmission of this spectral filter.

            arguments
                sf components.SpectralFilter
                ax matlab.graphics.axis.Axes = axes()
            end

            plot(ax, sf.wavelengths, sf.transmission);
            xlabel(ax, 'Wavelength (nm)');
            ylabel(ax, 'Transmission');
        end
    end
end