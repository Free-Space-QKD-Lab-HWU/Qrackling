classdef decoyBB84_Detector < BB84_Detector
    %BB84_Receiver provide the properties of the telescope to be used
    %for the HOGS
    methods
        function obj = decoyBB84_Detector(Wavelength,Detection_Efficiency,Dark_Count_Rate,Dead_Time,HistogramData,HistogramBinWidth,Time_Gate_Width,Spectral_Filter_Width,Repetition_Rate)
            %BB84_Receiver Construct an instance of this class

            if nargin==0
                return
            end
            obj.Wavelength=Wavelength;
            obj.Detection_Efficiency=Detection_Efficiency;
            obj.Dark_Count_Rate=Dark_Count_Rate;
            obj.Dead_Time=Dead_Time;
            obj.Time_Gate_Width=Time_Gate_Width;
            obj.Spectral_Filter_Width=Spectral_Filter_Width;
            obj=SetJitterPerformance(obj,HistogramData,HistogramBinWidth,Time_Gate_Width,Repetition_Rate);
            obj=SetProtocol(obj,'decoyBB84');
        end


        function Nodecoy=ConvertToNoDecoy(BB84_Detector)
            %%CONVERTTONODECOY convert this detector to an equivalent
            %%decoyBB84_Detector object
            Nodecoy=BB84_Detector(BB84_Detector.Wavelength,BB84_Detector.Detection_Efficiency,BB84_Detector.Dark_Count_Rate,BB84_Detector.HistogramDataLocation,...
                BB84_Detector.HistogramBinWidth,BB84_Detector.Time_Gate_Width,BB84_Detector.Spectral_Filter_Width,BB84_Detector.Repetition_Rate);
        end
    end

end