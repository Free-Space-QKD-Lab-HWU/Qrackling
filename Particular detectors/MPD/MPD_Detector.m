classdef MPD_Detector<Detector
    %MPD_Detector a detector with MPD properties

    properties (SetAccess=protected,Abstract=false)
        Dark_Count_Rate=10;
        Dead_Time=0;
        Histogram_Data_Location='MPDHistogram.mat';
        Histogram_Bin_Width=10^-12;
        Detection_Efficiency=0.6;
    end

    methods
        function MPD_Detector=MPD_Detector(Wavelength,Repetition_Rate,Time_Gate_Width,Spectral_Filter_Width)
        %% constructor
        MPD_Detector=MPD_Detector@Detector(Wavelength,Repetition_Rate,Time_Gate_Width,Spectral_Filter_Width);
        end
    end
end
