classdef day_of_year
    properties (SetAccess = protected)
        Value
    end
    methods
        function day = day_of_year(date)
            arguments
                date {mustBeA(date, 'datetime')}
            end
            day.Value = day(date, "dayofyear");
        end
    end
end
