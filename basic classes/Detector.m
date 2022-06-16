classdef (Abstract) Detector
    %Receiver provide the properties of the receiver to be used for an OGS

    properties (Abstract=false)
        Detection_Efficiency{mustBeScalarOrEmpty,mustBePositive,mustBeLessThanOrEqual(Detection_Efficiency,1)}=0.5;%detection efficiency
        Wavelength{mustBeScalarOrEmpty,mustBePositive};                    %wavelength used for communication
        QBER_Jitter{mustBeNonnegative,mustBeScalarOrEmpty,mustBeLessThanOrEqual(QBER_Jitter,1)};%QBER contribution due to detectors' timing jitters
        Jitter_Loss{mustBeNonnegative};                                    %loss due to timing jitter (absolute)
    end
    properties(Abstract=true,SetAccess=protected)
        Protocol{mustBeText};
    end


    methods
       function Detector=SetWavelength(Detector,Wavelength)
                %%SETWAVELENGTH set wavelength and update FOV to reflect
                %%new value
                Detector.Wavelength=Wavelength;
            end

            function Detector=SetDetectionEfficiency(Detector,Detection_Efficiency)
                %%SETDETECTIONEFFICIENCY
                Detector.Detection_Efficiency=Detection_Efficiency;
            end
            function Detector=SetProtocol(Detector,Protocol)
                %%SETPROTOCOL 
                Detector.Protocol=Protocol;
            end

           function Detector=SetJitterPerformance(Detector,HistogramData,HistogramBinWidth,Time_Gate_Width,Repetition_Rate)
            %%SETJITTERPERFORMANCE compute the QBER and loss due to jitter and record it in the detector. 
            
            [qber_Jitter,Loss_Jitter]=JitterPerformance(HistogramData,HistogramBinWidth,Repetition_Rate,Time_Gate_Width);
            Detector.QBER_Jitter=qber_Jitter;
            Detector.Jitter_Loss=Loss_Jitter;
        end
    end
end