classdef SNSPD_780_Detector_Factory<DetectorFactory
    %SNSPD_780_Detector_Factory a factory class which creates
    %SNSPD_780_Detector objects

    properties (SetAccess=protected,Abstract=false)
        Dark_Count_Rate=10;
        Dead_Time=10^-10;
        Histogram_Data=getfield(load('SNSPD780Histogram.mat'),'Counts');
        Histogram_Bin_Width=2E-11;
        Detection_Efficiency=0.9;

    end

    methods
        function obj = SNSPD_780_Detector_Factory()
            %%SNSPD_780_Detector_Factory Construct an instance of this class
        end

        function SNSPD_780_Detector = CreateDetector(SNSPD_780_Detector_Factory,Wavelength,Protocol,Time_Gate_Width,Spectral_Filter_Width,Repetition_Rate)
            %%CREATEDETECTOR Create a SNSPD detector object with the specified properties
            switch Protocol
                case 'BB84'
            SNSPD_780_Detector=BB84_Detector(Wavelength,SNSPD_780_Detector_Factory.Detection_Efficiency,SNSPD_780_Detector_Factory.Dark_Count_Rate,SNSPD_780_Detector_Factory.Dead_Time,SNSPD_780_Detector_Factory.Histogram_Data,SNSPD_780_Detector_Factory.Histogram_Bin_Width,Time_Gate_Width,Spectral_Filter_Width,Repetition_Rate);
                case 'decoyBB84'
            SNSPD_780_Detector=decoyBB84_Detector(Wavelength,SNSPD_780_Detector_Factory.Detection_Efficiency,SNSPD_780_Detector_Factory.Dark_Count_Rate,SNSPD_780_Detector_Factory.Dead_Time,SNSPD_780_Detector_Factory.Histogram_Data,SNSPD_780_Detector_Factory.Histogram_Bin_Width,Time_Gate_Width,Spectral_Filter_Width,Repetition_Rate);
                case 'E91'
           SNSPD_780_Detector=E91_Detector(Wavelength,SNSPD_780_Detector_Factory.Detection_Efficiency,SNSPD_780_Detector_Factory.Dark_Count_Rate,SNSPD_780_Detector_Factory.Dead_Time,SNSPD_780_Detector_Factory.Histogram_Data,SNSPD_780_Detector_Factory.Histogram_Bin_Width,Time_Gate_Width,Spectral_Filter_Width,Repetition_Rate);
                otherwise
                    error('SNSPDs detectors are restricted to BB84, E91 and decoyBB84 protocols')
            end
        end
    end
end