classdef Excelitas_Detector_Factory<DetectorFactory
    %Excelitas_Detector_Factory a factory class which creates detector
    %objects with excelitas properties

    properties (SetAccess=protected,Abstract=false)
        Dark_Count_Rate=10;
        Dead_Time=0;
        Histogram_Data=getfield(load('ExcelitasHistogram.mat'),'Counts');
        Histogram_Bin_Width=10^-12;
        Detection_Efficiency=0.6;
    end

    methods
        function obj = Excelitas_Detector_Factory()
            %Excelitas_Detector_Factory Construct an instance of this class
        end

        function Excelitas_Detector = CreateDetector(Excelitas_Detector_Factory,Wavelength,Protocol,Time_Gate_Width,Spectral_Filter_Width,Repetition_Rate)
            %CreateDetector Create a perkin elmer detector object with the
            %specified properties
            switch Protocol
                case 'BB84'
            Excelitas_Detector=BB84_Detector(Wavelength,Excelitas_Detector_Factory.Detection_Efficiency,Excelitas_Detector_Factory.Dark_Count_Rate,Excelitas_Detector_Factory.Dead_Time,Excelitas_Detector_Factory.Histogram_Data,Excelitas_Detector_Factory.Histogram_Bin_Width,Time_Gate_Width,Spectral_Filter_Width,Repetition_Rate);
                case 'decoyBB84'
          Excelitas_Detector=decoyBB84_Detector(Wavelength,Excelitas_Detector_Factory.Detection_Efficiency,Excelitas_Detector_Factory.Dark_Count_Rate,Excelitas_Detector_Factory.Dead_Time,Excelitas_Detector_Factory.Histogram_Data,Excelitas_Detector_Factory.Histogram_Bin_Width,Time_Gate_Width,Spectral_Filter_Width,Repetition_Rate);
                otherwise
                    error('excelitas detectors are restricted to BB84 or decoyBB84 protocols')
            end
        end
    end
end