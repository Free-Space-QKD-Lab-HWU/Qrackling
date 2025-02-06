classdef Loss < double
    % a class to implement losses as numbers or decibels

    % This class inherits from double, so can be used in arithmetic as a
    % floating point number normally.
    % However, it also includes a dB method which can be accessed
    % publically
    methods
        function l = Loss(x)
            arguments
                x double {mustBeNonnegative,mustBeLessThanOrEqual(x,1)}
            end
        l@double(x);
        end

        function db = dB(x)
            db = -10*log10(x);
        end

    end
end
