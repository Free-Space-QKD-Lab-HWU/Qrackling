classdef Angle
    enumeration
        Degrees, Radians
    end

    methods(Static)

        function out = ToDegrees(Convention, Angles)
            arguments
                Convention units.Angle
                Angles {mustBeNumeric}
            end

            if Convention == units.Angle.Degrees
                out = Angles;
                return
            end

            out = rad2deg(Angles);
        end

        function out = ToRadians(Convention, Angles)
            arguments
                Convention units.Angle
                Angles {mustBeNumeric}
            end

            if Convention == units.Angle.Radians
                out = Angles;
                return
            end

            out = deg2rad(Angles);
        end

    end

end
