classdef Laser_Component_Detector_Factory<DetectorFactory
    %Laser_Component_Detector_Factory a factory class which creates
    %detector objects with laser component characteristics

    properties (SetAccess=protected,Abstract=false)
        Dark_Count_Rate=10;
        Dead_Time=0;
        Histogram_Data=getfield(load('LaserComponentHistogram.mat'),'Counts');
        Histogram_Bin_Width=10^-12;
        Detection_Efficiency=0.6;
    end

    methods
        function obj = Laser_Component_Detector_Factory()
            %Perkin_Elmer_Detector_Factory Construct an instance of this class
        end

        function Laser_Component_Detector = CreateDetector(Laser_Component_Detector_Factory,Wavelength,Protocol,Time_Gate_Width,Spectral_Filter_Width,Repetition_Rate)
            %CreateDetector Create a perkin elmer detector object with the
            %specified properties
            switch Protocol
                case 'BB84'
            Laser_Component_Detector=BB84_Detector(Wavelength,Laser_Component_Detector_Factory.Detection_Efficiency,Laser_Component_Detector_Factory.Dark_Count_Rate,Laser_Component_Detector_Factory.Dead_Time,Laser_Component_Detector_Factory.Histogram_Data,Laser_Component_Detector_Factory.Histogram_Bin_Width,Time_Gate_Width,Spectral_Filter_Width,Repetition_Rate);
                case 'decoyBB84'
          Laser_Component_Detector=decoyBB84_Detector(Wavelength,Laser_Component_Detector_Factory.Detection_Efficiency,Laser_Component_Detector_Factory.Dark_Count_Rate,Laser_Component_Detector_Factory.Dead_Time,Laser_Component_Detector_Factory.Histogram_Data,Laser_Component_Detector_Factory.Histogram_Bin_Width,Time_Gate_Width,Spectral_Filter_Width,Repetition_Rate);
                otherwise
                    error('laser component detectors are restricted to BB84 or decoyBB84 protocols')
            end
        end
    end
end