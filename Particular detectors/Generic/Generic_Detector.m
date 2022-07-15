classdef Generic_Detector<Detector
    %Generic_Detector a detector with excelitas properties

    properties (SetAccess=protected,Abstract=false)
        Dark_Count_Rate=100;
        Dead_Time=10^-10;
        Histogram_Data_Location='GenericHistogram.mat';
        Histogram_Bin_Width=10^-12;
        Detection_Efficiency=0.5;
        tB=0.9
        Visibility=0.95;
    end

    methods
        function Generic_Detector=Generic_Detector(Wavelength,Repetition_Rate,Time_Gate_Width,Spectral_Filter_Width)
        %% constructor
        Generic_Detector=Generic_Detector@Detector(Wavelength,Repetition_Rate,Time_Gate_Width,Spectral_Filter_Width);
        end
    end
end