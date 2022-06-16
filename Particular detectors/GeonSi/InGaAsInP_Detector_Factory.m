classdef InGaAsInP_Detector_Factory<DetectorFactory
    %GeonSi_Detector_Factory a factory class which creates detector
    %objects with the characteristics of Xin Yi's GeonSi detectors

    properties (SetAccess=protected,Abstract=false)
        Dark_Count_Rate=2*10^4;
        Dead_Time=0;
        Histogram_Data=getfield(load('PerfectHistogram.mat'),'Counts');
        Histogram_Bin_Width=10^-12;
        Detection_Efficiency=0.17;
    end

    methods
        function obj = InGaAsInP_Detector_Factory()
            %GeonSi_Detector_Factory Construct an instance of this class
        end

        function InGaAsInP_Detector = CreateDetector(InGaAsInP_Detector_Factory,Wavelength,Protocol,Time_Gate_Width,Spectral_Filter_Width,Repetition_Rate)
            %CreateDetector Create a InGaAsInP detector object with the
            %specified properties
            switch Protocol
                case 'BB84'
            InGaAsInP_Detector=BB84_Detector(Wavelength,InGaAsInP_Detector_Factory.Detection_Efficiency,InGaAsInP_Detector_Factory.Dark_Count_Rate,InGaAsInP_Detector_Factory.Dead_Time,InGaAsInP_Detector_Factory.Histogram_Data,InGaAsInP_Detector_Factory.Histogram_Bin_Width,Time_Gate_Width,Spectral_Filter_Width,Repetition_Rate);
                case 'decoyBB84'
          InGaAsInP_Detector=decoyBB84_Detector(Wavelength,InGaAsInP_Detector_Factory.Detection_Efficiency,InGaAsInP_Detector_Factory.Dark_Count_Rate,InGaAsInP_Detector_Factory.Dead_Time,InGaAsInP_Detector_Factory.Histogram_Data,InGaAsInP_Detector_Factory.Histogram_Bin_Width,Time_Gate_Width,Spectral_Filter_Width,Repetition_Rate);
                otherwise
                    error('InGaAsInP detectors are restricted to BB84 or decoyBB84 protocols')
            end
        end
    end
end