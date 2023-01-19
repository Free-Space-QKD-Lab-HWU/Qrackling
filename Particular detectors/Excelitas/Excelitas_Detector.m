classdef Excelitas_Detector<Detector
    %Excelitas_Detector a detector with excelitas properties

    properties (SetAccess=protected,Abstract=false)
        Dark_Count_Rate=250;
        Dead_Time=24E-9;
        Histogram_Data_Location='ExcelitasHistogram.mat';
        Histogram_Bin_Width=10^-12;
        Detection_Efficiency=0.65;
        Efficiency_Data_Location = 'Excelitas_efficiency.mat';
    end

    methods
        function Excelitas_Detector=Excelitas_Detector(Wavelength, ...
                                                       Repetition_Rate, ...
                                                       Time_Gate_Width, ...
                                                       Spectral_Filter_Width, ...
                                                       varargin)

            p  =  inputParser();
            addRequired(p, 'Wavelength');
            addRequired(p, 'Repetition_Rate');
            addRequired(p, 'Time_Gate_Width');
            addRequired(p, 'Spectral_Filter_Width');
            addParameter(p, 'Dead_Time', nan);
            parse(p, Wavelength, Repetition_Rate, Time_Gate_Width, ...
                  Spectral_Filter_Width, varargin{:});
        %% constructor
        disp(p.Results)
            Excelitas_Detector = Excelitas_Detector@Detector(Wavelength, ...
                                                             Repetition_Rate, ...
                                                             Time_Gate_Width, ...
                                                             Spectral_Filter_Width,...
                                                             Dead_Time=p.Results.Dead_Time);
        end
    end
end
