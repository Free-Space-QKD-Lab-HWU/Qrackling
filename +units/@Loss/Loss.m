classdef Loss
    properties %(SetAccess = protected)
        unit
        label
        values
    end
    methods
        function loss = Loss(unit, label, values)
            arguments
                unit {mustBeMember(unit, ["probability", "dB"])}
                label {mustBeText}
                values
            end
            loss.unit = unit;
            loss.label = label;
            loss.values = values;
        end

        function loss = ConvertTo(loss, new_unit)
            arguments
                loss units.Loss
                new_unit {mustBeMember(new_unit, ["probability", "dB"])}
            end

            loss.values = loss.As(new_unit);
            loss.unit = new_unit;
        end

        function values = As(loss, new_unit)
            arguments
                loss units.Loss
                new_unit {mustBeMember(new_unit, ["probability", "dB"])}
            end

            if strcmp(loss.unit, new_unit)
                values = loss.values;
                return
            end

            switch new_unit
            case "probability"
                values = utilities.probabilityFromDecibelLoss(loss.values);
            case "dB"
                values = utilities.decibelFromProbabilityLoss(loss.values);
            end

        end

    end
end
