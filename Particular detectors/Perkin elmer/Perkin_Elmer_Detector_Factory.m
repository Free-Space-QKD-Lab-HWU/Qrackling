classdef Perkin_Elmer_Detector_Factory<DetectorFactory
    %Perkin_Elmer_Detector_Factory a factory class which creates
    %Perkin_Elmer_Detector objects

    properties (Constant)
        Dark_Count_Rate=10;
        Dead_Time=0;
        Histogram_Data=getfield(load('PerkinElmerHistogram.mat'),'Counts');
        Histogram_Bin_Width=10^-12;
        Detection_Efficiency=0.6;
    end

    methods
        function obj = Perkin_Elmer_Detector_Factory()
            %Perkin_Elmer_Detector_Factory Construct an instance of this class
        end

        function Perkin_Elmer_Detector = CreateDetector(Perkin_Elmer_Detector_Factory,Wavelength,Protocol,Time_Gate_Width,Spectral_Filter_Width,Repetition_Rate)
            %CreateDetector Create a perkin elmer detector object with the
            %specified properties
            switch Protocol
                case 'BB84'
            Perkin_Elmer_Detector=BB84_Detector(Wavelength,Perkin_Elmer_Detector_Factory.Detection_Efficiency,Perkin_Elmer_Detector_Factory.Dark_Count_Rate,Perkin_Elmer_Detector_Factory.Dead_Time,Perkin_Elmer_Detector_Factory.Histogram_Data,Perkin_Elmer_Detector_Factory.Histogram_Bin_Width,Time_Gate_Width,Spectral_Filter_Width,Repetition_Rate);
                case 'decoyBB84'
          Perkin_Elmer_Detector=BB84_Detector(Wavelength,Perkin_Elmer_Detector_Factory.Detection_Efficiency,Perkin_Elmer_Detector_Factory.Dark_Count_Rate,Perkin_Elmer_Detector_Factory.Dead_Time,Perkin_Elmer_Detector_Factory.Histogram_Data,Perkin_Elmer_Detector_Factory.Histogram_Bin_Width,Time_Gate_Width,Spectral_Filter_Width,Repetition_Rate);
                otherwise
                    error('Perkin elmer detectors are restricted to BB84 or decoyBB84 protocols')
            end
        end
    end
end