classdef Hamamatsu_Detector<Detector
    %Hamamatsu_Detector a detector with Hamamatsu properties

    properties (SetAccess=protected,Abstract=false)
        Dark_Count_Rate=10;
        Dead_Time=0;
        Histogram_Data_Location='HamamatsuHistogram.mat';
        Histogram_Bin_Width=10^-12;
        Detection_Efficiency=0.6;
        Efficiency_Data_Location = 'Hamamatsu_efficiency.mat';
    end

    methods
        function Hamamatsu_Detector=Hamamatsu_Detector(Wavelength,Repetition_Rate,Time_Gate_Width,Spectral_Filter_Width)
        %% constructor
        Hamamatsu_Detector=Hamamatsu_Detector@Detector(Wavelength,Repetition_Rate,Time_Gate_Width,Spectral_Filter_Width);
        end
    end
end
