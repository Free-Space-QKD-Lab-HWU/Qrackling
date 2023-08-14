% HufnagelValley - A MATLAB class for the Hufnagel-Valley model that calculates the refractive index structure constant for the atmosphere.
%
% Example usage:
%   % Create an instance of HufnagelValley using one of the predefined enumerations
%   hvModel = HufnagelValley.HV5_7;
%
%   % Calculate the refractive index structure constant at altitude 500 meters
%   altitude = 500;
%   ghv = hvModel.Calculate(altitude);
%
%   % Display the result
%   disp(ghv);
%
%   Output:
%   ghv =
%      3.0801e-16
%
% See also: HufnagelValley.HV5_7, HufnagelValley.HV10_10, HufnagelValley.HV15_12

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
            % HufnagelValley - Constructor for the HufnagelValley class.
            %
            %   HV = HufnagelValley(A, B, C, HA, HB, HC) creates an instance of the HufnagelValley class with the specified coefficients and parameters.
            %
            %   Input:
            %   - A: Coefficient A (numeric)
            %   - B: Coefficient B (numeric)
            %   - C: Coefficient C (numeric)
            %   - HA: Hufnagel-Valley parameter HA (numeric)
            %   - HB: Hufnagel-Valley parameter HB (numeric)
            %   - HC: Hufnagel-Valley parameter HC (numeric)

            HV.A = A;
            HV.B = B;
            HV.C = C;
            HV.HA = HA;
            HV.HB = HB;
            HV.HC = HC;
        end

        %function ghv = Calculate(HV, altitude, options)
        function ghv = Calculate(HV, altitude, options)
            % Calculate - Calculates the refractive index structure constant using the Hufnagel-Valley model.
            %
            %   ghv = Calculate(HV, altitude, options) calculates the refractive index structure constant at the given altitude using the Hufnagel-Valley model.
            %
            %   Inputs:
            %   - HV: HufnagelValley object
            %   - altitude: Altitude at which the refractive index structure constant is to be calculated (double)
            %   - options.Prefactor: Prefactor value (optional, default = 1)
            %
            %   Output:
            %   - ghv: Refractive index structure constant (numeric array)

            arguments
                HV HufnagelValley
                altitude double
                options.Prefactor double = 1
                options.AltitudeUnit OrderOfMagnitude = OrderOfMagnitude.Kilo
            end

            % We probably want to work in kilometres for altitudes however our
            % internal values for heights (h and H) are in metres...
            exponent = OrderOfMagnitude.Ratio(options.AltitudeUnit, "none");

            ghv = HufnagelValley.HvCalculation( ...
                altitude .* (10^exponent), ...
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
