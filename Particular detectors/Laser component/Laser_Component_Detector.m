classdef Laser_Component_Detector<Detector
    %Laser_Component_Detector a detector with Laser_Component properties

    properties (SetAccess=protected,Abstract=false)
        Dark_Count_Rate=10;
        Dead_Time=0;
        Histogram_Data_Location='LaserComponentHistogram.mat';
        Histogram_Bin_Width=10^-12;
        Detection_Efficiency=0.6;
        Efficiency_Data_Location = 'LaserComponents_efficiency.mat';
    end

    methods
        function Laser_Component_Detector=Laser_Component_Detector(Wavelength,Repetition_Rate,Time_Gate_Width,Spectral_Filter_Width)
        %% constructor
        Laser_Component_Detector=Laser_Component_Detector@Detector(Wavelength,Repetition_Rate,Time_Gate_Width,Spectral_Filter_Width);
        end
    end
end
