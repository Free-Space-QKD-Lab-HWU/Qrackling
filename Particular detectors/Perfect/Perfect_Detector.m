classdef Perfect_Detector<Detector
    %Perfect_Detector a detector with Perfect properties

    properties (SetAccess=protected,Abstract=false)
        Dark_Count_Rate=0;
        Dead_Time=0;
        Histogram_Data_Location='PerfectHistogram.mat';
        Histogram_Bin_Width=10^-12;
        Detection_Efficiency=1;
        tB=1;
        Visibility=1;
    end

    methods
        function Perfect_Detector=Perfect_Detector(Wavelength,Repetition_Rate,Time_Gate_Width,Spectral_Filter_Width)
        %% constructor
        Perfect_Detector=Perfect_Detector@Detector(Wavelength,Repetition_Rate,Time_Gate_Width,Spectral_Filter_Width);
        end
    end
end