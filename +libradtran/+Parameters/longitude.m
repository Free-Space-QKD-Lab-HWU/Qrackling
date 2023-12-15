classdef longitude
    properties (SetAccess = protected)
        Hemisphere
        Degrees
        Arcminutes
        Arcseconds
    end
    methods
        function lat = longitude(hemisphere, deg, options)
            arguments
                hemisphere {mustBeMember(hemisphere, {'E', 'W'})}
                deg {mustBeNumeric}
                options.min {mustBeNumeric}
                options.sec {mustBeNumeric}
            end
            lat.Hemisphere = hemisphere;
            lat.Degrees = deg;

            fields = fieldnames(options);
            if contains(fields, 'min')
                lat.Arcminutes = options.min;
            end
            if contains(fields, 'sec')
                lat.Arcseconds = options.sec;
            end
        end
    end
end
