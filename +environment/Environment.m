classdef Environment
    % Environment
    %
    % Describes the conditions around a receiver, including atmospheric
    % attenuation and background light.
    %
    % Syntax:
    % Env = environment.Environment(headings, elevations, wavelengths, ...
    %     spectral_radiance, attenuation, 'attenuation_unit', attenuation_unit)
    %
    % Supports loading from file and provides static utility methods.


    %% Properties

    properties
        % Different wavelengths have different environment data
        wavelengths (1, :) {mustBeNumeric, mustBeNonnegative}

        % Coordinate system (in degrees)
        headings (1, :) {mustBeNumeric}
        elevations (1, :) {mustBeNumeric}

        % A standardised model for turbulence
        turbulence_model (1,1) environment.TurbulenceModel = ...
            environment.TurbulenceModel('Preset', 'HV5-7')

        % Atmospheric attenuation (in absolute terms) for the full atmosphere
        % thickness. Dimensions: [numel(wavelengths), numel(headings), numel(elevations)]
        attenuation {mustBeNumeric, mustBeNonnegative, ...
            mustBeLessThanOrEqual(attenuation, 1)}

        % Unit of attenuation
        attenuation_unit {mustBeMember(attenuation_unit, ["probability", "dB"])} = "probability"

        % Background light: spectral radiance (W/m^2-sr-nm)
        spectral_radiance {mustBeNumeric, mustBeNonnegative}

        % Behaviour when interpolating outside the provided data range
        outside_data_limits_action {mustBeMember(outside_data_limits_action, ...
            {'none', 'warning', 'error'})} = 'none'
    end


    %% Static Methods

    methods (Static)

        function Env = load(filename)
            % Load
            %
            % Create an Environment object from a .mat file.
            %
            % Syntax:
            % Env = environment.Environment.Load(filename)
            %
            % Inputs:
            % filename - (1x1) string or char, path to .mat file containing environment data
            %
            % Outputs:
            % Env - (1x1) environment.Environment object

            arguments (Input)
                filename
            end

            load(filename, 'headings')
            load(filename, 'elevations')
            load(filename, 'wavelengths')
            load(filename, 'spectral_radiance')
            load(filename, 'attenuation')
            load(filename, 'attenuation_unit')

            Env = environment.Environment(headings, elevations, wavelengths, ...
                spectral_radiance, attenuation, 'attenuation_unit', attenuation_unit);
        end


        function bool = isIncreasing(vector)
            % IsIncreasing
            %
            % Determine if a numeric vector is strictly increasing.
            %
            % Syntax:
            % bool = environment.Environment.IsIncreasing(vector)
            %
            % Inputs:
            % vector - (1xN) numeric
            %
            % Outputs:
            % bool - (1x1) logical

            if isscalar(vector)
                bool = true;
                return
            end

            for i = 2:numel(vector)
                if vector(i) <= vector(i - 1)
                    bool = false;
                    return
                end
            end

            bool = true;
        end


        function Env = empty()
            % empty
            %
            % Return an empty Environment object.
            %
            % Syntax:
            % Env = environment.Environment.empty()
            %
            % Outputs:
            % Env - (1x1) empty environment.Environment

            Env = environment.Environment(0, 0, 0, 0, 0);
        end

    end
    %% Public methods of Environment
    methods

        function Env = Environment(headings, elevations, wavelengths, ...
                spectral_radiance, attenuation, options)
            % Environment
            %
            % Construct an environment object.
            %
            % Syntax:
            % Env = environment.Environment(headings, elevations, wavelengths, ...
            %     spectral_radiance, attenuation, options)
            %
            % Inputs:
            % headings - (1xH) numeric vector in degrees, 0 to 360
            % elevations - (1xE) numeric vector in degrees, -90 to 90
            % wavelengths - (1xW) numeric vector, nonnegative
            % spectral_radiance - (W x H x E) numeric, nonnegative
            % attenuation - (W x H x E) numeric, nonnegative
            % options.attenuation_unit - string, "probability" or "dB" (default "probability")
            % options.turbulence_model - char, one of {'HV5-7','2HV5-7','HV10-10','HV15-12'} (default 'HV5-7')
            %
            % Outputs:
            % Env - (1x1) environment.Environment

            arguments
                headings {mustBeNumeric, mustBeVector, mustBeInRange(headings, 0, 360)}
                elevations {mustBeNumeric, mustBeVector, mustBeInRange(elevations, -90, 90)}
                wavelengths {mustBeNumeric, mustBeNonnegative, mustBeVector}
                spectral_radiance {mustBeNumeric, mustBeNonnegative}
                attenuation {mustBeNumeric, mustBeNonnegative} % mustBeLessThanOrEqual(attenuation,1)}
                options.attenuation_unit {mustBeMember(options.attenuation_unit, ["probability", "dB"])} = "probability"
                options.turbulence_model {mustBeMember(options.turbulence_model, {'HV5-7','2HV5-7','HV10-10','HV15-12'})} = 'HV5-7'
            end

            % Sort, tidy and bound inputs
            % Heading, elevation and wavelength must be increasing
            assert(environment.Environment.isIncreasing(headings), 'headings must be increasing');
            assert(environment.Environment.isIncreasing(elevations), 'elevations must be increasing');
            assert(environment.Environment.isIncreasing(wavelengths), 'wavelengths must be increasing');

            % All vectors should be rows
            if iscolumn(headings)
                headings = headings';
            end
            if iscolumn(elevations)
                elevations = elevations';
            end
            if iscolumn(wavelengths)
                wavelengths = wavelengths';
            end

            % Store data to object
            Env.headings = headings;
            Env.elevations = elevations;
            Env.wavelengths = wavelengths;
            Env.spectral_radiance = spectral_radiance;
            Env.attenuation = attenuation;
            Env.attenuation_unit = options.attenuation_unit;

            % Check that sizes are compatible
            mustHaveCompatibleData(Env);
        end


        function save(Env, filename)
            % save
            %
            % Save the data in the current environment to a .mat file.
            %
            % Syntax:
            % environment.Environment.Save(filename)
            %
            % Inputs:
            % Env - (1x1) environment.Environment
            % filename - (1x1) text, path to output .mat file

            arguments
                Env environment.Environment
                filename {mustBeText}
            end

            % Validate sizes
            mustHaveCompatibleData(Env);

            % Store local copies for serialization
            headings = Env.headings; %#ok<*PROPLC>
            elevations = Env.elevations;
            wavelengths = Env.wavelengths;
            spectral_radiance = Env.spectral_radiance;
            attenuation = Env.attenuation;
            attenuation_unit = Env.attenuation_unit;

            save(filename, 'headings', 'elevations', 'wavelengths', ...
                'spectral_radiance', 'attenuation', 'attenuation_unit');
        end


        function Env = mustHaveCompatibleData(Env)
            % mustHaveCompatibleData
            %
            % Validate that all arrays have the correct dimensions.
            %
            % Syntax:
            % Env = mustHaveCompatibleData(Env)
            %
            % Inputs:
            % Env - (1x1) environment.Environment
            %
            % Outputs:
            % Env - (1x1) environment.Environment (unchanged)

            % Get dimensions of axes
            n_headings = numel(Env.headings);
            n_elevations = numel(Env.elevations);
            n_wavelengths = numel(Env.wavelengths);

            correct_size = [n_wavelengths, n_headings, n_elevations];

            % Check dimensions of data
            assert(isequal(size(Env.attenuation, [1, 2, 3]), correct_size), ...
                'attenuation array is wrong size');
            assert(isequal(size(Env.spectral_radiance, [1, 2, 3]), correct_size), ...
                'spectral_radiance array is wrong size');
        end
        function interp_data = interp(Env, data, headings, elevations, wavelengths)
            % Interp
            %
            % Output a sample of the requested data, interpolated in heading,
            % elevation, and wavelength.
            %
            % Syntax:
            % interp_data = Env.Interp(data, headings, elevations, wavelengths)
            %
            % Inputs:
            % Env        - (1x1) environment.Environment
            % data       - string, one of {'attenuation', 'spectral_radiance', 'attenuation dB'}
            % headings   - numeric array, degrees [0-360]
            % elevations - numeric array, degrees [-90-90]
            % wavelengths - numeric array
            %
            % Outputs:
            % interp_data - numeric array of interpolated values

            arguments
                Env environment.Environment
                data {mustBeMember(data, {'attenuation', 'spectral_radiance', 'attenuation dB'})}
                headings {mustBeNumeric, mustBeInRange(headings, 0, 360)}
                elevations {mustBeNumeric, mustBeInRange(elevations, -90, 90)}
                wavelengths {mustBeNumeric}
            end

            % Input validation
            assert(all(size(headings) == size(elevations)), ...
                'requested heading and elevation arrays must be of same size')
            assert(isscalar(wavelengths) || all(size(wavelengths) == size(elevations)), ...
                'wavelength must be either scalar or the same size as heading and elevation')

            % Make scalar wavelength into an array matching headings/elevations
            if isscalar(wavelengths)
                wavelengths = wavelengths * ones(size(headings));
            end

            %% Bound heading to 0-360
            headings = wrapTo360(headings);

            % Get relevant data array
            switch data
                case 'attenuation'
                    Array = Env.attenuation;
                case 'spectral_radiance'
                    Array = Env.spectral_radiance;
            end

            %% Interpolation (including wraparound in heading)
            if isscalar(Env.wavelengths)
                interp_data = interpn( ...
                    [Env.headings, Env.headings(1) + 360], ...
                    Env.elevations, ...
                    squeeze([Array; Array(:, 1, :)]), ...
                    headings, ...
                    elevations);

            else
                interp_data = interpn( ...
                    Env.wavelengths, ...
                    [Env.headings, Env.headings(1) + 360], ...
                    Env.elevations, ...
                    [Array, Array(:, 1, :)], ...
                    wavelengths, headings, elevations);

                % Handle elevations below the minimum
                elevations_below_min = Env.elevations(1) > elevations;
                if any(elevations_below_min)
                    interp_data(elevations_below_min) = interpn( ...
                        Env.wavelengths, ...
                        [Env.headings, Env.headings(1) + 360], ...
                        [Array(:, :, 1), Array(:, 1, 1)], ...
                        wavelengths(elevations_below_min), ...
                        headings(elevations_below_min));

                    switch Env.outside_data_limits_action
                        case 'warning'
                            warning('Elevation goes below minimum provided in environment. Using min value of %i degrees', ...
                                Env.elevations(1))
                        case 'error'
                            error('Elevation goes below minimum provided in environment. Using min value of %i degrees', ...
                                Env.elevations(1))
                    end
                end

                % Handle elevations above the maximum
                elevations_above_max = Env.elevations(end) < elevations;
                if any(elevations_above_max)
                    interp_data(elevations_above_max) = interpn( ...
                        Env.wavelengths, ...
                        [Env.headings, Env.headings(1) + 360], ...
                        [Array(:, :, end), Array(:, 1, end)], ...
                        wavelengths(elevations_above_max), ...
                        headings(elevations_above_max));

                    switch Env.outside_data_limits_action
                        case 'warning'
                            warning('Elevation goes above maximum provided in environment. Using max value of %i degrees', ...
                                Env.elevations(end))
                        case 'error'
                            error('Elevation goes above maximum provided in environment. Using max value of %i degrees', ...
                                Env.elevations(end))
                    end
                end
            end

            %% Failure check
            if any(isnan(interp_data))
                warning('Interpolation failed. This was not corrected by Environment interpolator')
                interp_data(isnan(interp_data)) = 0;
            end

            %% Convert attenuation to dB if requested
            if isequal(data, 'attenuation dB')
                temp = units.Loss(interp_data);
                interp_data = temp.dB;
            end

        end


        function plot(Env, DataType, options)
            % plot
            %
            % Plot data from a skyscan in a consistent polar format.
            %
            % Syntax:
            % Env.plot(DataType, options)
            %
            % Inputs:
            % DataType - string, one of:
            %   {'attenuation', 'attenuation dB', 'spectral radiance'}
            %
            % Name-Value options:
            % options.Name        - text label for colorbar (default '')
            % options.Colourmap   - colormap name (default 'turbo')
            % options.CLims       - (1x2) numeric color limits [min max] (default [nan, nan])
            % options.Size        - marker size (default 50)
            % options.ColourScale - {'log','linear','auto'} (default 'auto')

            arguments
                Env environment.Environment
                DataType {mustBeMember(DataType, ...
                    {'attenuation', 'attenuation dB', 'spectral radiance'})}
                options.Name {mustBeText} = ''
                options.Colourmap = 'turbo'
                options.CLims (1, 2) {mustBeNumeric} = [nan, nan]
                options.Size {mustBeScalarOrEmpty, mustBeNonnegative} = 50
                options.ColourScale {mustBeMember(options.ColourScale, ...
                    {'log', 'linear', 'auto'})} = 'auto'
            end

            % Prepare data
            % Determine which data to plot
            switch DataType
                case 'attenuation'
                    values = Env.attenuation;
                case 'attenuation dB'
                    values = -10 * log10(Env.attenuation);
                case 'spectral radiance'
                    values = Env.spectral_radiance;
            end

            % Headings and elevations grid
            [heading_grid, elevation_grid] = meshgrid(Env.headings, Env.elevations);

            % Enforce some defaults
            if isempty(options.Name)
                switch DataType
                    case 'spectral radiance'
                        options.Name = 'Spectral Radiance (W/m^2 sr nm)';
                    case 'attenuation'
                        options.Name = 'attenuation';
                    case 'attenuation dB'
                        options.Name = 'attenuation (dB)';
                end
            end

            if all(isnan(options.CLims))
                % If no color limits provided, set based on data
                switch DataType
                    case 'spectral radiance'
                        options.CLims = [ ...
                            median(values(~isinf(values)), "all") / 100, ...
                            max(values(~isinf(values)), [], 'all')];
                    case 'attenuation'
                        options.CLims = [0, 1];
                    case 'attenuation dB'
                        options.CLims = [ ...
                            min(values(~isinf(values)), [], "all"), ...
                            median(values(~isinf(values)), 'all') + 10];
                end
            end

            if isequal(options.ColourScale, 'auto')
                switch DataType
                    case 'attenuation'
                        options.ColourScale = 'log';
                    case 'attenuation dB'
                        options.ColourScale = 'linear';
                    case 'spectral radiance'
                        options.ColourScale = 'log';
                end
            end

            % Plot intensity over sky
            % Create a UI figure and polar axes
            sky_fig = uifigure('WindowState', 'maximized');
            axes_handle = polaraxes(sky_fig);

            % Create a scrollbar to allow wavelength to vary
            wavelength_range = [min(Env.wavelengths), max(Env.wavelengths)];
            scrollbar = uislider( ...
                "Value", max(wavelength_range), ...
                "Limits", wavelength_range, ...
                'MajorTicks', wavelength_range(1):100:wavelength_range(2), ...
                'ValueChangedFcn', @(scrollbar, event) UpdatePlot( ...
                scrollbar, axes_handle, values, heading_grid, ...
                elevation_grid, Env.wavelengths, options), ...
                'CreateFcn', @(scrollbar, event) UpdatePlot( ...
                scrollbar, axes_handle, values, heading_grid, ...
                elevation_grid, Env.wavelengths, options), ...
                'Orientation', 'vertical', ...
                'Parent', sky_fig); %#ok<*NASGU>

            label = uilabel( ...
                "Text", 'Wavelength (nm)', ...
                'Position', [50, 65, 400, 35], ...
                'FontSize', 24, ...
                'Parent', sky_fig, ...
                'FontName', get(groot, 'defaultAxesFontName')); %#ok<NASGU>

            function UpdatePlot(scrollbar, axes_handle, ...
                    values, heading_grid, elevation_grid, ...
                    wavelengths_in, options)
                % Prepare plot data
                current_wavelength = scrollbar.Value;
                wavelength_index = round( ...
                    interp1(wavelengths_in, 1:numel(wavelengths_in), current_wavelength));
                current_values = squeeze(values(wavelength_index, :, :))';
                current_values(isinf(current_values)) = nan;

                % Perform plot
                plot_handle = polarscatter(axes_handle, ...
                    deg2rad(heading_grid(:)), elevation_grid(:), ...
                    options.Size, current_values(:), 'filled'); %#ok<NASGU>

                % Prepare axes
                axes_handle.RDir = 'reverse';
                axes_handle.ThetaDir = "clockwise";
                axes_handle.ThetaZeroLocation = 'top';
                axes_handle.RLim = [0, 90];
                axes_handle.RTickLabel = cellfun( ...
                    @(x) append(num2str(x), sprintf('%c', char(176))), ...
                    axes_handle.RTickLabel, 'UniformOutput', false);

                set(axes_handle, 'ColorScale', options.ColourScale)

                colormap(axes_handle, options.Colourmap);
                clim(axes_handle, options.CLims)
                C = colorbar(axes_handle, "eastoutside");
                C.Label.String = options.Name;
                C.Label.FontName = get(groot, "defaultAxesFontName");
                C.Label.FontSize = get(groot, "defaultAxesFontSize");
            end
        end
    end

    methods (Static)
        function counts = countRateFromRadiance(radiance, FOV, receiver_diameter, ...
                filter_width, wavelengths, integration_time)
            % countRateFromRadiance
            %
            % Calculate the number of sky photons coupled into the telescope
            % from spectral radiance.
            %
            % Syntax:
            % counts = environment.Environment.countRateFromRadiance( ...
            %     radiance, FOV, receiver_diameter, filter_width, wavelengths, integration_time)
            %
            % Inputs:
            % radiance           - numeric, spectral radiance (W/m^2 sr nm)
            % FOV                - (1x1) numeric, field of view (radians)
            % receiver_diameter  - (1x1) numeric, telescope diameter (m)
            % filter_width       - (1x1) numeric, filter width (nm)
            % wavelengths        - (:,1) numeric, wavelength samples (nm)
            % integration_time   - (1x1) numeric, seconds (default 1)
            %
            % Outputs:
            % counts - numeric, expected photon counts
            %
            % Ref: Gruneisen, M. T., Eickhoff, M. L., et al. (2021),
            % Adaptive-Optics-Enabled Quantum Communication: A Technique for Daytime
            % Space-To-Earth Links, 10.1103/PhysRevApplied.16.014067.

            arguments
                radiance {mustBeNumeric}
                FOV (1, 1) {mustBeNumeric}
                receiver_diameter (1, 1) {mustBeNumeric}
                filter_width (1, 1) {mustBeNumeric}
                wavelengths (:, 1) {mustBeNumeric}
                integration_time (1, 1) {mustBeNumeric} = 1
            end

            size_radiance = size(radiance);
            n_wavelengths = numel(wavelengths);

            assert(n_wavelengths == size_radiance(1), ...
                ['Incompatible sizes for radiance and wavelength. ', ...
                'Must be size(radiance) = (A, B) with size(wavelengths) = (1, A)']);

            % wavelengths_nm = units.Magnitude.Convert(unit, "nano", wavelengths);
            % filter_width_nm = units.Magnitude.Convert(unit, "nano", filter_width);

            wavelengths_nm = units.Magnitude.Convert(unit, "none", wavelengths);
            filter_width_nm = units.Magnitude.Convert(unit, "none", filter_width);

            h = 6.62607015 * 10^-34; % Planck's constant
            c = 299792458; % speed of light

            solid_angle = pi * FOV^2 / 4;
            area = pi * receiver_diameter^2 / 4;

            counts = ( ...
                radiance .* solid_angle .* area ...
                .* wavelengths_nm ...
                .* filter_width_nm ...
                .* integration_time ) ...
                / (h * c);
        end
    end
end