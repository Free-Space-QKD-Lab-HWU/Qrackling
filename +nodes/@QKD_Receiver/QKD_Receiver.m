classdef (Abstract) QKD_Receiver < nodes.Optical_Node
    %QKD_Receiver an abstract class containing function templates for any
    %receiver architecture

    properties
        % a detector object, validated individually in subclasses
        Detector = [];

        % background count rate (in counts/s) as a function of heading and 
        % elevation, stored as a structure with fields 'Count_Rate', 'Heading' 
        % and 'Elevation'
        Background_Rates{isstruct, ...
                         isfield(Background_Rates, 'Heading'), ...
                         isfield(Background_Rates, 'Elevation'), ...
                         isfield(Background_Rates, 'Count_Rate')}

        % count rates at the Ground station due to light pollution
        Light_Pollution_Count_Rates{mustBeVector, mustBeNonnegative} = 0;

        % count rates at the Ground station due to dark counts
        Dark_Count_Rates{mustBeVector, mustBeNonnegative} = 0;

        % count rates at the Ground station due to reflected light off satellite
        Reflection_Count_Rates{mustBeVector, mustBeNonnegative} = 0;

        % count rates at the Ground station due to reflected light off satellite
        Directed_Count_Rates{mustBeVector, mustBeNonnegative} = 0;
    end

    methods (Abstract = true)

            PlotBackgroundCountRates(QKD_Receiver, Plotting_Indices, X_Axis)

            [Total_Background_Count_Rate,QKD_Receiver] = ComputeTotalBackgroundCountRate(QKD_Receiver, Background_Sources, QKD_Transmitter, Headings, Elevations, SMARTS_Configuration, Count_Map)
    end

    methods (Abstract=false)

        function bob = Bob(obj, loss, background_rates)
            arguments
                obj {protocol.isOrHasDetector}
                loss {mustBeNumeric} = 1
                background_rates {mustBeNumeric} = 0
            end
            bob = protocol.Bob(obj, loss, background_rates);
        end

    end
end
