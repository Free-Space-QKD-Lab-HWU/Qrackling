classdef Perkin_Elmer_Detector<Detector
    %Perkin_Elmer_Detector a detector with Perkin_Elmer properties

    properties (SetAccess=protected,Abstract=false)
        Dark_Count_Rate=10;
        Dead_Time=0;
        Histogram_Data_Location='Perkin_ElmerHistogram.mat';
        Histogram_Bin_Width=10^-12;
        Detector_Efficiency_Data=''
        Detection_Efficiency=0.6;
        Efficiency_Data_Location = 'perkin_elmer_efficiency.mat';
    end

    methods
        function Perkin_Elmer_Detector=Perkin_Elmer_Detector(Wavelength,Repetition_Rate,Time_Gate_Width,Spectral_Filter_Width)
        %% constructor
        Perkin_Elmer_Detector=Perkin_Elmer_Detector@Detector(Wavelength,Repetition_Rate,Time_Gate_Width,Spectral_Filter_Width);
        end
    end
end
