classdef testclass
    enumeration
        HV ( @thing1 )
        AF ( @AFGL_Plus )
    end

    properties
        Model
    end

    methods
        function t = testclass(m)
            t.Model = m;
        end
    end
end

function model = thing1(e)
    arguments
        e.HV HufnagelValley
    end
    model = e;
end
