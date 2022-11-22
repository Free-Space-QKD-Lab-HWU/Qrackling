classdef (Abstract) Detector
    %DETECTOR provide the properties of the qkd detector to be used for an OGS

    properties (Abstract = false)
        %wavelength (nm) used for communication
        Wavelength{mustBeScalarOrEmpty, mustBePositive};

        %QBER contribution due to detectors' timing jitters
        QBER_Jitter{mustBeNonnegative, mustBeScalarOrEmpty, ...
                    mustBeLessThanOrEqual(QBER_Jitter, 1)};

        %loss due to timing jitter (absolute)
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
        % the rms error in polarisation compensation determines the QBER in
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
    end


    methods
        function Detector = Detector(Wavelength, Repetition_Rate, ...
                                     Time_Gate_Width, ...
                                     Spectral_Filter_Width, ...
                                     varargin)
            
            p  =  inputParser();
            addRequired(p, 'Wavelength');
            addRequired(p, 'Repetition_Rate');
            addRequired(p, 'Time_Gate_Width');
            addRequired(p, 'Spectral_Filter_Width');
            addParameter(p, 'Bin_Width', nan);
            addParameter(p, 'Dead_Time', nan);

            parse(p, Wavelength, Repetition_Rate, Time_Gate_Width, ...
                  Spectral_Filter_Width, varargin{:});

            %%Detector Construct a detector object with properties
            %determined by implementation

            %% implement detector properties
            Detector.Wavelength = Wavelength;
            Detector.Time_Gate_Width = Time_Gate_Width;
            Detector.Spectral_Filter_Width = Spectral_Filter_Width;
            Detector.Repetition_Rate  =  Repetition_Rate;

            %% compute loss and QBER due to jitter
            % load in data for this detector
            %[Histogram_Data,Histogram_Bin_Width] = LoadHistogramData(Detector);
            Detector = LoadHistogramData(Detector);
            %if ~isnan(p.Results.Bin_Width)
            %    Histogram_Bin_Width  =  p.Results.Bin_Width
            %    Detector.Histogram_Bin_Width  =  p.Results.Bin_Width;
            %end

            %Detector = SetJitterPerformance(Detector, Histogram_Data, ...
            %                                Histogram_Bin_Width, ...
            %                                Time_Gate_Width, Repetition_Rate);

            Detector = SetJitterPerformance(Detector, Repetition_Rate);

            if isnan(p.Results.Dead_Time)
                Detector.dead_time = Detector.rise_time + Detector.fall_time;
            else
                Detector.dead_time = p.Results.Dead_Time;
                detector.rise_time = P.Results.Dead_Time / 2;
                detector.fall_time = P.Results.Dead_Time / 2;
            end

            if Detector.Efficiency_Data_Location
                [wavelengths, efficiency] = LoadDetectorEfficiency(Detector);
                Detector.Valid_Wavelength = wavelengths;
                Detector.Detector_Efficiency_arr = efficiency;
                Detector = CalculateDetectionEfficiency(Detector);
            end
        end

        function Detector = SetHistogramBinWidth(Detector,Width)
            %%SETWAVELENGTH set wavelength
            Detector.Histogram_Bin_Width  =  Width;
            [Histogram_Data, Histogram_Bin_Width] = LoadHistogramData(Detector);
            Detector = SetJitterPerformance(Detector, Histogram_Data, ...
                                            Width, Detector.Time_Gate_Width, ...
                                            Detector.Repetition_Rate);
        end

        function Detector = SetWavelength(Detector,Wavelength)
            %%SETWAVELENGTH set wavelength
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
        function Detector = SetJitterPerformance(Detector, Incident_Photon_Rate)
            % Repetition Rate: This is the rate of photons ARRIVING at the
            % detector, this will need to be recalculated for every value of
            % photons arriving at the detector.

            % How do we optimise the calculations this performs?

            %%SETJITTERPERFORMANCE compute the QBER and loss due to jitter and record it in the detector.


            %% turn time measures into index increments
            Time_Gate_Width_Index = 2 * round(Detector.Time_Gate_Width / (2 * Detector.Histogram_Bin_Width));
            Repetition_Period_Index = round(1 ./ (Incident_Photon_Rate * Detector.Histogram_Bin_Width));

            %check that rounding results in reasonable precision
            if Time_Gate_Width_Index < 10
                warning('gate width is less than 10 histogram bins resulting in rounding errors')
            end
            if Repetition_Period_Index < 10
                warning('repetition period is less than 10 histogram bins resulting in rounding errors')
            end

            %% compute mode point
            [~,Mode_Time_Index] = max(Detector.PDF);

            N = numel(Detector.Histogram_Data);
            %% compute loss
            Loss =  - Detector.CDF(max(Mode_Time_Index - Time_Gate_Width_Index / 2, 1)) ...
                    + Detector.CDF(min(Mode_Time_Index + Time_Gate_Width_Index / 2, N));

            %% compute QBER
            QBER = 0;

            % linspace(1, 21, floor(20 / 2) + 1)
            % it should be possible to perform the below calculation with by getting the pairwise extrema if we have an array for the "current shifted mode"
            %iterating over previous pulses
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

            %iterating over forward pulses
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
            Histogram_Bin_Width = Detector.Histogram_Bin_Width;

            %% input validation
            %check that Histogram is a correctly computed histogram
            if ~(numel(Detector.Histogram_Data) > 1) && all(isreal(Detector.Histogram_Data) & Detector.Histogram_Data > 0)
                error('Detector.Histogram_Data must be a correctly computed count histogram, of many elements containing positive values')
            end
            %check that Detector.Histogram_Bin_Width is a real scalar  > 0
            if ~isscalar(Detector.Histogram_Bin_Width) && isreal(Detector.Histogram_Bin_Width) && Detector.Histogram_Bin_Width > 0
                error('Detector.Histogram_Bin_Width must be a scalar real value  > 0')
            end
            % %check that repetition rate is a real scalar  > 0
            % if ~isscalar(Repetition_Rate) && isreal(Repetiton_Rate) && Repetition_Rate > 0
            %     error('Repetition_Rate must be a scalar real value  > 0')
            % end
            %check that gate width is a real scalar  > 0
            if ~isscalar(Detector.Time_Gate_Width) && isreal(Detector.Time_Gate_Width) && Detector.Time_Gate_Width > 0
                error('Detector.Time_Gate_Width must be a scalar real value  > 0')
            end

            Detector.Total_Counts = sum(Detector.Histogram_Data);
            N = numel(Detector.Histogram_Data);
            Detector.CDF = zeros(1,N);
            Detector.PDF = zeros(1,N);

            %iterating over elements in the Detector.Histogram_Data
            Detector.PDF(1) = Detector.Histogram_Data(1)/Detector.Total_Counts;
            Detector.CDF(1) = 0;
            for i = 2:N
                Detector.PDF(i) = Detector.Histogram_Data(i)/Detector.Total_Counts;
                Detector.CDF(i) = sum(Detector.PDF(1:i));
            end

            [rise_time, fall_time] = DetectorTimeConstants(Detector);
            Detector.rise_time = rise_time;
            Detector.fall_time = fall_time;

            % TODO
            % - Detector dead time behaviour needs to be over riden in the case
            %   of artificial dead times (hold times, temporal filtering, etc)
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

        function [rise_time, fall_time] = DetectorTimeConstants(Detector)
            % Calculate the length of time taken for the Detector histogram to
            % rise and fall. Returns a separete value for rise and fall time.

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
            Detector.Polarisation_Error = Polarisation_Error;
        end

        function [wavelengths, efficiency] = LoadDetectorEfficiency(Detector)
            if isempty(Detector.Efficiency_Data_Location)
                wavelengths = Detector.Wavelength;
                efficiency = Detector.Detection_Efficiency
            else
                data = load(Detector.Efficiency_Data_Location);
                wavelengths = data.wavelengths;
                efficiency = data.efficiency;
            end

        end

        function Detector = CalculateDetectionEfficiency(Detector)

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
