classdef E91_Detector < Detector
    %BB84_Receiver provide the properties of the telescope to be used
    %for the HOGS

    properties(SetAccess=protected,Abstract=false)
        Dark_Count_Rate{mustBeNonnegative,mustBeScalarOrEmpty}             %frequency of dark counts of receivers' detectors in cps
        Time_Gate_Width{mustBePositive,mustBeScalarOrEmpty}                %width of the time gate used in s
        Spectral_Filter_Width{mustBePositive,mustBeScalarOrEmpty}          %spectral filter width in nm
        Dead_Time{mustBeNonnegative}                                       %dead time of detector in s
    end

    methods
        function obj = E91_Detector(Wavelength,Detection_Efficiency,Dark_Count_Rate,Dead_Time,Histogram_Data,Histogram_Bin_Width,Time_Gate_Width,Spectral_Filter_Width,Repetition_Rate)
            %E91_Detector Construct an instance of this class

            obj.Wavelength=Wavelength;
            obj.Detection_Efficiency=Detection_Efficiency;
            obj.Dark_Count_Rate=Dark_Count_Rate;
            obj.Time_Gate_Width=Time_Gate_Width;
            obj.Spectral_Filter_Width=Spectral_Filter_Width;
            obj.Dead_Time=Dead_Time;
            obj=SetJitterPerformance(obj,Histogram_Data,Histogram_Bin_Width,Time_Gate_Width,Repetition_Rate);
        end
    end
end