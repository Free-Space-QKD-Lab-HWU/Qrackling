classdef DPS_Detector < Detector
    %DPS_Detector provide a detector to be used for DPS

    properties (SetAccess=protected)
        Dark_Count_Rate{mustBeNonnegative,mustBeScalarOrEmpty}             %frequency of dark counts of receivers' detectors in cps
        Time_Gate_Width{mustBePositive,mustBeScalarOrEmpty}                %width of the time gate used in s
        Spectral_Filter_Width{mustBePositive,mustBeScalarOrEmpty}          %spectral filter width in nm
        Dead_Time{mustBeNonnegative}                                       %dead time of detector in s
        Visibility{mustBePositive,mustBeScalarOrEmpty}                     % Visibility of the interferometer
    end

    methods
        function obj = DPS_Detector(Wavelength,Detection_Efficiency,Dark_Count_Rate,Histogram_Data,Histogram_Bin_Width,Time_Gate_Width,Spectral_Filter_Width,V)
            %Construct an instance of the DPS_Detector
            obj.Wavelength=Wavelength;
            obj.Detection_Efficiency=Detection_Efficiency;
            obj.Dark_Count_Rate=Dark_Count_Rate;
            obj.Time_Gate_Width=Time_Gate_Width;
            obj.Spectral_Filter_Width=Spectral_Filter_Width;
            obj.V=V;
            obj=SetJitterPerformance(obj,Histogram_Data,Histogram_Bin_Width,Time_Gate_Width,Repetition_Rate);
        end
    end
end