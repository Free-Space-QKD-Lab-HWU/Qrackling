classdef Angle
    enumeration
        Degrees, Radians
    end

    methods

        function out = ToDegrees(Convention, Angles)
            arguments
                Convention Angle
                Angles {mustBeNumeric}
            end

            if Convention == Angle.Degrees
                out = Angles;
                return
            end

            out = rad2deg(Angles);
        end

        function out = ToRadians(Convention, Angles)
            arguments
                Convention Angle
                Angles {mustBeNumeric}
            end

            if Convention == Angle.Radians
                out = Angles;
                return
            end

            out = rad2deg(Angles);
        end

    end

end
