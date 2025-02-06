classdef newloss < double
    % a class to implement losses as numbers or decibels

    % This class inherits from double, so can be used in arithmetic as a
    % floating point number normally.
    % However, it also includes a dB property which can be accessed
    % publically
    properties
        dB
    end
    methods
        function l = newloss(x)
            arguments
                x double {mustBeNonnegative,mustBeLessThanOrEqual(x,1)}
            end
        l@double(x);
        l.dB = -10*log10(x);
        end
    end
end
