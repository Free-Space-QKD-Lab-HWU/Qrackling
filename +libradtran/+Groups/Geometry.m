classdef Geometry < handle
    properties (SetAccess = protected)
        lrt_config libradtran.libRadtran
        solar_zenith_angle libradtran.Parameters.sza
        solar_zenith_angle_file libradtran.Parameters.sza_file
        solar_azimuth_angle libradtran.Parameters.phi
        solar_azimuth_output_angle libradtran.Parameters.phi0
        output_polar_angle_cosines libradtran.Parameters.umu
        radius libradtran.Parameters.earth_radius
        sensor_latitude libradtran.Parameters.latitude
        sensor_longitude libradtran.Parameters.longitude
        day libradtran.Parameters.day_of_year
        simulated_time libradtran.Parameters.time
        output_altitudes libradtran.Parameters.zout
    end

    methods
        function g = Geometry(options)
            arguments
                options.lrtConfiguration libradtran.libRadtran
            end
            if numel(fieldnames(options)) > 0
                g.lrt_config = options.lrtConfiguration;
            end
        end

        function g = SolarZenithAngle(g, value)
            arguments
                g libradtran.Groups.Geometry
                value {mustBeNumeric}
            end
            g.solar_zenith_angle = libradtran.Parameters.sza(value);
        end

        function g = SolarZenithAngleFile(g, file)
            arguments
                g libradtran.Groups.Geometry
                file {mustBeFile}
            end
            g.solar_zenith_angle_file = libradtran.Parameters.sza_file(file);
        end

        function g = SolarAzimuthAngle(g, value)
            arguments
                g libradtran.Groups.Geometry
                value {mustBeNumeric}
            end
            g.solar_azimuth_angle = libradtran.Parameters.phi(value);
        end

        function g = SolarAzimuthOutputAngle(g, value)
            arguments
                g libradtran.Groups.Geometry
                value {mustBeNumeric}
            end
            g.solar_azimuth_output_angle = libradtran.Parameters.phi0(value);
        end

        function g = OutputPolarAngles(g, angles, unit)
            arguments
                g libradtran.Groups.Geometry
                angles {mustBeNumeric}
                unit units.Angle
            end
            cosines = sort(-cosd(units.Angle.ToDegrees(unit, angles)),'ascend');
            g.output_polar_angle_cosines = libradtran.Parameters.umu(cosines);
        end

        function g = EarthRadius(g, val)
            arguments
                g libradtran.Groups.Geometry
                val {mustBeNumeric}
            end
            g.radius = libradtran.Parameters.earth_radius(val);
        end

        function g = SensorLatitude(g, hemisphere, deg, options)
            arguments
                g libradtran.Groups.Geometry
                hemisphere {mustBeMember(hemisphere, {'N', 'S'})}
                deg {mustBeNumeric}
                options.min {mustBeNumeric}
                options.sec {mustBeNumeric}
            end
            args = {hemisphere, deg};
            if numel(fieldnames(options)) > 0
                for f = fieldnames(options)
                    args = [args, f, options.(f{1})];
                end
            end
            g.sensor_latitude = libradtran.Parameters.latitude(args{:});
        end

        function g = SensorLongitude(g, hemisphere, deg, options)
            arguments
                g libradtran.Groups.Geometry
                hemisphere {mustBeMember(hemisphere, {'E', 'W'})}
                deg {mustBeNumeric}
                options.min {mustBeNumeric}
                options.sec {mustBeNumeric}
            end
            args = {hemisphere, deg};
            if numel(fieldnames(options)) > 0
                for f = fieldnames(options)
                    args = [args, f, options.(f{1})];
                end
            end
            g.sensor_longitude = libradtran.Parameters.longitude(args{:});
        end

        function g = Time(g, t)
            arguments (Input)
                g libradtran.Groups.Geometry
                t {mustBeA(t, 'datetime')}
            end
            g.simulated_time = libradtran.Parameters.time(t);
        end

        function g = DayOfYear(g, date)
            %arguments
            %    g libradtran.Groups.Geometry
            %    date %{mustBeA(date, 'datelibradtran.Parameters.time')}
            %end
            g.day = libradtran.Parameters.day_of_year(date);
        end

        function g = OutputAltitudes(g, altitude)
            arguments (Input)
                g libradtran.Groups.Geometry
                altitude {mustBeNumeric}
            end
            g.output_altitudes = libradtran.Parameters.zout(altitude);
        end
    end
end
