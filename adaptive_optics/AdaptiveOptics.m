classdef AdaptiveOptics

    properties
    end

    methods(Static, Access=private)

        function result = FriedCoherenceLengthIntegral(
                wavenumber, zenith_angle, satellite_altitude, HV, options)

            arguments
                wavenumber double
                zenith_angle {mustBeVector, mustBeNumeric}
                satellite_altitude {mustBeVector, mustBeNumeric}
                HV HufnagelValley
                options.Prefactor double = 1
            end

            assert(utils.sameSize(zenith_angle, satellite_altitude), ...
                ['"', inputname(2), '" and "', inputname(3), ...
                '" Do not have matching shapes.', newline, char(9), ...
                ' Size(', inputname(2) '): ', num2str(size(zenith_angle)), ...
                newline, char(9), ' Size(', inputname(3) '): ', ...
                num2str(size(satellite_altitude))]);

            fun = @(alt, sat_alt) ...
                HV.Calculate(alt, options.Prefactor) ...
                .* ((1 - (alt ./ sat_alt)) .^ (5/3));

            result = zeros(size(satellite_altitude))
            for i = 1 : numel(satellite_altitude)
                result(i) = integral( ...
                    @(x) fun(x, satellite_altitude(i)), ...
                    0, satellite_altitude(i));
            end
        end

    end

    methods(Static)

        function r0 = FriedCoherenceLength(...
                wavenumber, zenith_angle, satellite_altitude, HV, options)

            arguments
                wavenumber double
                zenith_angle {mustBeVector, mustBeNumeric}
                satellite_altitude {mustBeVector, mustBeNumeric}
                HV HufnagelValley
                options.Prefactor double = 1
            end

            assert(utils.sameSize(zenith_angle, satellite_altitude), ...
                ['"', inputname(2), '" and "', inputname(3), ...
                '" Do not have matching shapes.', newline, char(9), ...
                ' Size(', inputname(2) '): ', num2str(size(zenith_angle)), ...
                newline, char(9), ' Size(', inputname(3) '): ', ...
                num2str(size(satellite_altitude))]);

            cn2_integral = AdaptiveOptics.FriedCoherenceLengthIntegral( ...
                wavenumber, zenith_angle, satellite_altitude, HV, ...
                Prefactor = options.Prefactor);

            r0 = 0.423 .* (wavenumber ^ 2) .* secd(zenith_angle) .* cn2_integral;
            r0 = r0 .^ (-3 / 5);
        end

        function sigma_squared = RytovVariancePlane( ...
                wavenumber, zenith_angle, satellite_altitude, HV, options)

            arguments
                wavenumber double
                zenith_angle {mustBeVector, mustBeNumeric}
                satellite_altitude {mustBeVector, mustBeNumeric}
                HV HufnagelValley
                options.Prefactor double = 1
            end

            cn2_integral = AdaptiveOptics.FriedCoherenceLengthIntegral( ...
                wavenumber, zenith_angle, satellite_altitude, HV, ...
                Prefactor = options.Prefactor);

            sigma_squared = ...
                2.25 ...
                .* (wavenumber .^ (7/6)) ...
                .* (secd(zenith_angle) .^ (11/6)) ...
                .* cn2_integral;
        end

        function L_r0 = EquivalentPathLengthForFried(
                wavenumber, zenith_angle, site_altitude, satellite_altitude, ...
                    HV, options)

            arguments
                wavenumber double
                zenith_angle {mustBeVector, mustBeNumeric}
                site_altitude {mustBeVector, mustBeNumeric}
                satellite_altitude {mustBeVector, mustBeNumeric}
                HV HufnagelValley
                options.Prefactor double = 1
            end

            cn2_integral = AdaptiveOptics.FriedCoherenceLengthIntegral( ...
                wavenumber, zenith_angle, satellite_altitude, HV, ...
                Prefactor = options.Prefactor);

            cn2 = HV.Calculate(site_altitude, Prefactor = options.Prefactor);

            L_r0 = (2.64 .* cn2_integral ./ cn2) .* secd(zenith_angle);
        end

        function L_rytov = EquivalentPathLengthForRytov
        end

    end

end
