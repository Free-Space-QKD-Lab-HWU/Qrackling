classdef (Abstract) QKD_Transmitter < nodes.Optical_Node
    %QKD_Transmitter an abstract class implementing all of the behaviour that a
    %transmitter requires (whether satellite or OGS).

    properties
        %object containing transmitter details
        Source =[]
    end

    methods
        [Background_Count_Rates, QKD_Transmitter] = ComputeTotalBackgroundCountRate(QKD_Transmitter, Background_Sources, QKD_Receiver, Headings, Elevations, smarts_configuration, Count_Map)

        PlotBackgroundCountRates(QKD_Transmitter, Plotting_Indices, X_Axis)
    end

    methods (Abstract=false)
         
    end
end
