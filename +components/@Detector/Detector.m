classdef Detector
    % Detector
    %
    % Single‑photon detector model for an optical ground station (OGS).
    % Describes wavelength, timing, efficiency, noise, and polarization
    % characteristics used in QKD link simulations.
    %
    % Syntax:
    %   det = components.Detector(...)
    %
    % Additional construction details depend on the full class definition.

    properties

        % Wavelength (nm) used for communication.
        wavelength {mustBeScalarOrEmpty, mustBePositive}

        % QBER contribution due to timing jitter (fraction in [0, 1]).
        qber_jitter { ...
            mustBeNonnegative, ...
            mustBeScalarOrEmpty, ...
            mustBeLessThanOrEqual(qber_jitter, 1) ...
            }

        % Loss due to timing jitter (absolute) — computed on construction.
        jitter_loss {mustBeNonnegative}

        % Spectral filter model.
        spectral_filter

        % Width of the time gate used (s).
        time_gate_width {mustBePositive, mustBeScalarOrEmpty}

        % Repetition rate (Hz).
        repetition_rate {mustBeNonnegative, mustBeScalarOrEmpty}

        % Timing‑jitter histogram (counts per bin).
        jitter_histogram

        % Histogram bin width (s).
        histogram_bin_width

        % Total counts accumulated.
        total_counts = 0

        % Cumulative distribution function (CDF) of jitter.
        cdf

        % Probability density function (PDF) of jitter.
        pdf

        % full-width half-maximum duration of jitter (in s)
        fwhm

        % Polarization compensation error (rms, degrees). Poor compensation
        % increases QBER. Default value modeled after Micius.
        polarisation_error {mustBeScalarOrEmpty, mustBeNonnegative} = asind(1/280)

        % Supported wavelength range (nm) or model object.
        wavelength_range

        % Detector dead time (s).
        dead_time double

        % Efficiency model (structure or array).
        efficiencies

        % Overall detection efficiency (fraction in (0, 1]).
        detection_efficiency { ...
            mustBeScalarOrEmpty, ...
            mustBePositive, ...
            mustBeLessThanOrEqual(detection_efficiency, 1) ...
            }

        % Dark‑count rate (counts per second).
        dark_count_rate {mustBeNonnegative, mustBeScalarOrEmpty}

        % Interferometric visibility for phase‑based protocols (in [0, 1]).
        visibility {mustBeInRange(visibility, 0, 1)} = 1

    end

    methods

        % Constructor
        % ---------------------------------------------------------------------
        function obj = Detector( ...
                wavelength, repetition_rate, time_gate_width, ...
                spectral_filter, options)
            % Detector
            %
            % Construct a detector object with properties determined by
            % implementation or preset data.
            %
            % Syntax:
            %   obj = components.Detector( ...
            %       wavelength, repetition_rate, time_gate_width, ...
            %       spectral_filter, options)
            %
            % Inputs:
            %   wavelength        - (1,1) double, wavelength in nm
            %   repetition_rate   - (1,1) double, repetition rate in Hz
            %   time_gate_width   - (1,1) double, time gate width in seconds
            %   spectral_filter   - filter object or numeric width in nm
            %   options           - struct with name-value pairs
            %
            % Outputs:
            %   obj               - Detector object

            arguments
                wavelength double
                repetition_rate double
                time_gate_width double
                spectral_filter
                options.Wavelength_Scale units.Magnitude = 'nano'
                options.Polarisation_Error double = asind(1 / 280)
                options.Preset {mustBeMember(options.Preset, { ...
                    'Excelitas', 'Hamamatsu', 'ID_Qube_NIR', ...
                    'LaserComponents', 'MicroPhotonDevices', ...
                    'PerkinElmer', 'Perfect', ...
                    'QuantumOpus1550_CryogenicAmplifier', ...
                    'QuantumOpus1550_RoomTempAmplifier', ...
                    'none'})} = 'none'
                options.Dark_Count_Rate { ...
                    mustBeNumeric, ...
                    mustBeGreaterThanOrEqual(options.Dark_Count_Rate, 0)}
                options.Dead_Time { ...
                    mustBeNumeric, ...
                    mustBeGreaterThanOrEqual(options.Dead_Time, 0)}
                options.Jitter_Histogram { ...
                    mustBeNumeric, ...
                    mustBeGreaterThanOrEqual(options.Jitter_Histogram, 0)}
                options.Histogram_Bin_Width {mustBeNumeric, mustBePositive}
                options.Wavelength_Range {mustBeNumeric}
                options.Efficiencies { ...
                    mustBeNumeric, ...
                    mustBeGreaterThanOrEqual(options.Efficiencies, 0), ...
                    mustBeLessThanOrEqual(options.Efficiencies, 1)}
            end

            % Implement detector properties
            obj = obj.setWavelength(wavelength, ...
                "Wavelength_Scale", options.Wavelength_Scale);

            obj.time_gate_width = time_gate_width;

            % Two cases for spectral filter: object or numeric width (nm)
            if isa(spectral_filter, 'components.SpectralFilter')
                obj.spectral_filter = spectral_filter;
            elseif isnumeric(spectral_filter)
                obj.spectral_filter = components.idealBPFilter( ...
                    obj.wavelength, spectral_filter, ...
                    "Wavelength_Scale", options.Wavelength_Scale);
            else
                error(['spectral_filter must be a SpectralFilter object ' ...
                    'or a numeric filter width in nm']);
            end

            obj.repetition_rate = repetition_rate;

            % Implement preset or custom detector data
            if isequal(options.Preset, 'none')
                obj.dark_count_rate     = options.Dark_Count_Rate;
                obj.dead_time           = options.Dead_Time;
                obj.efficiencies        = options.Efficiencies;
                obj.histogram_bin_width = options.Histogram_Bin_Width;
                obj.jitter_histogram    = options.Jitter_Histogram;
                obj.wavelength_range    = units.Magnitude.convert( ...
                    options.Wavelength_Scale, ...
                    "nano", ...
                    options.Wavelength_Range);
            else
                % If preset provided, load .mat file
                if isstring(options.Preset)
                    options.Preset = char(options.Preset);
                end
                load(['+components\@Detector\presets\', ...
                    options.Preset, '.mat'], ...
                    'Dark_Count_Rate', ...
                    'Dead_Time', ...
                    'Efficiencies', ...
                    'Histogram_Bin_Width', ...
                    'Jitter_Histogram', ...
                    'Wavelength_Range');

                obj.dark_count_rate     = Dark_Count_Rate;
                obj.dead_time           = Dead_Time;
                obj.efficiencies        = Efficiencies;
                obj.histogram_bin_width = Histogram_Bin_Width;
                obj.jitter_histogram    = Jitter_Histogram;
                obj.wavelength_range    = Wavelength_Range;
            end

            % Compute jitter QBER and loss
            obj = obj.densityFunctions();
            obj = obj.setJitterPerformance(repetition_rate);
            obj = obj.setDetectionEfficiency(Wavelength = wavelength);
        end


        function obj = setHistogramBinWidth(obj, width)
            % setHistogramBinWidth
            %
            % Set the width of the bins in the jitter histogram data.
            %
            % Syntax:
            %   obj = setHistogramBinWidth(obj, width)
            %
            % Inputs:
            %   width - (1,1) double, bin width in seconds
            %
            % Outputs:
            %   obj   - updated Detector object

            obj.histogram_bin_width = width;
            obj = setJitterPerformance(obj, obj.repetition_rate);
        end


        function obj = setWavelength(obj, wavelength, options)
            % setWavelength
            %
            % Set the operating wavelength of the detector, which determines
            % the detection efficiency.
            %
            % Syntax:
            %   obj = setWavelength(obj, wavelength, options)
            %
            % Inputs:
            %   wavelength - (1,1) double, wavelength in specified units
            %   options    - struct with:
            %       Wavelength_Scale (units.Magnitude) default 'nano'
            %       UpdateEfficiency (logical)         default false
            %
            % Outputs:
            %   obj        - updated Detector object

            arguments
                obj
                wavelength
                options.Wavelength_Scale units.Magnitude = 'nano'
                options.UpdateEfficiency logical = false
            end

            wavelength_new = units.Magnitude.convert( ...
                options.Wavelength_Scale, "nano", wavelength);

            if options.UpdateEfficiency
                obj = obj.setDetectionEfficiency(Wavelength = wavelength);
            end

            obj.wavelength = wavelength_new;
        end


        function obj = setDeadTime(obj, dead_time)
            % setDeadTime
            %
            % Set the detector dead time in seconds.
            %
            % Syntax:
            %   obj = setDeadTime(obj, dead_time)
            %
            % Inputs:
            %   dead_time - (1,1) double, dead time in seconds
            %
            % Outputs:
            %   obj       - updated Detector object

            obj.dead_time = dead_time;
        end


        function obj = densityFunctions(obj)
            % densityFunctions
            %
            % Calculate the probability density function (PDF) and cumulative
            % density function (CDF) from the jitter histogram.
            %
            % Syntax:
            %   obj = densityFunctions(obj)
            %
            % Outputs:
            %   obj - updated Detector with PDF and CDF

            assert(~isempty(obj.jitter_histogram), ...
                [inputname(1), '.jitter_histogram must not be empty']);

            obj.total_counts = sum(obj.jitter_histogram);
            n_bins = numel(obj.jitter_histogram);
            obj.cdf = zeros(1, n_bins);
            obj.pdf = zeros(1, n_bins);

            % First bin
            obj.pdf(1) = obj.jitter_histogram(1) / ...
                (obj.total_counts * obj.histogram_bin_width);
            obj.cdf(1) = 0;

            % Remaining bins
            for i = 2:n_bins
                obj.pdf(i) = obj.jitter_histogram(i) / ...
                    (obj.total_counts * obj.histogram_bin_width);
                obj.cdf(i) = sum(obj.pdf(1:i)) * obj.histogram_bin_width;
            end
        end

        function obj = setJitterPerformance(obj, repetition_rate)
            % setJitterPerformance
            %
            % Compute the QBER and loss due to timing jitter and record them in the
            % detector. For weak coherent pulses, assume the repetition rate equals
            % the incident photon rate after losses. For continuous-wave sources,
            % only photons that arrive contribute to jitter-induced QBER.
            %
            % Syntax:
            %   obj = setJitterPerformance(obj, repetition_rate)
            %
            % Inputs:
            %   repetition_rate - (1,1) double, photon arrival rate at detector (Hz)
            %
            % Outputs:
            %   obj             - updated Detector object


            %% compute jitter loss and qber

            % Turn time measures into index increments
            time_gate_width_idx = 2 * round( ...
                obj.time_gate_width / (2 * obj.histogram_bin_width));
            repetition_period_idx = round( ...
                1 ./ (repetition_rate * obj.histogram_bin_width));

            % Check that rounding results in reasonable precision
            if time_gate_width_idx < 10
                warning(['Gate width is less than 10 histogram bins, which may ', ...
                    'cause significant rounding errors.'])
            end
            if repetition_period_idx < 10
                warning(['Repetition period is less than 10 histogram bins, ', ...
                    'which may cause significant rounding errors.'])
            end

            % Compute mode point
            [~, mode_time_idx] = max(obj.pdf);

            n_bins   = numel(obj.jitter_histogram);
            half_idx = time_gate_width_idx / 2;

            % Compute loss
            loss = -obj.cdf(max(mode_time_idx - half_idx, 1)) ...
                + obj.cdf(min(mode_time_idx + half_idx, n_bins));

            % Compute QBER via discrete autocorrelation of the jitter PDF at delays
            % equal to integer multiples of the photon arrival period
            qber = 0;

            % Iterate over previous pulses (negative autocorrelation)
            current_mode = mode_time_idx + repetition_period_idx;
            while current_mode < n_bins
                qber = qber + 0.5 * ( ...
                    obj.cdf(min(current_mode + half_idx, n_bins)) ...
                    - obj.cdf(max(current_mode - half_idx, 1)) );
                current_mode = current_mode + repetition_period_idx;
            end

            % Iterate over forward pulses (positive autocorrelation)
            current_mode = mode_time_idx - repetition_period_idx;
            while current_mode > 0
                qber = qber + 0.5 * ( ...
                    obj.cdf(min(current_mode + half_idx, n_bins)) ...
                    - obj.cdf(max(current_mode - half_idx, 1)) );
                current_mode = current_mode - repetition_period_idx;
            end

            % QBER cannot exceed 0.5 due to this model
            if qber > 0.5
                qber = 0.5;
            end

            % Store results
            obj.qber_jitter = qber;
            obj.jitter_loss = loss;


            %% compute FWHM

            % find half max
            max_pdf = max(obj.pdf);
            half_max = max_pdf/2;

            % find points where pdf crosses half max
            for idx = 2:n_bins
                if obj.pdf(idx-1)<half_max && obj.pdf(idx)>half_max
                    upwards_crossing_idx = idx;
                    break
                end
            end
            for idx = n_bins:-1:2
                if obj.pdf(idx-1)>half_max && obj.pdf(idx)<half_max
                    downwards_crossing_idx = idx;
                    break
                end
            end

            obj.fwhm = (downwards_crossing_idx - upwards_crossing_idx)*obj.histogram_bin_width;

        end

        function p = plotDetHistogram(obj)
            % plotDetHistogram
            %
            % Plot the detector's jitter histogram in a focused time window around
            % the peak, using a simple density-based cutoff to mask low-count bins.
            %
            % Syntax:
            %   p = plotDetHistogram(obj)
            %
            % Outputs:
            %   p - line object handle for the plotted histogram curve

            % Build time axis centered around the histogram length
            n = numel(obj.jitter_histogram);             % number of histogram bins
            idx = linspace(1, n, n);                     % bin indices
            times = (idx - n) ./ 2 .* obj.histogram_bin_width;  % bin times (s)

            % Count occurrences of each unique bin level to set a cutoff
            bins = unique(obj.jitter_histogram);
            n_bins = numel(bins);
            counts = zeros(1, n_bins);
            for k = 1:n_bins
                counts(k) = sum(obj.jitter_histogram == bins(k));
            end

            % Mask out sparse levels using a simple log-count threshold
            take = @(arraylike, k) arraylike(k);
            cut_on = take(bins(log10(counts) < 1), 1);
            mask = obj.jitter_histogram > cut_on;

            % Find window around the histogram peak
            [~, max_idx] = max(obj.jitter_histogram);
            [~, i_idx] = max(idx(mask));

            % Plot masked histogram and focus x-limits around the peak
            p = plot(times(mask), obj.jitter_histogram(mask));
            xlim(times([max_idx - i_idx, max_idx + i_idx]));
        end


        function fig = plot(obj, fig)
            % plot
            %
            % Plot a summary of detector parameters: detection efficiency vs
            % wavelength, spectral filter transmission, and jitter PDF with gate
            % and repetition markers.
            %
            % Syntax:
            %   fig = plot(obj)
            %   fig = plot(obj, fig)
            %
            % Inputs:
            %   fig - optional figure handle; defaults to a new figure
            %
            % Outputs:
            %   fig - figure handle containing the summary plots

            arguments
                obj components.Detector
                fig matlab.ui.Figure = figure("Name", "Detector Summary")
            end

            % Create tiled layout
            tiles = tiledlayout(3, 1);

            %% Plot detection efficiency
            nexttile(tiles, 1);
            plot(obj.wavelength_range, obj.efficiencies);
            xlabel('Wavelength (nm)');
            ylabel('Detection Efficiency');
            xline(obj.wavelength, 'g--');
            yline(obj.detection_efficiency, 'g--');
            ylim([0, 1]);
            xlim([min(obj.wavelength_range), max(obj.wavelength_range)]);
            text( ...
                obj.wavelength, obj.detection_efficiency, 0, ...
                sprintf('Detection Efficiency = %.1f%% at %inm', ...
                100 * obj.detection_efficiency, obj.wavelength), ...
                'VerticalAlignment', 'bottom', ...
                'HorizontalAlignment', 'center', ...
                'FontName', get(groot, 'defaultAxesFontName') ...
                );

            %% Plot spectral filter transmission
            nexttile(tiles, 2);
            ax = gca();
            transmission = obj.spectral_filter.computeTransmission(obj.wavelength);
            plot(obj.spectral_filter, ax);
            xline(obj.wavelength, 'g--');
            yline(transmission, 'g--');
            xlim([min(obj.wavelength_range), max(obj.wavelength_range)]);
            ylim([0, 1]);
            text( ...
                obj.wavelength, transmission, 0, ...
                sprintf('Transmission = %.1f%% at %inm', ...
                100 * transmission, obj.wavelength), ...
                'VerticalAlignment', 'bottom', ...
                'HorizontalAlignment', 'center', ...
                'FontName', get(groot, 'defaultAxesFontName') ...
                );

            %% Plot jitter PDF and timing markers
            nexttile(tiles, 3);
            num_jitter_points = numel(obj.pdf);          % number of PDF samples
            [max_value, max_index] = max(obj.pdf);       % PDF peak
            jitter_times = ((1:num_jitter_points) - max_index) ...
                .* obj.histogram_bin_width;   % time axis (s)
            period = 1 ./ obj.repetition_rate;           % signal period (s)

            plot(jitter_times, obj.pdf);
            xlabel('Time (s)');
            ylabel('PDF');

            % Time gate markers
            xline(-obj.time_gate_width / 2, 'b--');
            xline( obj.time_gate_width / 2, 'b--');
            text( ...
                obj.time_gate_width / 2, max_value / 2, 0, ...
                sprintf('Time Gate Width = %.2gs', obj.time_gate_width), ...
                'VerticalAlignment', 'top', ...
                'HorizontalAlignment', 'left', ...
                'FontName', get(groot, 'defaultAxesFontName'), ...
                'Color', 'b' ...
                );

            % Repetition markers
            xlim([-period, 2 * period]);
            xline(0, 'r--');
            xline(period, 'r--');
            text( ...
                period, max_value / 2, 0, ...
                sprintf(['Repetition Rate = %.2gHz \nSignal Period = %.2gs \n', ...
                ' QBER_{jitter}=%.3g%%'], ...
                obj.repetition_rate, period, 100 * obj.qber_jitter), ...
                'VerticalAlignment', 'top', ...
                'HorizontalAlignment', 'left', ...
                'FontName', get(groot, 'defaultAxesFontName'), ...
                'Color', 'r' ...
                );

            %% compute FWHM

            % find half max
            max_pdf = max(obj.pdf);
            half_max = max_pdf/2;

            % mark points where pdf crosses half max
            for idx = 2:num_jitter_points
                if obj.pdf(idx-1)<half_max && obj.pdf(idx)>half_max
                    upwards_crossing_time = jitter_times(idx);
                    xline(upwards_crossing_time,'g--')
                    break
                end
            end
            for idx = num_jitter_points:-1:2
                if obj.pdf(idx-1)>half_max && obj.pdf(idx)<half_max
                    downwards_crossing_time = jitter_times(idx);
                    xline(downwards_crossing_time,'g--')
                    break
                end
            end

            %write fwhm
            text( ...
                downwards_crossing_time, max_value * 0.75, 0, ...
                sprintf('FWHM = %.2es',obj.fwhm),...
                'VerticalAlignment', 'top', ...
                'HorizontalAlignment', 'left', ...
                'FontName', get(groot, 'defaultAxesFontName'), ...
                'Color', 'g' ...
                );
        end

        function obj = setDarkCountRate(obj, dcr)
            % setDarkCountRate
            %
            % Set the detector dark-count rate (counts per second).
            %
            % Syntax:
            %   obj = setDarkCountRate(obj, dcr)
            %
            % Inputs:
            %   dcr - (1,1) double, nonnegative dark-count rate [counts/s]
            %
            % Outputs:
            %   obj - updated Detector object

            arguments
                obj components.Detector
                dcr double {mustBeNonnegative}
            end

            obj.dark_count_rate = dcr;
        end


        function obj = setPolarisationError(obj, polarisation_error)
            % setPolarisationError
            %
            % Set the polarisation error (rms, degrees) of the polarisation
            % compensation system.
            %
            % Syntax:
            %   obj = setPolarisationError(obj, polarisation_error)
            %
            % Inputs:
            %   polarisation_error - (1,1) double in [0, 360]
            %
            % Outputs:
            %   obj - updated Detector object

            arguments
                obj components.Detector
                polarisation_error double { ...
                    mustBeNonnegative, ...
                    mustBeLessThanOrEqual(polarisation_error, 360)}
            end

            % Polarisation error is recorded in degrees.
            obj.polarisation_error = polarisation_error;
        end


        function obj = setDetectionEfficiency(obj, options)
            % setDetectionEfficiency
            %
            % Set detection efficiency using either a forced value (Efficiency) or
            % by specifying a wavelength (Wavelength) to read from the efficiency
            % curve. Only one option should be supplied.
            %
            % Syntax:
            %   obj = setDetectionEfficiency(obj, Efficiency=value)
            %   obj = setDetectionEfficiency(obj, Wavelength=value)
            %
            % Inputs (name-value options):
            %   Efficiency - double in [0,1], direct assignment
            %   Wavelength - double (nm), must be within wavelength_range
            %
            % Outputs:
            %   obj - updated Detector object

            arguments
                obj
                options.Efficiency double { ...
                    mustBeNonnegative, mustBeLessThanOrEqual(options.Efficiency, 1)}
                options.Wavelength double {mustBeNonnegative}
            end

            % fields = fieldnames(options);
            fields = fieldnames(options);
            assert(~isempty(fields), ...
                'Either "Efficiency" or "Wavelength" should supplied not both');

            if contains(fields, 'Efficiency')
                obj.detection_efficiency = options.Efficiency;
                return
            end

            if contains(fields, 'Wavelength')
                min_wavelength = min(obj.wavelength_range);
                max_wavelength = max(obj.wavelength_range);
                assert( ...
                    (options.Wavelength >= min_wavelength) & ...
                    (options.Wavelength <= max_wavelength), ...
                    ['Wavelength must be in range: ', num2str(min_wavelength), ...
                    ' : ', num2str(max_wavelength), '.'] ...
                    );

                % obj.setWavelength(options.Wavelength);
                obj.wavelength = options.Wavelength;

                pw_poly = interp1(obj.wavelength_range, obj.efficiencies, ...
                    'cubic', 'pp');
                obj.detection_efficiency = ppval(pw_poly, options.Wavelength);
            end
        end

    end
end