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

    methods(Static)

        function e = Exponent(magnitude)
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

        function r = Ratio(A, B)
            arguments
                A units.Magnitude
                B units.Magnitude
            end
            r = units.Magnitude.Exponent(B) - units.Magnitude.Exponent(A);
        end

        function f = Factor(A, B)
            %% How many of 'A' in 'B'
            arguments
                A units.Magnitude
                B units.Magnitude
            end
            f = 10 ^ units.Magnitude.Ratio(A, B);
        end

        function result = Convert(A, B, values)
            % Converts values of magnitude 'A' to values with magnitude 'B'
            %
            % wavelength = 1.55; % wavelength in microns
            % wvl_in_nm = units.Magnitude.Convert("micro", "nano", wavelength);
            % assert(wvl_in_nm == 1550)
            arguments
                A units.Magnitude
                B units.Magnitude
                values
            end
            result = values .* units.Magnitude.Factor(B, A);
        end

    end

end
