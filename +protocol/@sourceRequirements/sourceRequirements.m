classdef sourceRequirements

    enumeration
        Wavelength
        Repetition_Rate
        Efficiency
        MPN_Signal
        MPN_Decoy
        State_Prep_Error
        g2
        Probability_Signal
        Probability_Decoy
        Coincidence_Window
    end

    methods (Static)
        function reqs = features(requirement)
            arguments (Repeating)
                requirement protocol.sourceRequirements
            end
            reqs = unique([requirement{:,:}]);
        end

        function result = Compatible(source, requirement)
            arguments
                source components.Source
            end
            arguments (Repeating)
                requirement protocol.sourceRequirements
            end
            requirements = unique([requirement{:,:}]);
        end

    end
end
