classdef print_disort_info
    properties (SetAccess = protected)
        Value
    end
    methods
        function p = print_disort_info(value)
            arguments
                value {mustBeInteger, mustBeInRange(value, 1, 7)}
            end
            p.Value = value;
        end
    end
end
