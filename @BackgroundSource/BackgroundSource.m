classdef BackgroundSource
    properties (SetAccess = protected)
        unit
        label
        values
    end
    methods
        function background = BackgroundSource(unit, label, values)
            arguments
                unit {mustBeMember(unit, ["irradiance", "radiance", "per_second"])}
                label {mustBeText}
                values {mustBeNumeric}
            end
            background.unit = unit;
            background.label = label;
            background.values = values;
        end

        function photons = CountsFromRadiance(background, fov, diameter, wavelength, filter_width)
(radiance, FOV, rx_diameter, wavelength, ...
                         filter_width, integration_time)
        end

    end
end
