classdef MPD_Detector_Factory<DetectorFactory
    %MPD_Detector_Factory a factory class which creates detectpr objects
    %which have MPD characteristics

    properties (SetAccess=protected,Abstract=false)
        Dark_Count_Rate=10;
        Dead_Time=0;
        Histogram_Data=getfield(load('MPDHistogram.mat'),'Counts');
        Histogram_Bin_Width=10^-12;
        Detection_Efficiency=0.6;
    end

    methods
        function obj = MPD_Detector_Factory()
            %Perkin_Elmer_Detector_Factory Construct an instance of this class
        end

        function MPD_Detector_Factory = CreateDetector(MPD_Detector_Factory,Wavelength,Protocol,Time_Gate_Width,Spectral_Filter_Width,Repetition_Rate)
            %CreateDetector Create a MPD detector object with the
            %specified properties
            switch Protocol
                case 'BB84'
            MPD_Detector_Factory=BB84_Detector(Wavelength,MPD_Detector_Factory.Detection_Efficiency,MPD_Detector_Factory.Dark_Count_Rate,MPD_Detector_Factory.Dead_Time,MPD_Detector_Factory.Histogram_Data,MPD_Detector_Factory.Histogram_Bin_Width,Time_Gate_Width,Spectral_Filter_Width,Repetition_Rate);
                case 'decoyBB84'
          MPD_Detector_Factory=decoyBB84_Detector(Wavelength,MPD_Detector_Factory.Detection_Efficiency,MPD_Detector_Factory.Dark_Count_Rate,MPD_Detector_Factory.Dead_Time,MPD_Detector_Factory.Histogram_Data,MPD_Detector_Factory.Histogram_Bin_Width,Time_Gate_Width,Spectral_Filter_Width,Repetition_Rate);
                otherwise
                    error('MPD detectors are restricted to BB84 or decoyBB84 protocols')
            end
        end
    end
end