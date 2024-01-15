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
        function alice = Alice(obj, loss, background_rates)
            arguments
                obj {protocol.isOrHasSource}
                loss {mustBeNumeric} = 1
                background_rates {mustBeNumeric} = 0
            end
            disp('overload')

            source = utilities.getPropertyFromObject(obj, 'components.Source');

            % Alice doesn't need to have a detector for some qkd schemes, so we
            % need to test for it. utilities.getPropertyFromObject will error
            % if the object doesn't contain the object. If we error just make an
            % empty detector to pass into the Alice constructor
            try
                det = utilities.getPropertyFromObject(obj, 'components.Detector');
                disp(det)
                alice = protocol.Alice(source, det, loss, background_rates);
                return
            catch
                det = components.Detector.empty(0);
                alice = protocol.Alice(source, det, loss, background_rates);
            end
        end
    end
end
