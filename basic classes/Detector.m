classdef  Detector
    %DETECTOR provide the properties of the single photon detector to be used for an OGS

    properties
        %wavelength (nm) used for communication
        Wavelength{mustBeScalarOrEmpty, mustBePositive};

        %QBER contribution due to detectors' timing jitters
        QBER_Jitter{ ...
            mustBeNonnegative, ...
            mustBeScalarOrEmpty, ...
            mustBeLessThanOrEqual(QBER_Jitter, 1)};

        %loss due to timing jitter (absolute)- determined by calculation on
        %construction
        Jitter_Loss{mustBeNonnegative};

        %spectral filter model
        Spectral_Filter SpectralFilter

        %width of the time gate used in s
        Time_Gate_Width{mustBePositive, mustBeScalarOrEmpty};

        Repetition_Rate{mustBeNonnegative, mustBeScalarOrEmpty};

        Jitter_Histogram;
        Histogram_Bin_Width;
        Total_Counts = 0;
        CDF;
        PDF;

        % polarisation reference is required for polarisation encoded QKD.
        % poor polarisation compensation results in high QBER. We describe
        % the rms error in polarisation compensation which determines QBER in
        % degrees
        Polarisation_Error{mustBeScalarOrEmpty, mustBeNonnegative} = asind(1/280);
        %default value modelled off Micius

        Wavelength_Range;
        Dead_Time double;

        Efficiencies
        Detection_Efficiency{ ...
            mustBeScalarOrEmpty, ...
            mustBePositive, ...
            mustBeLessThanOrEqual(Detection_Efficiency, 1)};

        %rate at which eroneous counts occur
        Dark_Count_Rate{mustBeNonnegative,mustBeScalarOrEmpty};

        %for phase-based protocols, need a visibility metric
        Visibility {mustBeInRange(Visibility,0,1)} = 1;

    end

    methods

        function Detector = Detector( ...
            Wavelength, Repetition_Rate, Time_Gate_Width, ...
            Spectral_Filter, options)
            %%DETECTOR Construct a detector object with properties
            %determined by implementation

            arguments
                Wavelength double
                Repetition_Rate double
                Time_Gate_Width double
                Spectral_Filter
                options.Polarisation_Error double = asind(1 / 280)
                options.Preset DetectorPreset

                options.Dark_Count_Rate { ...
                    mustBeNumeric, ...
                    mustBeGreaterThanOrEqual(options.Dark_Count_Rate, 0)}

                options.Dead_Time { ...
                    mustBeNumeric, mustBeGreaterThanOrEqual(options.Dead_Time, 0)}

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
 
            optionFields = fieldnames(options);
            assert(~isempty(optionFields), ['Missing input parameters. ', ...
                'Supply either a :', newline, char(9), ...
                'a DetectorPreset -> Detector(... Preset=yourPreset),', ...
                newline, char(9), 'or a full set of parameters -> ', ...
                '(Detector(... Dark_Count_Rate=?, Dead_Time=?, ', ...
                'Jitter_Histogram=?, Histogram_Bin_Width=?, ', ...
                'Wavelength_Range=?, Efficiencies=?)'])

            if any(contains(optionFields, 'Preset'))
                Preset = options.Preset;
                for f = fieldnames(DetectorPreset)' % Have to transpose to iterate it
                    if strcmp(f{1}, 'Name') % We don't need this field here
                        continue
                    end
                    Detector.(f{1}) = Preset.(f{1});
                end
            else
                for f = fieldnames(DetectorPreset)' % Same as loop above
                    if strcmp(f{1}, 'Name')
                        continue
                    end
                    assert(any(contains(optionFields, f{1})), ...
                        ['Since a DetectorPreset is not being used { ', ...
                        f{1}, ' } must be supplied']);
                    Detector.(f{1}) = options.(f{1});
                end
            end

            %% implement detector properties
            Detector.Wavelength = Wavelength;
            Detector.Time_Gate_Width = Time_Gate_Width;


            %two cases for spectral filter, either width in nm (in which
            %case need to create a SF) or a spectral filter object.
            if isa(Spectral_Filter,'SpectralFilter')
            Detector.Spectral_Filter = Spectral_Filter;
            elseif isnumeric(Spectral_Filter)
            Detector.Spectral_Filter=IdealBPFilter(Detector.Wavelength,Spectral_Filter);
            else
                error('Spectral_Filter can be either a SpectralFilter object or a filter width in nm')
            end
            
            Detector.Repetition_Rate = Repetition_Rate;
 
            % compute jitter qber and loss
            Detector = Detector.DensityFunctions();
            Detector = Detector.SetJitterPerformance(Repetition_Rate);

            Detector = Detector.SetDetectionEfficiency(Wavelength=Wavelength);
        end

        function Detector = HistogramInfo(Detector)

            range = @(b) linspace(1, b, b);
            upperHalf = @(array) array >= (max(array) / 2);
            width = @(array) array(end) - array(1);
            fwhm = @(xarray, yarray) width(xarray(upperHalf(yarray)));

            bins = range(numel(Detector.Jitter_Histogram));

            % TODO fix magic number here!!!
            smoothed = smooth(Detector.Jitter_Histogram, 1000);
            shift = floor(fwhm(bins, Detector.Jitter_Histogram) / 2);
            crossed = abs(smoothed - circshift(smoothed, shift));
            mask = bins((crossed / max(crossed)) > 0.05);

            % ABSOLUTELY DO NOT DO THIS WITH JITTER DATA, YOU MORON
            % Need oscilloscope traces for each detector

            peakLocation = bins(max(smoothed) == smoothed);
            waveformStart = mask(1);
            waveformEnd = mask(end);
            disp([waveformStart, peakLocation, waveformEnd])
            riseTime = (peakLocation - waveformStart) * Detector.Histogram_Bin_Width;
            fallTime = (waveformEnd - peakLocation) * Detector.Histogram_Bin_Width;
            deadTime = fwhm(bins, Detector.Jitter_Histogram) * Detector.Histogram_Bin_Width;

            disp([riseTime, fallTime, deadTime] .* 1e9)
        end

        function Detector = SetHistogramBinWidth(Detector,Width)
            %%SETHISTOGRAMBINWIDTH set how wide the bins are in the jitter
            %%histogram data provided for this detector
            Detector.Histogram_Bin_Width = Width;
            Detector = SetJitterPerformance(Detector, Detector.Repetition_Rate);
        end

        function Detector = SetWavelength(Detector, Wavelength)
            %%SETWAVELENGTH set wavelength at which the detector is
            %%operating- which will determine detection efficiency
            Detector.Wavelength = Wavelength;
        end

        function Detector = SetDeadTime(Detector, Dead_Time)
            Detector.Dead_Time = Dead_Time;
        end

        function Detector = DensityFunctions(Detector)
            % Calculate the probability density function and cumulative density
            % function for the detectors derived from the jitter histogram
            assert(~isempty(Detector.Jitter_Histogram), ...
                [inputname(1), '.Jitter_Histogram, must not be empty']);

            Detector.Total_Counts = sum(Detector.Jitter_Histogram);
            N = numel(Detector.Jitter_Histogram);
            Detector.CDF = zeros(1,N);
            Detector.PDF = zeros(1,N);
 
            %% iterating over elements in the Detector.Jitter_Histogram
            Detector.PDF(1) = Detector.Jitter_Histogram(1)/Detector.Total_Counts;
            Detector.CDF(1) = 0;
            for i = 2:N
                %compute histogram probability density function and
                %cumulitive density function
                Detector.PDF(i) = ...
                    Detector.Jitter_Histogram(i) / Detector.Total_Counts;
                Detector.CDF(i) = sum(Detector.PDF(1:i));
            end
        end

        function Detector = SetJitterPerformance(Detector, Repetiton_Rate)
            % Jitter calculations...
            % This is a non-trivial component of the model. Depending on the kind
            % of source, the method to calculate the jitter and so the contribution
            % it makes to the QBER is different. For weak coherent pulses we must
            % assume that the repetition rate is equal to the incident photon rate
            % where the average photon per pulse has been reduced due to loss. This
            % is different to sources with continuous wave pumping where the only
            % contribution to QBER from jitter can be from the photons that have
            % arrived.
            % TODO
            % - Does the c.w. case mentioned above hold for heralded source in
            %   general? i.e. c.w. and pulsed sources of single-photons or 
            %   entangled photon pairs.

            % Repetition Rate: This is the rate of photons ARRIVING at the
            % detector, this will need to be recalculated for every value of
            % photons arriving at the detector.

            %%SETJITTERPERFORMANCE compute the QBER and loss due to jitter and record it in the detector.

            %% turn time measures into index increments
            Time_Gate_Width_Index = 2 * round( ...
                Detector.Time_Gate_Width / (2 * Detector.Histogram_Bin_Width));
            Repetition_Period_Index = round( ...
                1 ./ (Repetiton_Rate * Detector.Histogram_Bin_Width));

            %check that rounding results in reasonable precision
            if Time_Gate_Width_Index < 10
                warning('gate width is less than 10 histogram bins resulting in significant rounding errors')
            end
            if Repetition_Period_Index < 10
                warning('repetition period is less than 10 histogram bins resulting in significant rounding errors')
            end

            %% compute mode point
            [~, Mode_Time_Index] = max(Detector.PDF);

            N = numel(Detector.Jitter_Histogram);
            HalfIndex = Time_Gate_Width_Index / 2;
            %% compute loss
            Loss =  ...
                - Detector.CDF(max(Mode_Time_Index - HalfIndex, 1)) ...
                + Detector.CDF(min(Mode_Time_Index + HalfIndex, N));

            %% compute QBER
            %computing QBER is done by performing a discrete
            %autocorrelation calculation of the jittter PDF at delays
            %equal to integer multiples of the photon arrival period
            QBER = 0;

            %iterating over previous pulses (negative autocorrelation)
            Current_Mode = Mode_Time_Index + Repetition_Period_Index;
            while Current_Mode < N
                QBER = QBER + 0.5 * ( ...
                    Detector.CDF(min(Current_Mode + HalfIndex, N)) ...
                    - Detector.CDF(max(Current_Mode - HalfIndex, 1)) ...
                    );

                Current_Mode = Current_Mode + Repetition_Period_Index;
            end

            %iterating over forward pulses (positive autocorrelation)
            Current_Mode = Mode_Time_Index - Repetition_Period_Index;
            while Current_Mode > 0
                QBER = QBER + 0.5 * ( ...
                    Detector.CDF(min(Current_Mode + HalfIndex, N)) ...
                       - Detector.CDF(max(Current_Mode - HalfIndex, 1)) ...
                    );

                Current_Mode = Current_Mode - Repetition_Period_Index;
            end

            %QBER cannot exceed 0.5 due to this
            if QBER > 0.5
                QBER = 0.5;
            end

            %% store answers
            Detector.QBER_Jitter = QBER;
            Detector.Jitter_Loss = Loss;
        end

        function Det = StretchToNewJitter(Det, TargetJitter)
            % Set a false value for the jitter.
            % Useful for exploring implications of reduced/increased detector
            % timing jitter on QKD protocol / satellite pass simulation
            FWHM = Det.CalculateJitter();
            new_bin_width = (TargetJitter / FWHM) * Det.Histogram_Bin_Width;
            Det = Det.SetHistogramBinWidth(new_bin_width);
            Det = Det.SetJitterPerformance(Det.Repetition_Rate);
        end

        function [stretched_histogram] = StretchDetHistogram(Det, dead_time)
            % Set a "false" dead time.
            % Takes the histogram data, finds the peak and rising edge and then
            % extends the envelope by (dead time - rising time) forming a 
            % square function.
            % NOTE How useful is this function, should this be used to alter 
            %       the value calculated by SetJitterPerformance?

            N = numel(Det.Jitter_Histogram);
            index = linspace(1, N, N);
            times = Det.Histogram_Bin_Width .* index;

            peak_loc = index(Det.Jitter_Histogram == max(Det.Jitter_Histogram));

            min_val = 0.01;
            max_val = 0.01;
            up_to_max = ( Det.Jitter_Histogram ...
                          > (min_val * min(Det.Jitter_Histogram)) ) ...
                        & (times < times(peak_loc));

            rising = up_to_max ...
                & (Det.Jitter_Histogram > (min_val * max(Det.Jitter_Histogram)));

            after_max = (times > times(peak_loc));

            falling = after_max & ...
                (Det.Jitter_Histogram > (min_val * max(Det.Jitter_Histogram)));

            rise_time = sum(fliplr(extrema(times(rising))) .* [1, -1]);

            additional_dead_time = dead_time - rise_time;
            stretched_histogram = Det.Jitter_Histogram;
            max_time = times(peak_loc) + additional_dead_time;
            waveform_mask = (times < max_time) & (times > times(peak_loc));
            stretched_histogram(waveform_mask) = max(Det.Jitter_Histogram);
        end

        function p = PlotDetHistogram(Det)
            % TODO Plot everything about the detector highlighting its current state
            N = numel(Det.Jitter_Histogram);
            index = linspace(1, N, N);
            times = (index - N) ./ 2 * Det.Histogram_Bin_Width;

            bins = unique(Det.Jitter_Histogram);
            n_bins = numel(bins);
            counts = zeros(1, n_bins);
            for i = 1:n_bins
                counts(i) = sum(Det.Jitter_Histogram == bins(i));
            end

            Take = @(arraylike, N) arraylike(N);
            cut_on = Take(bins(log10(counts) < 1), 1);
            mask = Det.Jitter_Histogram > cut_on;

            [max_val, max_idx] = max(Det.Jitter_Histogram);
            [i_val, i_idx] = max(index(mask))

            p = plot(times(mask), Det.Jitter_Histogram(mask));
            xlim(times([max_idx-i_idx, max_idx+i_idx]))
        end

        function Det = SetDarkCountRate(Det, DCR)
            % SetDarkCountRate set detector dark count rate
            arguments
                Det Detector
                DCR double {mustBeNonnegative}
            end
            Det.Dark_Count_Rate = DCR;
        end

        function Det = SetPolarisationError(Det, Polarisation_Error)
            % Set the polarisation error in a
            % modelled polarisation compensation system
            arguments
                Det Detector
                Polarisation_Error double {mustBeNonnegative, ...
                    mustBeLessThanOrEqual(Polarisation_Error, 360)}
            end

            %(polarisation error is recorded in degrees)
            Det.Polarisation_Error = Polarisation_Error;
        end

        function Det = SetDetectionEfficiency(Det, options)
            % Set detection efficiency according to the options.{Efficiency, 
            % Wavelength}, only one options can be passed when called otherwise the
            % function errors:
            %   - Efficiency: Forces the value, ignoring the Detector.Wavelength_Range
            %   - Wavelength: Asserts that the detector operates at that wavelength 
            %       and uses the efficiency at that wavelength and updating the
            %       wavelength currently set
            % # Usage
            % det.SetDetectionEfficiency(Efficiency=0.8)
            % det.SetDetectionEfficiency(Wavelength=1550)
            arguments
                Det Detector
                options.Efficiency double { ...
                    mustBeNonnegative, mustBeLessThanOrEqual(options.Efficiency, 1)}
                options.Wavelength double {mustBeNonnegative}
            end

            %assert(numel(fieldnames(options)) <= 1, ...
            fields = fieldnames(options);
            assert(~isempty(fields), ...
                'Either "Efficiency" or "Wavelength" should supplied not both');

            if contains(fields, 'Efficiency')
                Det.Detection_Efficiency = options.Efficiency;
                return
            end

            if contains(fields, 'Wavelength')
                min_wavelength = min(Det.Wavelength_Range);
                max_wavelength = max(Det.Wavelength_Range);
                assert( ...
                    (options.Wavelength >= min_wavelength) & ...
                    (options.Wavelength <= max_wavelength), ...
                    ['Wavelength must be in range: ', num2str(min_wavelength), ...
                    ' : ', num2str(max_wavelength), '.'])

                Det = Det.SetWavelength(options.Wavelength);

                pw_poly = interp1(Det.Wavelength_Range, Det.Efficiencies, 'cubic', 'pp');
                Det.Detection_Efficiency = ppval(pw_poly, options.Wavelength);
            end

        end
    end
end
