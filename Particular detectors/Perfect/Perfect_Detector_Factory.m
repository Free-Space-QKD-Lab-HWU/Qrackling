classdef Perfect_Detector_Factory<DetectorFactory
    %Perkin_Elmer_Detector_Factory a factory class which creates
    %Perkin_Elmer_Detector objects

    properties (SetAccess=protected,Abstract=false)
        Dark_Count_Rate=0;
        Dead_Time=0;
        Histogram_Data=getfield(load('PerfectHistogram.mat'),'Counts');
        Histogram_Bin_Width=10^-12;
        Detection_Efficiency=1;
        tB=1;
        Visibility=1;

    end

    methods
        function obj = Perfect_Detector_Factory()
            %Perkin_Elmer_Detector_Factory Construct an instance of this class
        end

        function Perfect_Detector = CreateDetector(Perkin_Elmer_Detector_Factory,Wavelength,Protocol,Time_Gate_Width,Spectral_Filter_Width,Repetition_Rate)
            %CreateDetector Create a perkin elmer detector object with the
            %specified properties
            switch Protocol
                case 'BB84'
            Perfect_Detector=BB84_Detector(Wavelength,Perkin_Elmer_Detector_Factory.Detection_Efficiency,Perkin_Elmer_Detector_Factory.Dark_Count_Rate,Perkin_Elmer_Detector_Factory.Dead_Time,Perkin_Elmer_Detector_Factory.Histogram_Data,Perkin_Elmer_Detector_Factory.Histogram_Bin_Width,Time_Gate_Width,Spectral_Filter_Width,Repetition_Rate);
                case 'decoyBB84'
            Perfect_Detector=BB84_Detector(Wavelength,Perkin_Elmer_Detector_Factory.Detection_Efficiency,Perkin_Elmer_Detector_Factory.Dark_Count_Rate,Perkin_Elmer_Detector_Factory.Dead_Time,Perkin_Elmer_Detector_Factory.Histogram_Data,Perkin_Elmer_Detector_Factory.Histogram_Bin_Width,Time_Gate_Width,Spectral_Filter_Width,Repetition_Rate);
                case 'COW'
            Perfect_Detector=COW_Detector(Wavelength,Perfect_Detector_Factory.Detection_Efficiency,Perfect_Detector_Factory.Dark_Count_Rate,Perfect_Detector_Factory.Histogram_Data,Perfect_Detector_Factory.Histogram_Bin_Width,Time_Gate_Width,Spectral_Filter_Width,Perfect_Detector_Factory.tB,Perfect_Detector_Factory.Visibility);
                case 'DPS'
            Perfect_Detector=DPS_Detector(Wavelength,Perfect_Detector_Factory.Detection_Efficiency,Perfect_Detector_Factory.Dark_Count_Rate,Perfect_Detector_Factory.Histogram_Data,Perfect_Detector_Factory.Histogram_Bin_Width,Time_Gate_Width,Spectral_Filter_Width,Perfect_Detector_Factory.Visibility);
                otherwise
                    error('perfect detectors are restricted to BB84, decoyBB84, COW protocols')
            end
        end
    end
end