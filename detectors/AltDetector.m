classdef  AltDetector
    %DETECTOR provide the properties of the single photon detector to be used for an OGS

    properties
        %wavelength (nm) used for communication
        Wavelength{mustBeScalarOrEmpty, mustBePositive};

        %QBER contribution due to detectors' timing jitters
        QBER_Jitter{mustBeNonnegative, mustBeScalarOrEmpty, ...
                    mustBeLessThanOrEqual(QBER_Jitter, 1)};

        %loss due to timing jitter (absolute)- determined by calculation on
        %construction
        Jitter_Loss{mustBeNonnegative};

        %spectral filter width in nm
        Spectral_Filter_Width{mustBeNonnegative, mustBeScalarOrEmpty};

        %width of the time gate used in s
        Time_Gate_Width{mustBePositive, mustBeScalarOrEmpty};

        Repetition_Rate{mustBeNonnegative, mustBeScalarOrEmpty};

        Jitter_Histogram;
        Histogram_Bin_Width;

        Total_Counts = 0; %sum(Detector.Jitter_Histogram);
        CDF; %zeros(1,N);
        PDF; %zeros(1,N);

        % polarisation reference is required for polarisation encoded QKD.
        % poor polarisation compensation results in high QBER. We describe
        % the rms error in polarisation compensation which determines QBER in
        % degrees
        Polarisation_Error{mustBeScalarOrEmpty, mustBeNonnegative} = asind(1/280);
        %default value modelled off Micius

        Wavelength_Range;
        Detection_Efficiencies;
        Rise_Time double;
        Fall_Time double;
        Dead_Time double;

        %detection efficiency
        Efficiency{mustBeScalarOrEmpty, mustBePositive, ...
                             mustBeLessThanOrEqual(Efficiency, 1)};

        %rate at which eroneous counts occur
        Dark_Count_Rate{mustBeNonnegative,mustBeScalarOrEmpty};

        %Data for wavelength dependant detector efficiency
        Efficiency_Data_Location;
        %Dead_Time;
    end


    methods

        function AltDetector = AltDetector( ...
            Preset, Wavelength, Repetition_Rate, Time_Gate_Width, ...
            Spectral_Filter_Width, options)
            %%DETECTOR Construct a detector object with properties
            %determined by implementation

            arguments
                Preset DetectorPreset
                Wavelength double
                Repetition_Rate double
                Time_Gate_Width double
                Spectral_Filter_Width double
                options.Polarisation_Error double = asind(1 / 280)
            end
 
            AltDetector.Dark_Count_Rate = Preset.Dark_Count_Rate;
            AltDetector.Dead_Time = Preset.Dead_Time;
            AltDetector.Jitter_Histogram = Preset.Jitter_Histogram;
            AltDetector.Histogram_Bin_Width = Preset.Histogram_Bin_Width;
            AltDetector.Wavelength_Range = Preset.Efficiencies_Wavelengths;
            AltDetector.Detection_Efficiencies = Preset.Efficiencies_Values;

            %% implement detector properties
            AltDetector.Wavelength = Wavelength;
            AltDetector.Time_Gate_Width = Time_Gate_Width;
            AltDetector.Spectral_Filter_Width = Spectral_Filter_Width;
            AltDetector.Repetition_Rate = Repetition_Rate;
 
            %% compute loss and QBER due to jitter
            % load in data for this detector
            %AltDetector = LoadHistogramData(AltDetector);
 
            % compute jitter qber and loss
            AltDetector = AltDetector.DensityFunctions();
            AltDetector = SetJitterPerformance(AltDetector, Repetition_Rate);
 
            %set rise time, fall time and dead time as appropriate
            % if isnan(p.Results.Dead_Time)
            % if isnan(Dead_Time)
            %     AltDetector.dead_time = AltDetector.rise_time + AltDetector.fall_time;
            %     %AltDetector = SetDeadTime(AltDetector, p.Results.Dead_Time);
            % else
            %     AltDetector.dead_time = Dead_Time;
            %     % AltDetector = SetDeadTime(AltDetector, p.Results.Dead_Time);
            %     AltDetector = SetDeadTime(AltDetector, Dead_Time);
            %     % detector.rise_time = p.Results.Dead_Time / 2;
            %     % detector.fall_time = p.Results.Dead_Time / 2;
            % end
 
            % Want a function that will let us pick the efficiency or override it
            % Default behaviour should be to pick an efficiency from the supplied
            % data. Require a flag (bool) to override this behaviour

            % %if available, load in detection efficiency data
            % if AltDetector.Efficiency_Data_Location
            %     [wavelengths, efficiency] = LoadAltDetectorEfficiency(AltDetector);
            %     AltDetector.Wavelength_Range = wavelengths;
            %     AltDetector.Detection_Efficiencies = efficiency;
            %     AltDetector = CalculateDetectionEfficiency(AltDetector);
            % end
        end

        function AltDetector = HistogramInfo(AltDetector)

            range = @(b) linspace(1, b, b);
            upperHalf = @(array) array >= (max(array) / 2);
            width = @(array) array(end) - array(1);
            fwhm = @(xarray, yarray) width(xarray(upperHalf(yarray)));

            bins = range(numel(AltDetector.Jitter_Histogram));

            % TODO fix magic number here!!!
            smoothed = smooth(AltDetector.Jitter_Histogram, 1000);
            shift = floor(fwhm(bins, AltDetector.Jitter_Histogram) / 2);
            crossed = abs(smoothed - circshift(smoothed, shift));
            mask = bins((crossed / max(crossed)) > 0.05);

            % ABSOLUTELY DO NOT DO THIS WITH JITTER DATA, YOU MORON
            % Need oscilloscope traces for each detector

            peakLocation = bins(max(smoothed) == smoothed);
            waveformStart = mask(1);
            waveformEnd = mask(end);
            disp([waveformStart, peakLocation, waveformEnd])
            riseTime = (peakLocation - waveformStart) * AltDetector.Histogram_Bin_Width;
            fallTime = (waveformEnd - peakLocation) * AltDetector.Histogram_Bin_Width;
            deadTime = fwhm(bins, AltDetector.Jitter_Histogram) * AltDetector.Histogram_Bin_Width;

            disp([riseTime, fallTime, deadTime] .* 1e9)

        end

        function AltDetector = SetHistogramBinWidth(AltDetector,Width)
            %%SETHISTOGRAMBINWIDTH set how wide the bins are in the jitter
            %%histogram data provided for this detector
            AltDetector.Histogram_Bin_Width  =  Width;
            Jitter_Histogram = LoadHistogramData(AltDetector); %#ok<*PROPLC> 
            % AltDetector = SetJitterPerformance(AltDetector, Jitter_Histogram, ...
            %                                 Width, AltDetector.Time_Gate_Width, ...
            %                                 AltDetector.Repetition_Rate);
            AltDetector = SetJitterPerformance(AltDetector, AltDetector.Repetition_Rate);
        end

        function AltDetector = SetWavelength(AltDetector,Wavelength)
            %%SETWAVELENGTH set wavelength at which the detector is
            %%operating- which will determine detection efficiency
            AltDetector.Wavelength = Wavelength;
        end

        % function AltDetector = SetDetectionEfficiency(AltDetector, ...
        %                                            Efficiency)
        %     %%SETDETECTIONEFFICIENCY
        %     AltDetector.Efficiency = Efficiency;
        % end

        function AltDetector = SetProtocol(AltDetector, Protocol)
            %%SETPROTOCOL
            AltDetector.Protocol = Protocol;
        end

        function AltDetector = SetDeadTime(AltDetector, Dead_Time)
            AltDetector.Dead_Time = Dead_Time;
        end

        % Calculate the probability density function and cumulative density
        % function for the detectors derived from the jitter histogram
        function AltDetector = DensityFunctions(AltDetector)
             %prepare memory
             assert(~isempty(AltDetector.Jitter_Histogram), ...
                 [inputname(1), '.Jitter_Histogram, must not be empty']);

             AltDetector.Total_Counts = sum(AltDetector.Jitter_Histogram);
             N = numel(AltDetector.Jitter_Histogram);
             AltDetector.CDF = zeros(1,N);
             AltDetector.PDF = zeros(1,N);
 
             %% iterating over elements in the AltDetector.Jitter_Histogram
             AltDetector.PDF(1) = AltDetector.Jitter_Histogram(1)/AltDetector.Total_Counts;
             AltDetector.CDF(1) = 0;
             for i = 2:N
                 %compute histogram probability density function and
                 %cumulitive density function
                 AltDetector.PDF(i) = ...
                     AltDetector.Jitter_Histogram(i) / AltDetector.Total_Counts;
                 AltDetector.CDF(i) = sum(AltDetector.PDF(1:i));
             end
        end

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
        function AltDetector = SetJitterPerformance(AltDetector, Repetiton_Rate)
            % Repetition Rate: This is the rate of photons ARRIVING at the
            % detector, this will need to be recalculated for every value of
            % photons arriving at the detector.

            % How do we optimise the calculations this performs?

            %%SETJITTERPERFORMANCE compute the QBER and loss due to jitter and record it in the detector.

            %% turn time measures into index increments
            Time_Gate_Width_Index = 2 * round( ...
                AltDetector.Time_Gate_Width / (2 * AltDetector.Histogram_Bin_Width));
            Repetition_Period_Index = round( ...
                1 ./ (Repetiton_Rate * AltDetector.Histogram_Bin_Width));

            %check that rounding results in reasonable precision
            if Time_Gate_Width_Index < 10
                warning('gate width is less than 10 histogram bins resulting in significant rounding errors')
            end
            if Repetition_Period_Index < 10
                warning('repetition period is less than 10 histogram bins resulting in significant rounding errors')
            end

            %% compute mode point
            [~, Mode_Time_Index] = max(AltDetector.PDF);

            N = numel(AltDetector.Jitter_Histogram);
            HalfIndex = Time_Gate_Width_Index / 2;
            %% compute loss
            Loss =  ...
                - AltDetector.CDF(max(Mode_Time_Index - HalfIndex, 1)) ...
                + AltDetector.CDF(min(Mode_Time_Index + HalfIndex, N));

            %% compute QBER
            %computing QBER is done by performing a discrete
            %autocorrelation calculation of the jittter PDF at delays
            %equal to integer multiples of the photon arrival period
            QBER = 0;

            %iterating over previous pulses (negative autocorrelation)
            Current_Mode = Mode_Time_Index + Repetition_Period_Index;
            while Current_Mode < N
                QBER = QBER + 0.5 * ( ...
                    AltDetector.CDF(min(Current_Mode + HalfIndex, N)) ...
                    - AltDetector.CDF(max(Current_Mode - HalfIndex, 1)) ...
                    );

                Current_Mode = Current_Mode + Repetition_Period_Index;
            end

            %iterating over forward pulses (positive autocorrelation)
            Current_Mode = Mode_Time_Index - Repetition_Period_Index;
            while Current_Mode > 0
                QBER = QBER + 0.5 * ( ...
                    AltDetector.CDF(min(Current_Mode + HalfIndex, N)) ...
                       - AltDetector.CDF(max(Current_Mode - HalfIndex, 1)) ...
                    );

                Current_Mode = Current_Mode - Repetition_Period_Index;
            end

            %QBER cannot exceed 0.5 due to this
            if QBER > 0.5
                QBER = 0.5;
            end

            %% store answers
            AltDetector.QBER_Jitter = QBER;
            AltDetector.Jitter_Loss = Loss;
        end

        % Set a false value for the jitter.
        % Useful for exploring implications of reduced/increased detector
        % timing jitter on QKD protocol / satellite pass simulation
        function Det = StretchToNewJitter(Det, TargetJitter)
            FWHM = Det.CalculateJitter();
            new_bin_width = (TargetJitter / FWHM) * Det.Histogram_Bin_Width;
            Det = Det.SetHistogramBinWidth(new_bin_width);
            Det = Det.SetJitterPerformance(Det.Repetition_Rate);
        end

        % Set a "false" dead time.
        % Takes the histogram data, finds the peak and rising edge and then
        % extends the envelope by (dead time - rising time) forming a 
        % square function.
        % NOTE How useful is this function, should this be used to alter 
        %       the value calculated by SetJitterPerformance?
        function [stretched_histogram] = StretchAltDetectorHistogram(AltDetector, dead_time)

            N = numel(AltDetector.Jitter_Histogram);
            index = linspace(1, N, N);
            times = AltDetector.Histogram_Bin_Width .* index;

            peak_loc = index(AltDetector.Jitter_Histogram ...
                             == max(AltDetector.Jitter_Histogram));

            min_val = 0.01;
            max_val = 0.01;
            up_to_max = ( AltDetector.Jitter_Histogram ...
                          > (min_val * min(AltDetector.Jitter_Histogram)) ) ...
                        & (times < times(peak_loc));

            rising = up_to_max ...
                     & ( AltDetector.Jitter_Histogram ...
                         > (min_val * max(AltDetector.Jitter_Histogram)) );

            after_max = (times > times(peak_loc));
            falling = after_max & ...
                      ( AltDetector.Jitter_Histogram ...
                        > (min_val * max(AltDetector.Jitter_Histogram)) );

            rise_time = sum(fliplr(extrema(times(rising))) .* [1, -1]);

            additional_dead_time = dead_time - rise_time;
            stretched_histogram = AltDetector.Jitter_Histogram;
            max_time = times(peak_loc) + additional_dead_time;
            waveform_mask = (times < max_time) & (times > times(peak_loc));
            stretched_histogram(waveform_mask) = max(AltDetector.Jitter_Histogram);
        end

        % TODO Plot everything about the detector highlighting its current state
        function p = PlotAltDetectorHistogram(AltDetector)
            N = numel(AltDetector.Jitter_Histogram);
            index = linspace(1, N, N);
            times = (index - N) ./ 2 * AltDetector.Histogram_Bin_Width;

            bins = unique(AltDetector.Jitter_Histogram);
            n_bins = numel(bins);
            counts = zeros(1, n_bins);
            for i = 1:n_bins
                counts(i) = sum(AltDetector.Jitter_Histogram == bins(i));
            end

            Take = @(arraylike, N) arraylike(N);
            cut_on = Take(bins(log10(counts) < 1), 1);
            mask = AltDetector.Jitter_Histogram > cut_on;

            [max_val, max_idx] = max(AltDetector.Jitter_Histogram);
            [i_val, i_idx] = max(index(mask))

            p = plot(times(mask), AltDetector.Jitter_Histogram(mask));
            xlim(times([max_idx-i_idx, max_idx+i_idx]))
        end

        % SetDarkCountRate set detector dark count rate
        function Det = SetDarkCountRate(Det,DCR)
            arguments
                Det AltDetector
                DCR double {mustBeNonnegative}
            end
            Det.Dark_Count_Rate = DCR;
        end

        % Set the polarisation error in a
        % modelled polarisation compensation system
        function Det = SetPolarisationError(Det, Polarisation_Error)
            arguments
                Det AltDetector
                Polarisation_Error double {mustBeNonnegative, ...
                    mustBeLessThanOrEqual(Polarisation_Error, 360)}
            end

            %(polarisation error is recorded in degrees)
            AltDetector.Polarisation_Error = Polarisation_Error;
        end

        % Set detection efficiency according to the options.{Efficiency, 
        % Wavelength}, only one options can be passed when called otherwise the
        % function errors:
        %   - Efficiency: Forces the value, ignoring the AltDetector.Wavelength_Range
        %   - Wavelength: Asserts that the detector operates at that wavelength 
        %       and uses the efficiency at that wavelength
        % # Usage
        % det.SetDetectionEfficiency(Efficiency=0.8)
        % det.SetDetectionEfficiency(Wavelength=1550)
        function Det = SetEfficiency(Det, options)
            arguments
                Det AltDetector
                options.Efficiency double { ...
                    mustBeNonnegative, mustBeLessThanOrEqual(options.Efficiency, 1)}
                options.Wavelength double {mustBeNonnegative}
            end

            assert(numel(fieldnames(options)) <= 1, ...
                'Either "Efficiency" or "Wavelength" should supplied not both');

            if contains(fieldnames(options), 'Efficiency')
                Det.Efficiency = options.Efficiency;
                return
            end

            if contains(fieldnames(options), 'Wavelength')
                min_wavelength = min(Det.Wavelength_Range);
                max_wavelength = max(Det.Wavelength_Range);
                assert( ...
                    (options.Wavelength >= min_wavelength) & ...
                    (options.Wavelength <= max_wavelength), ...
                    ['Wavelength must be in range: ', num2str(min_wavelength), ...
                    ' : ', num2str(max_wavelength), '.'])

                pw_poly = interp1(Det.Wavelength_Range, ...
                                  Det.Detection_Efficiencies, 'cubic', 'pp');
                Det.Efficiency = ppval(pw_poly, options.Wavelength);
            end

        end

    end
end
