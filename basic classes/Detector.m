classdef (Abstract) Detector
    %DETECTOR provide the properties of the single photon detector to be used for an OGS

    properties (Abstract = false)
        %wavelength (nm) used for communication
        Wavelength{mustBeScalarOrEmpty, mustBePositive};

        %QBER contribution due to detectors' timing jitters
        QBER_Jitter{mustBeNonnegative, mustBeScalarOrEmpty, ...
                    mustBeLessThanOrEqual(QBER_Jitter, 1)};

        %loss due to timing jitter (absolute)- determined by calculation on
        %construction
        Jitter_Loss{mustBeNonnegative};

        %spectral filter width in nm
        Spectral_Filter_Width{mustBePositive, mustBeScalarOrEmpty};

        %width of the time gate used in s
        Time_Gate_Width{mustBePositive, mustBeScalarOrEmpty};

        Repetition_Rate{mustBePositive, mustBeScalarOrEmpty};

        Histogram_Data;

        Total_Counts = 0; %sum(Detector.Histogram_Data);
        CDF; %zeros(1,N);
        PDF; %zeros(1,N);

        % polarisation reference is required for polarisation encoded QKD.
        % poor polarisation compensation results in high QBER. We describe
        % the rms error in polarisation compensation which determines QBER in
        % degrees
        Polarisation_Error{mustBeScalarOrEmpty, mustBeNonnegative} = asind(1/280);
        %default value modelled off Micius

        Valid_Wavelength;
        Detector_Efficiency_arr;
        rise_time;
        fall_time;
        dead_time;

    end
    properties(Abstract = true, SetAccess = protected)
        %detection efficiency
        Detection_Efficiency{mustBeScalarOrEmpty, mustBePositive, ...
                             mustBeLessThanOrEqual(Detection_Efficiency, 1)};

        %rate at which eroneous counts occur
        Dark_Count_Rate{mustBeNonnegative,mustBeScalarOrEmpty};
        Histogram_Data_Location;
        Histogram_Bin_Width;

        %Data for wavelength dependant detector efficiency
        Efficiency_Data_Location;
        Dead_Time;
    end


    methods
        function Detector = Detector(Wavelength, Repetition_Rate, ...
                                     Time_Gate_Width, ...
                                     Spectral_Filter_Width, ...
                                     varargin)
            %%DETECTOR Construct a detector object with properties
            %determined by implementation

            p  =  inputParser();
            addRequired(p, 'Wavelength');
            addRequired(p, 'Repetition_Rate');
            addRequired(p, 'Time_Gate_Width');
            addRequired(p, 'Spectral_Filter_Width');
            addParameter(p, 'Bin_Width', nan);
            addParameter(p, 'Dead_Time', nan);
            addParameter(p, 'Polarisation_Error',asind(1/280));

            parse(p, Wavelength, Repetition_Rate, Time_Gate_Width, ...
                  Spectral_Filter_Width, varargin{:});



            %% implement detector properties
            Detector.Wavelength = Wavelength;
            Detector.Time_Gate_Width = Time_Gate_Width;
            Detector.Spectral_Filter_Width = Spectral_Filter_Width;
            Detector.Repetition_Rate  =  Repetition_Rate;

            %% compute loss and QBER due to jitter
            % load in data for this detector
            Detector = LoadHistogramData(Detector);

            % compute jitter qber and loss
            Detector = SetJitterPerformance(Detector, Repetition_Rate);

            %set rise time, fall time and dead time as appropriate
            if isnan(p.Results.Dead_Time)
                Detector.dead_time = Detector.rise_time + Detector.fall_time;
                %Detector = SetDeadTime(Detector, p.Results.Dead_Time);
            else
                Detector.dead_time = p.Results.Dead_Time;
                Detector = SetDeadTime(Detector, p.Results.Dead_Time);
                % detector.rise_time = p.Results.Dead_Time / 2;
                % detector.fall_time = p.Results.Dead_Time / 2;
            end

            %if available, load in detection efficiency data
            if Detector.Efficiency_Data_Location
                [wavelengths, efficiency] = LoadDetectorEfficiency(Detector);
                Detector.Valid_Wavelength = wavelengths;
                Detector.Detector_Efficiency_arr = efficiency;
                Detector = CalculateDetectionEfficiency(Detector);
            end
        end

        function Detector = SetHistogramBinWidth(Detector,Width)
            %%SETHISTOGRAMBINWIDTH set how wide the bins are in the jitter
            %%histogram data provided for this detector
            Detector.Histogram_Bin_Width  =  Width;
            Histogram_Data = LoadHistogramData(Detector); %#ok<*PROPLC> 
            % Detector = SetJitterPerformance(Detector, Histogram_Data, ...
            %                                 Width, Detector.Time_Gate_Width, ...
            %                                 Detector.Repetition_Rate);
            Detector = SetJitterPerformance(Detector, Detector.Repetition_Rate);
        end

        function Detector = SetWavelength(Detector,Wavelength)
            %%SETWAVELENGTH set wavelength at which the detector is
            %%operating- which will determine detection efficiency
            Detector.Wavelength = Wavelength;
        end

        function Detector = SetDetectionEfficiency(Detector, ...
                                                   Detection_Efficiency)
            %%SETDETECTIONEFFICIENCY
            Detector.Detection_Efficiency = Detection_Efficiency;
        end

        function Detector = SetProtocol(Detector, Protocol)
            %%SETPROTOCOL
            Detector.Protocol = Protocol;
        end

        function Detector = SetDeadTime(Detector, Dead_Time)
            Detector.Dead_Time = Dead_Time;
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
        function Detector = SetJitterPerformance(Detector, Repetiton_Rate)
            % Repetition Rate: This is the rate of photons ARRIVING at the
            % detector, this will need to be recalculated for every value of
            % photons arriving at the detector.

            % How do we optimise the calculations this performs?

            %%SETJITTERPERFORMANCE compute the QBER and loss due to jitter and record it in the detector.


            %% turn time measures into index increments
            Time_Gate_Width_Index = 2 * round(Detector.Time_Gate_Width / (2 * Detector.Histogram_Bin_Width));
            Repetition_Period_Index = round(1 ./ (Repetiton_Rate * Detector.Histogram_Bin_Width));

            %check that rounding results in reasonable precision
            if Time_Gate_Width_Index < 10
                warning('gate width is less than 10 histogram bins resulting in significant rounding errors')
            end
            if Repetition_Period_Index < 10
                warning('repetition period is less than 10 histogram bins resulting in significant rounding errors')
            end

            %% compute mode point
            [~,Mode_Time_Index] = max(Detector.PDF);

            N = numel(Detector.Histogram_Data);
            %% compute loss
            Loss =  - Detector.CDF(max(Mode_Time_Index - Time_Gate_Width_Index / 2, 1)) ...
                    + Detector.CDF(min(Mode_Time_Index + Time_Gate_Width_Index / 2, N));

            %% compute QBER
            %computing QBER is done by performing a discrete
            %autocorrelation calculation of the jittter PDF at delays
            %equal to integer multiples of the photon arrival period
            QBER = 0;


            %iterating over previous pulses (negative autocorrelation)
            Current_Shifted_Mode = Mode_Time_Index + Repetition_Period_Index;
            while Current_Shifted_Mode < N
                QBER = QBER ...
                       + 0.5*(Detector.CDF(min(Current_Shifted_Mode ...
                                      + Time_Gate_Width_Index / 2, N)) ...
                       - Detector.CDF(max(Current_Shifted_Mode ...
                                 - Time_Gate_Width_Index / 2, 1)) );

                Current_Shifted_Mode = Current_Shifted_Mode ...
                                       + Repetition_Period_Index;
            end

            %iterating over forward pulses (positive autocorrelation)
            Current_Shifted_Mode = Mode_Time_Index - Repetition_Period_Index;
            while Current_Shifted_Mode > 0
                QBER = QBER ...
                       + 0.5*(Detector.CDF(min(Current_Shifted_Mode ...
                                      + Time_Gate_Width_Index / 2, N)) ...
                       - Detector.CDF(max(Current_Shifted_Mode ...
                                 - Time_Gate_Width_Index / 2, 1)) );
                Current_Shifted_Mode = Current_Shifted_Mode ...
                                       - Repetition_Period_Index;
            end

            %QBER cannot exceed 0.5 due to this
            if QBER > 0.5
                QBER = 0.5;
            end

            %% store answers
            Detector.QBER_Jitter = QBER;
            Detector.Jitter_Loss = Loss;
        end

        function Detector = LoadHistogramData(Detector)
            %%LOADHISTOGRAMDATA load in from an external file the data
            %%describing the timing jitter of a detector

            %% load in data
            Detector.Histogram_Data = getfield(...
                                    load(Detector.Histogram_Data_Location), ...
                                    'Counts'); 

            %% input validation
            %check that Histogram is a correctly computed histogram
            assert(numel(Detector.Histogram_Data) > 1,...
                'Detector.Histogram_Data must contain multiple elements');
            assert(isreal(Detector.Histogram_Data),...
                'Detector.Histogram_Data must contain real data');
            assert(isreal(Detector.Histogram_Data),...
                'Detector.Histogram_Data must contain real data');
            assert(all(Detector.Histogram_Data >= 0),...
                    'since Detector.Histogram_Data represents a histogram, it must contain nonnegative data');

            %check that Detector.Histogram_Bin_Width is a real scalar  > 0
            assert(isscalar(Detector.Histogram_Bin_Width) && isreal(Detector.Histogram_Bin_Width) && Detector.Histogram_Bin_Width > 0,...
            'Detector.Histogram_Bin_Width must be a scalar real value  > 0')

            %check that gate width is a real scalar  > 0
            assert(isscalar(Detector.Time_Gate_Width) && isreal(Detector.Time_Gate_Width) && Detector.Time_Gate_Width > 0,...
                'Detector.Time_Gate_Width must be a scalar real value  > 0');

            %prepare memory
            Detector.Total_Counts = sum(Detector.Histogram_Data);
            N = numel(Detector.Histogram_Data);
            Detector.CDF = zeros(1,N);
            Detector.PDF = zeros(1,N);

            %% iterating over elements in the Detector.Histogram_Data
            Detector.PDF(1) = Detector.Histogram_Data(1)/Detector.Total_Counts;
            Detector.CDF(1) = 0;
            for i = 2:N
                %compute histogram probability density function and
                %cumulitive density function
                Detector.PDF(i) = Detector.Histogram_Data(i)/Detector.Total_Counts;
                Detector.CDF(i) = sum(Detector.PDF(1:i));
            end

            [rise_time, fall_time] = DetectorTimeConstants(Detector); %#ok<*PROP> 
            % Detector.rise_time = rise_time;
            % Detector.fall_time = fall_time;
            Detector.dead_time = rise_time + fall_time;

        end

        function Detector = StretchToNewJitter(Detector, TargetJitter)
            FWHM = Detector.CalculateJitter();
            new_bin_width = (TargetJitter / FWHM) * Detector.Histogram_Bin_Width;
            Detector = Detector.SetHistogramBinWidth(new_bin_width);
            Detector = Detector.SetJitterPerformance(Detector.Repetition_Rate);
        end

        function FWHM = CalculateJitter(Detector)
            N = numel(Detector.Histogram_Data);
            index = linspace(1, N, N);
            times = (index - N) ./ 2 * Detector.Histogram_Bin_Width;

            FirstLast = @(array) abs([array(1), array(end)]);
            Difference = @(Pair) max(Pair) - min(Pair);

            FWHM = Difference(FirstLast(times( ...
                Detector.Histogram_Data >= (max(Detector.Histogram_Data) / 2))));
        end

        function [stretched_histogram] = StretchDetectorHistogram(Detector, dead_time)
            % Set a "false" dead time.
            % Takes the histogram data, finds the peak and rising edge and then
            % extends the envelope by (dead time - rising time) forming a 
            % square function.
            % NOTE How useful is this function, should this be used to alter 
            %       the value calculated by SetJitterPerformance?

            N = numel(Detector.Histogram_Data);
            index = linspace(1, N, N);
            times = Detector.Histogram_Bin_Width .* index;

            peak_loc = index(Detector.Histogram_Data ...
                             == max(Detector.Histogram_Data));

            min_val = 0.01;
            max_val = 0.01;
            up_to_max = ( Detector.Histogram_Data ...
                          > (min_val * min(Detector.Histogram_Data)) ) ...
                        & (times < times(peak_loc));

            rising = up_to_max ...
                     & ( Detector.Histogram_Data ...
                         > (min_val * max(Detector.Histogram_Data)) );

            after_max = (times > times(peak_loc));
            falling = after_max & ...
                      ( Detector.Histogram_Data ...
                        > (min_val * max(Detector.Histogram_Data)) );

            rise_time = sum(fliplr(extrema(times(rising))) .* [1, -1]);

            additional_dead_time = dead_time - rise_time;
            stretched_histogram = Detector.Histogram_Data;
            max_time = times(peak_loc) + additional_dead_time;
            waveform_mask = (times < max_time) & (times > times(peak_loc));
            stretched_histogram(waveform_mask) = max(Detector.Histogram_Data);
        end

        function p = PlotDetectorHistogram(Detector)

            N = numel(Detector.Histogram_Data);
            index = linspace(1, N, N);
            times = (index - N) ./ 2 * Detector.Histogram_Bin_Width;

            bins = unique(Detector.Histogram_Data);
            n_bins = numel(bins);
            counts = zeros(1, n_bins);
            for i = 1:n_bins
                counts(i) = sum(Detector.Histogram_Data == bins(i));
            end

            Take = @(arraylike, N) arraylike(N);
            cut_on = Take(bins(log10(counts) < 1), 1);
            mask = Detector.Histogram_Data > cut_on;

            [max_val, max_idx] = max(Detector.Histogram_Data);
            [i_val, i_idx] = max(index(mask))

            p = plot(times(mask), Detector.Histogram_Data(mask));
            xlim(times([max_idx-i_idx, max_idx+i_idx]))

        end

        function [rise_time, fall_time] = DetectorTimeConstants(Detector)
            % Calculate the length of time taken for the Detector histogram to
            % rise and fall. Returns a seperate value for rise and fall time.

            assert(Detector.Histogram_Bin_Width > 0, ...
                   'Histogram_Bin_Width must be greater than 0');
            assert(~isempty(Detector.Histogram_Data), ...
                   'No histogram data in Detector');

            N = numel(Detector.Histogram_Data);
            index = linspace(1, N, N);
            time_arr = index .* Detector.Histogram_Bin_Width;
            centre = time_arr(Detector.Histogram_Data ...
                              == max(Detector.Histogram_Data));

            % all languages should have a quick way of getting minmax
            extrema = @(array) [min(array), max(array)];

            % from an array of times get the difference from the first and last
            time_difference = @(times) sum(fliplr( extrema(times)) .* [1, -1]);

            % Assuming 10-90 rise/fall times for an electrical signal
            min_cut_off = 0.1;
            max_cut_off = 0.9;

            min_counts = min(Detector.Histogram_Data);
            max_counts = max(Detector.Histogram_Data);

            % Find where the time array is greater than the cut-off and get the
            % first and last points of this region
            peak_points = extrema( time_arr(Detector.Histogram_Data ...
                                   > (max_counts * max_cut_off)) );

            % Get the indices of the rising edge of the pulse
            rise_index = index( ( Detector.Histogram_Data ...
                                  > min_cut_off * min_counts ) ...
                               & ( time_arr < peak_points(1) ) );

            % Do the same for the falling edge
            fall_index = index( ( Detector.Histogram_Data ...
                                  > min_cut_off * min_counts ) ...
                               & ( time_arr > peak_points(2) ) );

            rise_time = time_difference( extrema( time_arr(rise_index) ) );
            fall_time = time_difference( extrema( time_arr(fall_index) ) );
        end

        function Detector = SetDarkCountRate(Detector,DCR)
            %%SETDARKCOUNTRATE set detector dark count rate
            Detector.Dark_Count_Rate = DCR;
        end

        function Detector = SetPolarisationError(Detector,Polarisation_Error)
            %%GETPOLARISATIONERROR set the polarisation error in a
            %%modelled polarisation compensation system

            %(polarisation error is recorded in degrees)
            Detector.Polarisation_Error = Polarisation_Error;
        end

        function [wavelengths, efficiency] = LoadDetectorEfficiency(Detector)
            %%LOADDETECTOREFFICIENCY load in data used to calculate
            %%detection efficiency at the operation wavelength
            if isempty(Detector.Efficiency_Data_Location)
                wavelengths = Detector.Wavelength;
                efficiency = Detector.Detection_Efficiency;
            else
                data = load(Detector.Efficiency_Data_Location);
                wavelengths = data.wavelengths;
                efficiency = data.efficiency;
            end

        end

        function Detector = CalculateDetectionEfficiency(Detector)
            %%CALCULATEDETECTIONEFFICIENCY calculate
            %%detection efficiency at the operation wavelength
            if sum(Detector.Valid_Wavelength == Detector.Wavelength) > 1
                Detector.Detection_Efficiency = Detector.Detector_Efficiency_arr(Detector.Wavelength);
                return;
            end

            if min(Detector.Valid_Wavelength) > Detector.Wavelength
                Detector.Detection_Efficiency = 0;
                return
            end

            if max(Detector.Valid_Wavelength) < Detector.Wavelength
                Detector.Detection_Efficiency = 0;
                return
            end

            pw_poly = interp1(Detector.Valid_Wavelength, ...
                              Detector.Detector_Efficiency_arr, 'cubic', 'pp');
            Detector.Detection_Efficiency = ppval(pw_poly, ...
                                                  Detector.Wavelength);

        end
    end
