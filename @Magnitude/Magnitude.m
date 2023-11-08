classdef Magnitude
    enumeration
        pico (-12)
        nano (-9)
        micro (-6)
        milli (-3)
        none (0)
        Kilo (3)
        Mega (6)
        Giga (9)
        Tera (12)
    end

    properties
        exponent
    end

    methods
        function order = OrderOfMagnitude(exponent)
            order.exponent = exponent;
        end
    end

    % methods(Static)
    %     function r = Ratio(A, B)
    %         arguments
    %             A utilities.Magnitude
    %             B utilities.Magnitude
    %         end

    %         r = B.exponent - A.exponent;

    %     end

    % end

end
