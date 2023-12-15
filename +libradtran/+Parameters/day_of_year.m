classdef day_of_year
    properties (SetAccess = protected)
        Value
    end
    methods
        function day = day_of_year(d)
            %arguments
            %    date %{mustBeA(date, 'datetime')}
            %end
            disp(d);
            day.Value = day(d, "dayofyear");
        end
    end
end
