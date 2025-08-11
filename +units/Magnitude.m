classdef Magnitude
    enumeration
        pico
        nano
        micro
        milli
        none
        Kilo
        Mega
        Giga
        Tera
    end

    methods (Static)

        function e = exponent(magnitude)
            % Returns the base-10 exponent associated with a magnitude.
            %
            % Syntax:
            % e = Magnitude.exponent(magnitude)

            arguments
                magnitude units.Magnitude
            end

            switch magnitude
                case units.Magnitude.pico
                    e = -12;
                case units.Magnitude.nano
                    e = -9;
                case units.Magnitude.micro
                    e = -6;
                case units.Magnitude.milli
                    e = -3;
                case units.Magnitude.none
                    e = 0;
                case units.Magnitude.Kilo
                    e = 3;
                case units.Magnitude.Mega
                    e = 6;
                case units.Magnitude.Giga
                    e = 9;
                case units.Magnitude.Tera
                    e = 12;
            end
        end

        function r = ratio(A, B)
            % Returns the exponent difference between two magnitudes.
            %
            % Syntax:
            % r = Magnitude.ratio(A, B)

            arguments
                A units.Magnitude
                B units.Magnitude
            end

            r = units.Magnitude.exponent(B) - units.Magnitude.exponent(A);
        end

        function f = factor(A, B)
            % Returns the scaling factor from magnitude A to magnitude B.
            %
            % Syntax:
            % f = Magnitude.factor(A, B)

            arguments
                A units.Magnitude
                B units.Magnitude
            end

            f = 10 ^ units.Magnitude.ratio(A, B);
        end

        function result = convert(A, B, values)
            % Converts values from magnitude A to magnitude B.
            %
            % Syntax:
            % result = Magnitude.convert(A, B, values)

            arguments
                A units.Magnitude
                B units.Magnitude
                values
            end

            result = values .* units.Magnitude.factor(B, A);

            % Example:
            % wavelength = 1.55; % microns
            % wvl_in_nm = Magnitude.convert(Magnitude.micro, Magnitude.nano, wavelength);
            % assert(wvl_in_nm == 1550);
        end

    end
end