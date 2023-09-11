classdef disort_intcor
    properties
        Value
    end
    methods
        function di = disort_intcor(val)
            arguments
                val {mustBeMember(val, {'phase', 'moments', 'off'})};
            end
            di.Value = val;
        end
    end
end
