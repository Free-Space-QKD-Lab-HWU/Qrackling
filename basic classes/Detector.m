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

        % polarisation reference is required for polarisation encoded QKD.
        % poor polarisation compensation results in high QBER. We describe
        % the rms error in polarisation compensation determines the QBER in
        % degrees
        Polarisation_Error{mustBeScalarOrEmpty, mustBeNonnegative} = asind(1/280);
        %default value modelled off Micius

        Valid_Wavelength;
        Detector_Efficiency_arr;
    end
    properties(Abstract = true,SetAccess = protected)
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
            [Histogram_Data,Histogram_Bin_Width] = LoadHistogramData(Detector);
            %if ~isnan(p.Results.Bin_Width)
            %    Histogram_Bin_Width  =  p.Results.Bin_Width
            %    Detector.Histogram_Bin_Width  =  p.Results.Bin_Width;
            %end

            Detector = SetJitterPerformance(Detector, Histogram_Data, ...
                                            Histogram_Bin_Width, ...
                                            Time_Gate_Width, Repetition_Rate);

            [wavelengths, efficiency] = LoadDetectorEfficiency(Detector);
            Detector.Valid_Wavelength = wavelengths;
            Detector.Detector_Efficiency_arr = efficiency;
            Detector = CalculateDetectionEfficiency(Detector);
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

        function Detector = SetJitterPerformance(Detector, Histogram, ...
                                                 Bin_Width, Gate_Width, ...
                                                 Repetition_Rate)
            %%SETJITTERPERFORMANCE compute the QBER and loss due to jitter and record it in the detector.

            %% input validation
            %check that Histogram is a correctly computed histogram
            if ~(numel(Histogram) > 1) && all(isreal(Histogram) & Histogram > 0)
                error('Histogram must be a correctly computed count histogram, of many elements containing positive values')
            end
            %check that Bin_Width is a real scalar  > 0
            if ~isscalar(Bin_Width) && isreal(Bin_Width) && Bin_Width > 0
                error('Bin_Width must be a scalar real value  > 0')
            end
            %check that repetition rate is a real scalar  > 0
            if ~isscalar(Repetition_Rate) && isreal(Repetiton_Rate) && Repetition_Rate > 0
                error('Repetition_Rate must be a scalar real value  > 0')
            end
            %check that gate width is a real scalar  > 0
            if ~isscalar(Gate_Width) && isreal(Gate_Width) && Gate_Width > 0
                error('Gate_Width must be a scalar real value  > 0')
            end

            %% turn Histogram into a CDF
            Total_Counts = sum(Histogram);
            N = numel(Histogram);
            CDF = zeros(1,N);
            PDF = zeros(1,N);
            
            %iterating over elements in the Histogram
            PDF(1) = Histogram(1)/Total_Counts;
            CDF(1) = 0;
            for i = 2:N
                PDF(i) = Histogram(i)/Total_Counts;
                CDF(i) = sum(PDF(1:i));
            end

            %% turn time measures into index increments
            Gate_Width_Index = 2 * round(Gate_Width / (2 * Bin_Width));
            Repetition_Period_Index = round(1 / (Repetition_Rate * Bin_Width));
            %check that rounding results in reasonable precision
            if Gate_Width_Index < 10
                warning('gate width is less than 10 histogram bins resulting in rounding errors')
            end
            if Repetition_Period_Index < 10
                warning('repetition period is less than 10 histogram bins resulting in rounding errors')
            end

            %% compute mode point
            [~,Mode_Time_Index] = max(PDF);

            %% compute loss
            Loss =  - CDF(max(Mode_Time_Index - Gate_Width_Index / 2, 1)) ...
                    + CDF(min(Mode_Time_Index + Gate_Width_Index / 2, N));

            %% compute QBER
            QBER = 0;

            %iterating over previous pulses
            Current_Shifted_Mode = Mode_Time_Index + Repetition_Period_Index;
            while Current_Shifted_Mode < N
                QBER = QBER ...
                       + 0.5*(CDF(min(Current_Shifted_Mode ...
                                      + Gate_Width_Index / 2, N)) ...
                       - CDF(max(Current_Shifted_Mode ...
                                 - Gate_Width_Index / 2, 1)) );

                Current_Shifted_Mode = Current_Shifted_Mode ...
                                       + Repetition_Period_Index;
            end

            %iterating over forward pulses
            Current_Shifted_Mode = Mode_Time_Index - Repetition_Period_Index;
            while Current_Shifted_Mode > 0
                QBER = QBER ...
                       + 0.5*(CDF(min(Current_Shifted_Mode ...
                                      + Gate_Width_Index / 2, N)) ...
                       - CDF(max(Current_Shifted_Mode ...
                                 - Gate_Width_Index / 2, 1)) );
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

        function [Histogram_Data, Histogram_Bin_Width] = LoadHistogramData(...
                                                                    Detector)
            %%LOADHISTOGRAMDATA load in from an external file the data
            %%describing the timing jitter of a detector

            %% load in data
            Histogram_Data = getfield(...
                                    load(Detector.Histogram_Data_Location), ...
                                    'Counts');
            Histogram_Bin_Width = Detector.Histogram_Bin_Width;
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
            data = load(Detector.Efficiency_Data_Location);
            wavelengths = data.wavelengths;
            efficiency = data.efficiency;
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
