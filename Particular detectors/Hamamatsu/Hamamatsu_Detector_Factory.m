classdef Hamamatsu_Detector_Factory<DetectorFactory
    %Hamamatsu_Detector_Factory a factory class which creates detector
    %objects with hamamatsu characteristics

    properties (SetAccess=protected,Abstract=false)
        Dark_Count_Rate=10;
        Dead_Time=0;
        Histogram_Data=getfield(load('HamamatsuHistogram.mat'),'Counts');
        Histogram_Bin_Width=10^-12;
        Detection_Efficiency=0.6;
    end

    methods
        function obj = Hamamatsu_Detector_Factory()
            %Hamamatsu_Detector_Factory Construct an instance of this class
        end

        function Hamamatsu_Detector = CreateDetector(Hamamatsu_Detector_Factory,Wavelength,Protocol,Time_Gate_Width,Spectral_Filter_Width,Repetition_Rate)
            %CreateDetector Create a hamamatsu detector object with the
            %specified properties
            switch Protocol
                case 'BB84'
            Hamamatsu_Detector=BB84_Detector(Wavelength,Hamamatsu_Detector_Factory.Detection_Efficiency,Hamamatsu_Detector_Factory.Dark_Count_Rate,Hamamatsu_Detector_Factory.Dead_Time,Hamamatsu_Detector_Factory.Histogram_Data,Hamamatsu_Detector_Factory.Histogram_Bin_Width,Time_Gate_Width,Spectral_Filter_Width,Repetition_Rate);
                case 'decoyBB84'
          Hamamatsu_Detector=decoyBB84_Detector(Wavelength,Hamamatsu_Detector_Factory.Detection_Efficiency,Hamamatsu_Detector_Factory.Dark_Count_Rate,Hamamatsu_Detector_Factory.Dead_Time,Hamamatsu_Detector_Factory.Histogram_Data,Hamamatsu_Detector_Factory.Histogram_Bin_Width,Time_Gate_Width,Spectral_Filter_Width,Repetition_Rate);
                otherwise
                    error('hamamatsu detectors are restricted to BB84 or decoyBB84 protocols')
            end
        end
    end
end