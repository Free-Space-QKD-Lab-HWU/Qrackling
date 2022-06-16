classdef GeonSi_Detector_Factory<DetectorFactory
    %GeonSi_Detector_Factory a factory class which creates detector
    %objects with the characteristics of Xin Yi's GeonSi detectors

    properties (SetAccess=protected,Abstract=false)
        Dark_Count_Rate=2*10^4;
        Dead_Time=0;
        Histogram_Data=getfield(load('GeonSiHistogram.mat'),'Counts');
        Histogram_Bin_Width=9.766*10^-12;
        Detection_Efficiency=0.4;
    end

    methods
        function obj = GeonSi_Detector_Factory()
            %GeonSi_Detector_Factory Construct an instance of this class
        end

        function GeonSi_Detector = CreateDetector(GeonSi_Detector_Factory,Wavelength,Protocol,Time_Gate_Width,Spectral_Filter_Width,Repetition_Rate)
            %CreateDetector Create a hamamatsu detector object with the
            %specified properties
            switch Protocol
                case 'BB84'
            GeonSi_Detector=BB84_Detector(Wavelength,GeonSi_Detector_Factory.Detection_Efficiency,GeonSi_Detector_Factory.Dark_Count_Rate,GeonSi_Detector_Factory.Dead_Time,GeonSi_Detector_Factory.Histogram_Data,GeonSi_Detector_Factory.Histogram_Bin_Width,Time_Gate_Width,Spectral_Filter_Width,Repetition_Rate);
                case 'decoyBB84'
          GeonSi_Detector=decoyBB84_Detector(Wavelength,GeonSi_Detector_Factory.Detection_Efficiency,GeonSi_Detector_Factory.Dark_Count_Rate,GeonSi_Detector_Factory.Dead_Time,GeonSi_Detector_Factory.Histogram_Data,GeonSi_Detector_Factory.Histogram_Bin_Width,Time_Gate_Width,Spectral_Filter_Width,Repetition_Rate);
                otherwise
                    error('GeonSi detectors are restricted to BB84 or decoyBB84 protocols')
            end
        end
    end
end