classdef BuftonWindProfile
    enumeration
        Pugh_2020 ( 5, 20, 9400, 4800 )
        Gruneisen_2021 ( 5, 30, 9400, 4800 )
    end

    properties
        ground_wind_speed
        high_altitude_wind_speed

        % Altitude of the tropopause
        peak_altitude

        % Thickness of tropopause
        scale_height
    end

    methods

        function BFW = BuftonWindProfile(ground_wind_speed, ...
                high_altitude_wind_speed, peak_altitude, scale_height)
            BFW.ground_wind_speed = ground_wind_speed;
            BFW.high_altitude_wind_speed = high_altitude_wind_speed;
            BFW.peak_altitude = peak_altitude;
            BFW.scale_height = scale_height;
        end

        function velocity = Calculate(BFW, altitude, options)
            arguments
                BFW BuftonWindProfile
                altitude {mustBeNumeric}
                options.UseSimpleAngularVelocity = false;
                options.RelativeAngularVelocity = [];
                options.ZenithAngles = [];
            end

            velocity = BuftonWindProfile.BfwCalculation(altitude, ...
                BFW.ground_wind_speed, BFW.high_altitude_wind_speed, ...
                BFW.peak_altitude, BFW.scale_height);

            if ~isempty(options.RelativeAngularVelocity)
                angular_component = options.RelativeAngularVelocity .* altitude;
                velocity = anglular_velocity + velocity;
                return;
            end

            if options.UseSimpleAngularVelocity
                angular_component = BuftonWindProfile ...
                    .SimpleCircularDirectOverPassAngularVelocity( ...
                        altitude, options.ZenithAngles);
                velocity = angular_component + velocity;
                return
            end

        end

    end

    methods (Static)

        function velocity = BfwCalculation(altitude, ground_wind_speed, ...
                high_altitude_wind_speed, peak_altitude, scale_height)

            velocity = ground_wind_speed ...
                + high_altitude_wind_speed ...
                .* exp(-((altitude - peak_altitude) ./ scale_height) .^ 2);
        end

        function angular_velocity = ...
                SimpleCircularDirectOverPassAngularVelocity( ...
                    satellite_altitude, zenith_angle)
            G = 6.673e-20;
            M = 5.97e24;
            Earth_radius = 6371;

            dist = (satellite_altitude .^ 2) ...
                .* (Earth_radius + satellite_altitude);

            angular_velocity = sqrt((G * M) ./ dist) .* (cosd(zenith_angle) .^ 2);
        end

    end

end
