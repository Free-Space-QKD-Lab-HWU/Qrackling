classdef Generic_Detector_Factory<DetectorFactory
    %Perkin_Elmer_Detector_Factory a factory class which creates
    %Perkin_Elmer_Detector objects

    properties (SetAccess=protected,Abstract=false)
        Dark_Count_Rate=100;
        Dead_Time=10^-10;
        Histogram_Data=getfield(load('GenericHistogram.mat'),'Counts');
        Histogram_Bin_Width=10^-12;
        Detection_Efficiency=0.5;
        tB=0.9;
        Visibility=0.95;

    end

    methods
        function obj = Generic_Detector_Factory()
            %Perkin_Elmer_Detector_Factory Construct an instance of this class
        end

        function Generic_Detector = CreateDetector(Generic_Detector_Factory,Wavelength,Protocol,Time_Gate_Width,Spectral_Filter_Width,Repetition_Rate)
            %CreateDetector Create a perkin elmer detector object with the
            %specified properties
            switch Protocol
                case 'BB84'
            Generic_Detector=BB84_Detector(Wavelength,Generic_Detector_Factory.Detection_Efficiency,Generic_Detector_Factory.Dark_Count_Rate,Generic_Detector_Factory.Dead_Time,Generic_Detector_Factory.Histogram_Data,Generic_Detector_Factory.Histogram_Bin_Width,Time_Gate_Width,Spectral_Filter_Width,Repetition_Rate);
                case 'decoyBB84'
            Generic_Detector=decoyBB84_Detector(Wavelength,Generic_Detector_Factory.Detection_Efficiency,Generic_Detector_Factory.Dark_Count_Rate,Generic_Detector_Factory.Dead_Time,Generic_Detector_Factory.Histogram_Data,Generic_Detector_Factory.Histogram_Bin_Width,Time_Gate_Width,Spectral_Filter_Width,Repetition_Rate);
                case 'COW'
            Generic_Detector=COW_Detector(Wavelength,Generic_Detector_Factory.Detection_Efficiency,Generic_Detector_Factory.Dark_Count_Rate,Generic_Detector_Factory.Dead_Time,Generic_Detector_Factory.Histogram_Data,Generic_Detector_Factory.Histogram_Bin_Width,Time_Gate_Width,Repetition_Rate,Spectral_Filter_Width,Generic_Detector_Factory.tB,Generic_Detector_Factory.Visibility);
                case 'DPS'
            Generic_Detector=DPS_Detector(Wavelength,Generic_Detector_Factory.Detection_Efficiency,Generic_Detector_Factory.Dark_Count_Rate,Generic_Detector_Factory.Histogram_Data,Generic_Detector_Factory.Histogram_Bin_Width,Time_Gate_Width,Spectral_Filter_Width,Generic_Detector_Factory.Visibility);
                case 'E91'
           Generic_Detector=E91_Detector(Wavelength,Generic_Detector_Factory.Detection_Efficiency,Generic_Detector_Factory.Dark_Count_Rate,Generic_Detector_Factory.Dead_Time,Generic_Detector_Factory.Histogram_Data,Generic_Detector_Factory.Histogram_Bin_Width,Time_Gate_Width,Spectral_Filter_Width,Repetition_Rate);
                otherwise
                    error('perfect detectors are restricted to BB84, decoyBB84, COW protocols')
            end
        end
    end
end