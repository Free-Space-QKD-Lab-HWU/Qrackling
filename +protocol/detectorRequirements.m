classdef detectorRequirements

    enumeration
        Wavelength, QBER_Jitter,     Time_Gate_Width,
        Dead_Time,  Dark_Count_Rate, Visibility,
    end

    methods (Static)
        function reqs = features(requirement)
            arguments (Repeating)
                requirement protocol.detectorRequirements
            end
            reqs = unique([requirement{:,:}]);
        end
    end
end
