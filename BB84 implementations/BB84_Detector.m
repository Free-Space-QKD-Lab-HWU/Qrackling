classdef  BB84_Detector < Detector
    %BB84_Detector a detector object with the properties required for the
    %BB84 protocol

    properties (Abstract=false,SetAccess=protected)
        Dark_Count_Rate{mustBeNonnegative,mustBeScalarOrEmpty}=10;         %frequency of dark counts of receivers' detectors in cps
        Time_Gate_Width{mustBePositive,mustBeScalarOrEmpty}=10^-9;         %width of the time gate used in s
        Spectral_Filter_Width{mustBePositive,mustBeScalarOrEmpty}=1;       %spectral filter width in nm
        Dead_Time{mustBeScalarOrEmpty,mustBeNonnegative}=0;                %detector dead time in s
        HistogramDataLocation{mustBeText}='none';                          %location of histogram data used to characterise this detector
        HistogramBinWidth{mustBeScalarOrEmpty,mustBePositive}=10^-12;      %bin width of the histogram data used to characterise this detector
    end
    properties(Abstract=false,SetAccess=protected)
        Protocol='BB84';
    end

    methods
        function obj = BB84_Detector(Wavelength,Detection_Efficiency,Dark_Count_Rate,Dead_Time,HistogramData,HistogramBinWidth,Time_Gate_Width,Spectral_Filter_Width,Repetition_Rate)
            %BB84_Receiver Construct an instance of this class

            if nargin==0
                return
            end
            obj.Wavelength=Wavelength;
            obj.Detection_Efficiency=Detection_Efficiency;
            obj.Time_Gate_Width=Time_Gate_Width;
            obj.Dark_Count_Rate=Dark_Count_Rate;
            obj.Dead_Time=Dead_Time;
            obj.Spectral_Filter_Width=Spectral_Filter_Width;
            %autocompute QBER propreties
            obj=SetJitterPerformance(obj,HistogramData,HistogramBinWidth,Time_Gate_Width,Repetition_Rate);
            
        end

        function decoy=ConvertToDecoy(BB84_Detector)
            %%CONVERTTODECOY convert this detector to an equivalent
            %%decoyBB84_Detector object
            decoy=decoyBB84_Detector(BB84_Detector.Wavelength,BB84_Detector.Detection_Efficiency,BB84_Detector.Dark_Count_Rate,BB84_Detector.HistogramDataLocation,...
                BB84_Detector.HistogramBinWidth,BB84_Detector.Time_Gate_Width,BB84_Detector.Spectral_Filter_Width,BB84_Detector.Repetition_Rate);
        end
    end
end