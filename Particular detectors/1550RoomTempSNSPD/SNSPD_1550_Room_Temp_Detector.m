classdef SNSPD_1550_Room_Temp_Detector<Detector
    %SNSPD_1550_Room_Temp_Detector a detector with SNSPD_1550_Room_Temp properties

    properties (SetAccess=protected,Abstract=false)
        Dark_Count_Rate=10;
        Dead_Time=0;
        Histogram_Data_Location='SNSPD_1550_Room_TempAmpsHistogram.mat';
        Histogram_Bin_Width=10^-12;
        Detection_Efficiency=0.6;
        Efficiency_Data_Location = 'quantum_opus_1550_efficiency.mat';
    end

    methods
        function SNSPD_1550_Room_Temp_Detector=SNSPD_1550_Room_Temp_Detector(Wavelength,Repetition_Rate,Time_Gate_Width,Spectral_Filter_Width)
        %% constructor
        SNSPD_1550_Room_Temp_Detector=SNSPD_1550_Room_Temp_Detector@Detector(Wavelength,Repetition_Rate,Time_Gate_Width,Spectral_Filter_Width);
        end
    end
end
