classdef AdaptiveOptics

    properties
    end

    methods(Static, Access=private)

        function result = FriedCoherenceLengthIntegral( ...
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

        function r0 = FriedCoherenceLengthSlant(...
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

        function r0 = FriedCoherenceLengthHorizontal(wavenumber, ...
                site_altitude, horizontal_path_length, HV, options);

            arguments
                wavenumber double
                site_altitude {mustBeVector, mustBeNumeric}
                horizontal_path_length {mustBeVector, mustBeNumeric}
                HV HufnagelValley
                options.Prefactor double = 1
            end

            cn2 = HV.Calculate(site_altitude, Prefactor = options.Prefactor);
            r0 = 0.1602 .* (wavenumber .^ 2) .* cn2 .* horizontal_path_length
            r0 = r0 .^ (-3/5);
        end

        function sigma_l = RytovVariancePlane( ...
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

            sigma_l = ...
                2.25 ...
                .* (wavenumber .^ (7/6)) ...
                .* (secd(zenith_angle) .^ (11/6)) ...
                .* cn2_integral;
        end

        function beta_0 = RytovVarianceSpherical( ...
                wavenumber, site_altitude, HV, horizontal_path_length)
            beta_0 = ...
                (0.5 .^ (7/6)) ...
                .* HV.Calculate(site_altitude) ...
                .* (horizontal_path_length .^ (11/6));
        end

        function L_r0 = EquivalentPathLengthForFried( ...
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

        function L_rytov = EquivalentPathLengthForRytov( ...
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


            fun = @(alt, sat_alt) ...
                HV.Calculate(alt, options.Prefactor) ...
                .* ((1 - (alt ./ sat_alt)) .^ (5/3));

            cn2_integral = zeros(size(satellite_altitude))
            for i = 1 : numel(satellite_altitude)
                cn2_integral(i) = integral( ...
                    @(x) fun(x, satellite_altitude(i)) .* (x .^ (5/6)), ...
                    0, satellite_altitude(i));
            end

            cn2 = HV.Calculate(site_altitude, Prefactor = options.Prefactor);

            L_rytov = (4.5 .* cn2_integral ./ cn2) .^ (6 / 11) .* secd(zenith_angle);
        end

        function sigma_I = ScintillationIndexPlane(sigma_l)
            sigma_I = exp( ...
                ( ...
                    (0.49 .* sigma_l) ...
                    ./ ((1 + (1.11 .* (sigma_l .^ (12/5)))) .^ (7/6)) ...
                ) ...
                + ( ...
                    (0.51 .* sigma_l) ...
                    ./ ((1 + (0.69 .* (sigma_l .^ (12/5)))) .^ (5/6)) ...
                )) - 1
        end

        function sigma_I = ScintillationIndexSpherical(beta_0)
            sigma_I = exp( ...
                ( ...
                    (0.49 .* beta_0) ...
                    ./ ((1 + (0.56 .* (beta_0 .^ (12/5)))) .^ (7/6)) ...
                ) ...
                + ( ...
                    (0.51 .* beta_0) ...
                    ./ ((1 + (0.69 .* (beta_0 .^ (12/5)))) .^ (5/6)) ...
                )) - 1
        end

        function f_g = GreenWoodFrequency(wavelength, zenith_angle, ...
                satellite_altitude, HV, BFW, options)
            arguments
                wavelength {mustBeNumeric}
                zenith_angle {mustBeNumeric}
                satellite_altitude {mustBeNumeric}
                HV HufnagelValley
                BFW BuftonWindProfile
                options.Prefactor double = 1
                options.UseSimpleAngularVelocity {mustBeLogical} = false;
                options.RelativeAngularVelocity = [];
            end

            % Set optional arguments here, will make 'fun' and 'result' easier
            % to read...
            bfw = @(x) BFW.Calculate(x, ZenithAngles = zenith_angle, ...
                UseSimpleAngularVelocity = options.UseSimpleAngularVelocity, ...
                RelativeAngularVelocity = options.RelativeAngularVelocity);

            fun = @(x) HV.Calculate(x, options.Prefactor) .* (bfw(x) .^ (5/3));
            result = integral(@(x) fun(x), 0, satellite_altitude);

            f_g = 2.31 .* (wavelength ^ (-6/5)) ...
                .* ((sec(zenith_angle) .* result) .^ (3/5));
        end

        function f_t = TrackingFrequency(transmitter_diameter, wavelength, ...
                zenith_angle, satellite_altitude, HV, BFW, options)

            arguments
                transmitter_diameter double
                wavelength {mustBeNumeric}
                zenith_angle {mustBeNumeric}
                satellite_altitude {mustBeNumeric}
                HV HufnagelValley
                BFW BuftonWindProfile
                options.Prefactor double = 1
                options.UseSimpleAngularVelocity {mustBeLogical} = false;
                options.RelativeAngularVelocity = [];
            end

            % Set optional arguments here, will make 'fun' and 'result' easier
            % to read...
            bfw = @(x) BFW.Calculate(x, ZenithAngles = zenith_angle, ...
                UseSimpleAngularVelocity = options.UseSimpleAngularVelocity, ...
                RelativeAngularVelocity = options.RelativeAngularVelocity);

            fun = @(x) HV.Calculate(x) .* (bfw(x).^2);

            result = integral(@(x) fun(x), 0, satellite_altitude);

            freq = 0.331 .* (transmitter_diameter ^ (-1/6)) ...
                .* (wavelength .^ (-1)) ...
                .* sqrt(sec(zenith_angle) .* result);
        end


    end

end
