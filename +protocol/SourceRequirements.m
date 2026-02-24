classdef SourceRequirements
    % SourceRequirements
    %
    % Enumeration of required source features for QKD protocols.
    % Used to validate source compatibility with protocol expectations.

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
        Local_Loss
    end

    methods (Static)

        function reqs = features(requirement)
            % features
            %
            % Returns a unique list of source requirements.
            %
            % Syntax:
            % reqs = SourceRequirements.features(requirement1, requirement2, ...)
            %
            % Inputs:
            % requirement - one or more SourceRequirements enums
            %
            % Output:
            % reqs - unique list of requirements

            arguments (Repeating)
                requirement protocol.SourceRequirements
            end

            reqs = unique([requirement{:,:}]);
        end

        function result = compatible(source, requirement)
            % compatible
            %
            % Placeholder for compatibility check between source and requirements.
            % Currently returns nothing - to be implemented.
            %
            % Syntax:
            % result = SourceRequirements.compatible(source, requirement1, ...)

            arguments
                source components.Source
            end
            arguments (Repeating)
                requirement protocol.SourceRequirements
            end

            requirements = unique([requirement{:,:}]);

            % TODO: Implement compatibility logic
            result = []; % Placeholder
        end

    end
end