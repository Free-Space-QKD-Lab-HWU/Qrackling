classdef ic_fu
    properties (SetAccess = protected)
        Type
        State matlab.lang.OnOffSwitchState
    end
    methods
        function ic = ic_fu(type, state)
            arguments
                type {mustBeMember(type, {'reff_deff', 'deltascaling'})}
                state matlab.lang.OnOffSwitchState
            end
            ic.Type = type;
            ic.State = state;
        end
    end
end
