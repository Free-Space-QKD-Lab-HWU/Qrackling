classdef time
    properties (SetAccess = protected)
        Year
        Month
        Day
        Hour
        Minute
        Second
    end
    methods
        function t = time(date)
            arguments
                date {mustBeA(date, 'datetime')}
            end
            t.Year = date.Year;
            t.Month = date.Month;
            t.Day = date.Day;
            t.Hour = date.Hour;
            t.Minute = date.Minute;
            t.Second = date.Second;
        end
    end
end
