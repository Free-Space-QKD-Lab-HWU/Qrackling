classdef (Abstract) DetectorFactory
    %DETECTORFACTORY a class containing all of the information required to
    %create a detector with particular characteristics and a method to
    %create such a detector
properties (Abstract,SetAccess=protected)
        Dark_Count_Rate                                                    %count rate (in cps) resulting from internal noise
        Dead_Time                                                          %time after a count for which the detector cannot respond to a photon
        Detection_Efficiency                                               %probability that an incident photon causes a count
        Histogram_Data;                                                    %histogram of photon counts in response to repeated pulses
        Histogram_Bin_Width;                                               %bin width (in s) of the above histogram
end

    methods
         Detector=CreateDetector(DetectorFactory,Wavelength,Protocol,Repetition_Rate,varargin)

         function PlotHistogram(DetectorFactory)
             %%PLOTHISTOGRAM plot the timing jitter histogram of this
             %%detector type
             plot((DetectorFactory.Histogram_Bin_Width)*(0:numel(DetectorFactory.Histogram_Data)-1),DetectorFactory.Histogram_Data*(1/(sum(DetectorFactory.Histogram_Data)*DetectorFactory.Histogram_Bin_Width)));
             xlabel('Time (s)')
             ylabel('Probability Density Function (1/s)')
         end
    end
end