end


%         function Detector = SetJitterPerformance(Detector, Histogram, ...
%                                                  Bin_Width, Gate_Width, ...
%                                                  Repetition_Rate)
%         function Detector = SetJitterPerformance(Detector, Repetition_Rate)
%             % Repetition Rate: This is the rate of photons ARRIVING at the
%             % detector, this will need to be recalculated for every value of
%             % photons arriving at the detector.
% 
%             % How do we optimise the calculations this performs?
% 
%             %%SETJITTERPERFORMANCE compute the QBER and loss due to jitter and record it in the detector.
% 
%             %% input validation
%             %check that Histogram is a correctly computed histogram
%             if ~(numel(Detector.Histogram_Data) > 1) && all(isreal(Detector.Histogram_Data) & Detector.Histogram_Data > 0)
%                 error('Detector.Histogram_Data must be a correctly computed count histogram, of many elements containing positive values')
%             end
%             %check that Detector.Histogram_Bin_Width is a real scalar  > 0
%             if ~isscalar(Detector.Histogram_Bin_Width) && isreal(Detector.Histogram_Bin_Width) && Detector.Histogram_Bin_Width > 0
%                 error('Detector.Histogram_Bin_Width must be a scalar real value  > 0')
%             end
%             %check that repetition rate is a real scalar  > 0
%             if ~isscalar(Repetition_Rate) && isreal(Repetiton_Rate) && Repetition_Rate > 0
%                 error('Repetition_Rate must be a scalar real value  > 0')
%             end
%             %check that gate width is a real scalar  > 0
%             if ~isscalar(Detector.Time_Gate_Width) && isreal(Detector.Time_Gate_Width) && Detector.Time_Gate_Width > 0
%                 error('Detector.Time_Gate_Width must be a scalar real value  > 0')
%             end
% 
%             %% turn Detector.Histogram_Data into a CDF
%             Total_Counts = sum(Detector.Histogram_Data);
%             N = numel(Detector.Histogram_Data);
%             CDF = zeros(1,N);
%             PDF = zeros(1,N);
%             
%             %iterating over elements in the Detector.Histogram_Data
%             PDF(1) = Detector.Histogram_Data(1)/Total_Counts;
%             CDF(1) = 0;
%             for i = 2:N
%                 PDF(i) = Detector.Histogram_Data(i)/Total_Counts;
%                 CDF(i) = sum(PDF(1:i));
%             end
% 
%             %% turn time measures into index increments
%             Time_Gate_Width_Index = 2 * round(Detector.Time_Gate_Width / (2 * Detector.Histogram_Bin_Width));
%             Repetition_Period_Index = round(1 / (Repetition_Rate * Detector.Histogram_Bin_Width));
%             %check that rounding results in reasonable precision
%             if Time_Gate_Width_Index < 10
%                 warning('gate width is less than 10 histogram bins resulting in rounding errors')
%             end
%             if Repetition_Period_Index < 10
%                 warning('repetition period is less than 10 histogram bins resulting in rounding errors')
%             end
% 
%             %% compute mode point
%             [~,Mode_Time_Index] = max(PDF);
% 
%             %% compute loss
%             Loss =  - CDF(max(Mode_Time_Index - Time_Gate_Width_Index / 2, 1)) ...
%                     + CDF(min(Mode_Time_Index + Time_Gate_Width_Index / 2, N));
% 
%             %% compute QBER
%             QBER = 0;
% 
%             %iterating over previous pulses
%             Current_Shifted_Mode = Mode_Time_Index + Repetition_Period_Index;
%             while Current_Shifted_Mode < N
%                 QBER = QBER ...
%                        + 0.5*(CDF(min(Current_Shifted_Mode ...
%                                       + Time_Gate_Width_Index / 2, N)) ...
%                        - CDF(max(Current_Shifted_Mode ...
%                                  - Time_Gate_Width_Index / 2, 1)) );
% 
%                 Current_Shifted_Mode = Current_Shifted_Mode ...
%                                        + Repetition_Period_Index;
%             end
% 
%             %iterating over forward pulses
%             Current_Shifted_Mode = Mode_Time_Index - Repetition_Period_Index;
%             while Current_Shifted_Mode > 0
%                 QBER = QBER ...
%                        + 0.5*(CDF(min(Current_Shifted_Mode ...
%                                       + Time_Gate_Width_Index / 2, N)) ...
%                        - CDF(max(Current_Shifted_Mode ...
%                                  - Time_Gate_Width_Index / 2, 1)) );
%                 Current_Shifted_Mode = Current_Shifted_Mode ...
%                                        - Repetition_Period_Index;
%             end
%             %QBER cannot exceed 0.5 due to this
%             if QBER > 0.5
%                 QBER = 0.5;
%             end
% 
% 
%             %% store answers
%             Detector.QBER_Jitter = QBER;
%             Detector.Jitter_Loss = Loss;
%         end
