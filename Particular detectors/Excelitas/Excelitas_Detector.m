classdef Excelitas_Detector<Detector
    %Excelitas_Detector a detector with excelitas properties

    properties (SetAccess=protected,Abstract=false)
        Dark_Count_Rate=250;
        Dead_Time=24E-9;
        Histogram_Data_Location='ExcelitasHistogram.mat';
        Histogram_Bin_Width=10^-12;
        Detection_Efficiency=0.65;
    end

    methods
        function Excelitas_Detector=Excelitas_Detector(Wavelength,Repetition_Rate,Time_Gate_Width,Spectral_Filter_Width)
        %% constructor
        Excelitas_Detector=Excelitas_Detector@Detector(Wavelength,Repetition_Rate,Time_Gate_Width,Spectral_Filter_Width);
        end
    end
end