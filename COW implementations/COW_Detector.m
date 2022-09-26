classdef COW_Detector < Detector
    %COW_Detector provide the properties of a detector required for the COW
    %protocol

    properties (SetAccess=protected)
        Dark_Count_Rate{mustBeNonnegative,mustBeScalarOrEmpty}             %frequency of dark counts of receivers' detectors in cps
        Time_Gate_Width{mustBePositive,mustBeScalarOrEmpty}                %width of the time gate used in s
        Spectral_Filter_Width{mustBePositive,mustBeScalarOrEmpty}          %spectral filter width in nm
        Dead_Time{mustBeNonnegative}                                       %dead time of detector in s
        tB{mustBePositive,mustBeScalarOrEmpty}                             % Porcetange of photons going into the key detetcion stage
        Visibility{mustBePositive,mustBeScalarOrEmpty}                     % Visibility of the interferometer
    end

    methods
        function obj = COW_Detector(Wavelength,Detection_Efficiency,Dark_Count_Rate,Dead_Time,Histogram_Data,Histogram_Bin_Width,Time_Gate_Width,Repetition_Rate,Spectral_Filter_Width,tB,V)
            %Construct an instance of the COW_Detector

            obj.Wavelength=Wavelength;
            obj.Detection_Efficiency=Detection_Efficiency;
            obj.Dark_Count_Rate=Dark_Count_Rate;
            obj.Time_Gate_Width=Time_Gate_Width;
            obj.Spectral_Filter_Width=Spectral_Filter_Width;
            obj.Dead_Time=Dead_Time;
            obj.tB=tB;
            obj.Visibility=V;
            obj=SetJitterPerformance(obj,Histogram_Data,Histogram_Bin_Width,Time_Gate_Width,Repetition_Rate);

        end
    end
end
