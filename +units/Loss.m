classdef Loss < double
    % Loss
    %
    % A class to represent optical losses as numeric values or in decibels.
    % Inherits from double, allowing arithmetic operations.
    % Includes a label to identify the source of the loss.

    properties
        name (1,:) char = ''
    end

    methods

        function l = Loss(x, Name)
            % Loss constructor
            %
            % Syntax:
            % l = Loss(x)
            % l = Loss(x, Name)
            %
            % Inputs:
            % x    - numeric loss value (0 ≤ x ≤ 1)
            % Name - optional label for the loss source
            %
            % Output:
            % l    - Loss object

            arguments
                x double {mustBeNonnegative, mustBeLessThanOrEqual(x, 1)}
                Name {mustBeText} = ''
            end

            l@double(x);
            l.name = char(Name);
        end

        function db = dB(x)
            % dB
            %
            % Converts loss value to decibels.
            %
            % Syntax:
            % db = x.dB()
            %
            % Output:
            % db - loss in decibels

            db = -10 * log10(x);
        end

        function disp(l)
            % disp
            %
            % Displays a Loss object in human-readable format.
            %
            % Syntax:
            % disp(l)
            %
            % Description:
            % Prints the numeric loss value, its decibel equivalent, and the optional
            % label (if provided). Supports scalar and array inputs.
            %
            % Notes:
            % - If the object is empty, a message is printed.
            % - For arrays, each element is printed on a separate line.

            if isempty(l)
                fprintf('Empty Loss object\n');
                return;
            end

            for i = 1:numel(l)
                val = double(l(i));
                db_val = l(i).dB();
                label = l(i).name;

                if label ~= ""
                    fprintf('Loss: %.4f (%.2f dB) — [%s]\n', val, db_val, label);
                else
                    fprintf('Loss: %.4f (%.2f dB)\n', val, db_val);
                end
            end
        end
    end
end
