classdef Geometry < handle
    properties (SetAccess = protected)
        lrt_config libRadtran
        solar_zenith_angle Parameters.sza
        solar_zenith_angle_file Parameters.sza_file
        solar_azimuth_angle Parameters.phi
        solar_azimuth_output_angle Parameters.phi0
        output_polar_angle_cosines Parameters.umu
        radius Parameters.earth_radius
        sensor_latitude Parameters.latitude
        sensor_longitude Parameters.longitude
        day Parameters.day_of_year
        simulated_time Parameters.time
        output_altitudes Parameters.zout
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
                g Groups.Geometry
                value {mustBeNumeric}
            end
            g.solar_zenith_angle = Parameters.sza(value);
        end

        function g = SolarZenithAngleFile(g, file)
            arguments
                g Groups.Geometry
                file {mustBeFile}
            end
            g.solar_zenith_angle_file = Parameters.sza_file(file);
        end

        function g = SolarAzimuthAngle(g, value)
            arguments
                g Groups.Geometry
                value {mustBeNumeric}
            end
            g.solar_azimuth_angle = Parameters.phi(value);
        end

        function g = SolarAzimuthOutputAngle(g, value)
            arguments
                g Groups.Geometry
                value {mustBeNumeric}
            end
            g.solar_azimuth_output_angle = Parameters.phi0(value);
        end

        function g = OutputPolarAngles(g, angles, unit)
            arguments
                g Groups.Geometry
                angles {mustBeNumeric}
                unit Angle
            end
            % FIX: Conversion causes errors when running configuration
            cosines = cosd(unit.ToDegrees(angles));
            g.output_polar_angle_cosines = Parameters.umu(cosines);
        end

        function g = EarthRadius(g, val)
            arguments
                g Groups.Geometry
                val {mustBeNumeric}
            end
            g.radius = Parameters.earth_radius(val);
        end

        function g = SensorLatitude(g, hemisphere, deg, options)
            arguments
                g Groups.Geometry
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
            g.sensor_latitude = Parameters.latitude(args{:});
        end

        function g = SensorLongitude(g, hemisphere, deg, options)
            arguments
                g Groups.Geometry
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
            g.sensor_longitude = Parameters.longitude(args{:});
        end

        function g = Time(g, t)
            arguments (Input)
                g Groups.Geometry
                t {mustBeA(t, 'datetime')}
            end
            g.simulated_time = Parameters.time(t);
        end

        function g = DayOfYear(g, date)
            %arguments
            %    g Groups.Geometry
            %    date %{mustBeA(date, 'dateParameters.time')}
            %end
            g.day = Parameters.day_of_year(date);
        end

        function g = OutputAltitudes(g, altitude)
            arguments (Input)
                g Groups.Geometry
                altitude {mustBeNumeric}
            end
            g.output_altitudes = Parameters.zout(altitude);
        end
    end
end
