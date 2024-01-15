classdef sourceRequirements

    enumeration
        Wavelength,          Repetition_Rate,  Efficiency,
        Mean_Photon_Number,  State_Prep_Error, g2,
        State_Probabilities, Coincidence_Window
    end

    methods (Static)
        function reqs = features(requirement)
            arguments (Repeating)
                requirement protocol.sourceRequirements
            end
            reqs = unique([requirement{:,:}]);
        end
    end
end
