function bfw_args = bfw_defaults(varargin)

    p = inputParser;

    ground_wind_speed = 5;
    high_altitude_wind_speed = 20;
    peak_altitude = 9.4e3;
    scale_height = 4.8e3;

    addParameter(p, 'ground_wind_speed', ground_wind_speed, @isnumeric);
    addParameter(p, 'high_altitude_wind_speed', high_altitude_wind_speed, @isnumeric);
    addParameter(p, 'peak_altitude', peak_altitude, @isnumeric);
    addParameter(p, 'scale_height', scale_height, @isnumeric);

    parse(p , varargin{:});

    bfw_args = struct(...
                'ground_wind_speed', p.Results.ground_wind_speed, ...
                'high_altitude_wind_speed', p.Results.high_altitude_wind_speed, ...
                'peak_altitude', p.Results.peak_altitude, ...
                'scale_height', p.Results.scale_height);
end
