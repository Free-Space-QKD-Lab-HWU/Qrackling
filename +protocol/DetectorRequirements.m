classdef DetectorRequirements

    % DetectorRequirements
    %
    % Enumeration of supported detector requirements for QKD protocols.
    % Includes timing, noise, and visibility parameters relevant to modeling.
    %
    % Syntax:
    % req = protocol.DetectorRequirements.Wavelength

    enumeration
        Wavelength
        QBER_Jitter
        Time_Gate_Width
        Dead_Time
        Dark_Count_Rate
        Visibility
    end

    methods (Static)

        function reqs = features(requirement)
            % features
            %
            % Returns a unique list of detector requirements from input arguments.
            %
            % Syntax:
            % reqs = protocol.DetectorRequirements.features(requirement1, requirement2, ...)
            %
            % Inputs:
            % requirement - (Repeating) DetectorRequirements enumeration values
            %
            % Outputs:
            % reqs - (1xN) DetectorRequirements array, unique requirements

            arguments (Repeating)
                requirement protocol.DetectorRequirements
            end

            reqs = unique([requirement{:,:}]);
        end

    end

end