classdef SNSPD_1550_Cryo_Detector<Detector
    %SNSPD_1550_Cryo_Detector a detector with excelitas properties

    properties (SetAccess=protected,Abstract=false)
        Dark_Count_Rate=10;
        Dead_Time=0;
        Histogram_Data_Location='SNSPD1550CryoAmpsHistogram.mat';
        Histogram_Bin_Width=2E-11;
        Detection_Efficiency=0.7;
        Efficiency_Data_Location = 'quantum_opus_1550_efficiency.mat';
    end

    methods
        function SNSPD_1550_Cryo_Detector=SNSPD_1550_Cryo_Detector(Wavelength,Repetition_Rate,Time_Gate_Width,Spectral_Filter_Width)
        %% constructor
        SNSPD_1550_Cryo_Detector=SNSPD_1550_Cryo_Detector@Detector(Wavelength,Repetition_Rate,Time_Gate_Width,Spectral_Filter_Width);
        end
    end
end
