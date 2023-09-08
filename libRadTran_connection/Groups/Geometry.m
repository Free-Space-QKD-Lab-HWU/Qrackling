classdef Geometry < handle
    properties (SetAccess = protected)
        lrt_config libRadtran
        solar_zenith_angle sza
        solar_zenith_angle_file sza_file
        solar_azimuth_angle phi
        solar_azimuth_output_angle phi0
        output_polar_angle_cosines umu
        radius earth_radius
        sensor_latitude latitude
        sensor_longitude longitude
        day day_of_year
        simulated_time time
        output_altitudes zout
    end

    methods
        function g = Geometry(options)
            arguments
                options.lrtConfiguration libRadtran
            end
            if numel(fieldnames(options)) > 0
                g.lrt_config = options.lrtConfiguration;
            end
        end

        function g = SolarZenithAngle(g, value)
            arguments
                g Geometry
                value {mustBeNumeric}
            end
            g.solar_zenith_angle = sza(value);
        end

        function g = SolarZenithAngleFile(g, file)
            arguments
                g Geometry
                file {mustBeFile}
            end
            g.solar_zenith_angle_file = sza_file(file);
        end

        function g = SolarAzimuthAngle(g, value)
            arguments
                g Geometry
                value {mustBeNumeric}
            end
            g.solar_azimuth_angle = phi(value);
        end

        function g = SolarAzimuthOutputAngle(g, value)
            arguments
                g Geometry
                value {mustBeNumeric}
            end
            g.solar_azimuth_output_angle = phi0(value);
        end

        function g = OutputPolarAngles(g, angles, unit)
            arguments
                g Geometry
                angles {mustBeNumeric}
                unit Angle
            end
            % TODO: Conversion causes errors when running configuration
            cosines = cosd(unit.ToDegrees(angles));
            g.output_polar_angle_cosines = umu(cosines);
        end

        function g = EarthRadius(g, val)
            arguments
                g Geometry
                val {mustBeNumeric}
            end
            g.radius = earth_radius(val);
        end

        function g = SensorLatitude(g, hemisphere, deg, options)
            arguments
                g Geometry
                hemisphere {mustBeMember(hemisphere, {'N', 'S'})}
                deg {mustBeNumeric}
                options.min {mustBeNumeric}
                options.sec {mustBeNumeric}
            end
            args = {hemisphere, deg};
            if numel(fieldnames(options)) > 0
                for f = fieldnames(options)
                    disp(f)
                    args = [args, f, options.(f{1})];
                end
            end
            g.sensor_latitude = latitude(args{:});
        end

        function g = SensorLongitude(g, hemisphere, deg, options)
            arguments
                g Geometry
                hemisphere {mustBeMember(hemisphere, {'E', 'W'})}
                deg {mustBeNumeric}
                options.min {mustBeNumeric}
                options.sec {mustBeNumeric}
            end
            args = {hemisphere, deg};
            if numel(fieldnames(options)) > 0
                for f = fieldnames(options)
                    disp(f)
                    args = [args, f, options.(f{1})];
                end
            end
            g.sensor_longitude = longitude(args{:});
        end

        function g = Time(g, t)
            arguments (Input)
                g Geometry
                t {mustBeA(t, 'datetime')}
            end
            g.simulated_time = time(t);
        end

        function g = DayOfYear(g, date)
            %arguments
            %    g Geometry
            %    date %{mustBeA(date, 'datetime')}
            %end
            g.day = day_of_year(date);
        end

        function g = OutputAltitudes(g, altitude)
            arguments (Input)
                g Geometry
                altitude {mustBeNumeric}
            end
            g.output_altitudes = zout(altitude);
        end
    end
end
