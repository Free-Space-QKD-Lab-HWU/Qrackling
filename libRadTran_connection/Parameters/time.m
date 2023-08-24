classdef time
    properties (SetAccess = protected)
        T
    end
    methods
        function t = time(date)
            arguments
                date {mustBeA(date, 'datetime')}
            end

            t.T = strjoin({ ...
                num2str(date.Year), num2str(date.Month), ...
                num2str(date.Day), num2str(date.Hour), ...
                num2str(date.Minute), num2str(date.Second), ...
            }, ' ');
        end
    end
end
