classdef altitude
    properties (Access = protected)
        bottom_level {mustBeNumeric}
        vertical_resolution {mustBeNumeric}
    end

    methods
        function alt = altitude(A, options)
            arguments
                A {mustBeNumeric}
                options.resolution {mustBeNumeric} = NaN
            end
            alt.bottom_level = A;
            if ~isnan(options.resolution)
                alt.vertical_resolution = options.resolution;
            end
        end
    end
end
