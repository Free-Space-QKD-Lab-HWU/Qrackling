classdef ck_lowtran_absorption
    properties (SetAccess = protected)
        Species
        State matlab.lang.OnOffSwitchState
    end
    methods
        function lowtran_absorption = ck_lowtran_absorption(species, state)
            arguments
                species {mustBeMember(species, ...
                         {'O4', 'N2','CO','SO2','NH3','NO','HNO3'})}
                state matlab.lang.OnOffSwitchState
            end
            lowtran_absorption.Species = species;
            lowtran_absorption.State = state;
        end
    end
end
