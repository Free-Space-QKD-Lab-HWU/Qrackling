classdef Loss < double
    % a class to implement losses as numbers or decibels

    % This class inherits from double, so can be used in arithmetic as a
    % floating point number normally.
    % However, it also includes a dB method which can be accessed
    % publically, and a label to identify the loss source
    properties
        name (1,:) char = '';
    end
    methods
        function l = Loss(x,Name)
            arguments
                x double {mustBeNonnegative,mustBeLessThanOrEqual(x,1)}
                Name {mustBeText} = '';
            end
        l@double(x);

        % make sure name is a char
        Name = char(Name);
        l.name = Name;
        end

        function db = dB(x)
            db = -10*log10(x);
        end
    end
end
