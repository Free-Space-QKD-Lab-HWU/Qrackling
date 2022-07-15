classdef SNSPD_780_Detector<Detector
    %SNSPD_780_Detector a detector with excelitas properties

    properties (SetAccess=protected,Abstract=false)
        Dark_Count_Rate=10;
        Dead_Time=10^-10;
        Histogram_Data_Location='SNSPD780Histogram.mat';
        Histogram_Bin_Width=2E-11;
        Detection_Efficiency=0.9;
    end

    methods
        function SNSPD_780_Detector=SNSPD_780_Detector(Wavelength,Repetition_Rate,Time_Gate_Width,Spectral_Filter_Width)
        %% constructor
        SNSPD_780_Detector=SNSPD_780_Detector@Detector(Wavelength,Repetition_Rate,Time_Gate_Width,Spectral_Filter_Width);
        end
    end
end