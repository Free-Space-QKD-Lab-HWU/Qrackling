classdef HufnagelValley

    enumeration
        HV5_7 ( 17e-15, 27e-17, 3.59e-53, 100, 1500, 1000 )

        HV10_10 ( 4.5e-15, 9e-17, 2e-53, 100, 1500, 1000 )

        HV15_12 ( 2e-15, 7e-17, 1.54e-53, 100, 1500, 1000 )

    % Custom (@(a, b, c, ha, hb, hc) [a, b, c, ha, hb, hc])
    end

    properties
        A {mustBeNumeric}
        B {mustBeNumeric}
        C {mustBeNumeric}
        HA {mustBeNumeric}
        HB {mustBeNumeric}
        HC {mustBeNumeric}
    end

    methods

        function HV = HufnagelValley(A, B, C, HA, HB, HC)
            HV.A = A;
            HV.B = B;
            HV.C = C;
            HV.HA = HA;
            HV.HB = HB;
            HV.HC = HC;
        end

        function ghv = Calculate(HV, altitude, options)
            arguments
                HV HufnagelValley
                altitude double
                options.Prefactor double = 1
            end

            ghv = HufnagelValley.HvCalculation( ...
                altitude, ...
                HV.A, HV.B, HV.C, ...
                HV.HA, HV.HB, HV.HC, ...
                Prefactor = options.Prefactor);
        end

    end

    methods (Static)
        function ghv = HvCalculation(altitude, A, B, C, HA, HB, HC, options)
            arguments
                altitude double
                A {mustBeNumeric}
                B {mustBeNumeric}
                C {mustBeNumeric}
                HA {mustBeNumeric}
                HB {mustBeNumeric}
                HC {mustBeNumeric}
                options.Prefactor double = 1
            end

            pre = options.Prefactor;

            ghv = ((pre*A) .* exp(-altitude ./ (pre*HA))) ...
                   + ((pre*B) .* exp(-altitude ./ (pre*HB))) ...
                   + ((pre*C) .* (altitude.^10) .* exp(-altitude ./ (pre*HC)));
        end
    end

end
