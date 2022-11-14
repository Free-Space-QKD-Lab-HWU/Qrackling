classdef solar_position_and_airmass < card

    properties

        Day = nan;
        Month = nan;
        Year = nan;
        Hour = nan;
        Zone = nan;

        zenith = nan;
        azimuth = nan;
        elevation = nan;
        amass = nan;
        latitude = nan;
        longitude = nan;
        dstep = nan;

    end

    methods

        function solar_position_and_airmass = solar_position_and_airmass(varargin)

            total = @(args) sum(~isnan(args));
            have = @(args) all(~isnan(args));

            solar_position_and_airmass.card_type = 'IMASS';
            solar_position_and_airmass.card_num = 17;
            solar_position_and_airmass.groups = {{'zenith', 'azimuth'}, ...
                {'elevation', 'azimuth'}, {'amass'}, ...
                {'Year', 'Month', 'Day', 'Hour', 'latitude', 'longitude', 'Zone'}, ...
                {'Month', 'latitude', 'dstep'}};
            solar_position_and_airmass.suffix = {'a', 'a', 'a', 'a', 'a'};

            p = inputParser;
            addParameter(p, 'zenith', nan);
            addParameter(p, 'azimuth', nan);
            addParameter(p, 'elevation', nan);
            addParameter(p, 'amass', nan);
            addParameter(p, 'dateAndTime', nan);
            addParameter(p, 'latitude', nan);
            addParameter(p, 'longitude', nan);
            addParameter(p, 'dstep', nan);
            
            parse(p, varargin{:});

            if isa(p.Results.dateAndTime, 'datetime')
                solar_position_and_airmass.Day = p.Results.dateAndTime.Day;
                solar_position_and_airmass.Month = p.Results.dateAndTime.Month;
                solar_position_and_airmass.Year = p.Results.dateAndTime.Year;
                solar_position_and_airmass.Hour = p.Results.dateAndTime.Hour;
                solar_position_and_airmass.Zone = p.Results.dateAndTime.TimeZone;
                if isempty(solar_position_and_airmass.Zone)
                    % if there is no time zone set assume timezone = 0, GMT:0
                    solar_position_and_airmass.Zone = 0;
                end
            end

            if ~any([1, 2, 3, 7] == total([p.Results.zenith, p.Results.azimuth, ...
                    p.Results.elevation, p.Results.amass, ...
                    solar_position_and_airmass.Day, ...
                    solar_position_and_airmass.Month, ...
                    solar_position_and_airmass.Year, ...
                    solar_position_and_airmass.Hour, ...
                    solar_position_and_airmass.Zone, ...
                    p.Results.latitude, p.Results.longitude, p.Results.dstep]))

                err_opts = {...
                    '(zenith, azimuth)', ...
                    '(elevation, azimuth)', ...
                    '([DateTime, latitude, longitude, Zone)', ...
                    '(Month, latitude, dstep)' ...
                    };
                err_str = ['Incorrect combination of inputs supplied'];

                for i = 1 : length(err_opts)
                    err_str = [err_str, newline, char(9), err_opts{i}];
                end
                    
                opt_str = 'and optionally amass if relative air mass is to be used';
                err_str = [newline, err_str, newline, opt_str, newline];

                error(err_str);

            elseif have([p.Results.zenith, p.Results.azimuth])
                solar_position_and_airmass.flag = 0;

            elseif have([p.Results.elevation, p.Results.azimuth])
                solar_position_and_airmass.flag = 1;

            elseif have(p.Results.amass)
                solar_position_and_airmass.flag = 2;

            elseif have([solar_position_and_airmass.Year, ...
                    solar_position_and_airmass.Month, ...
                    solar_position_and_airmass.Day, ...
                    solar_position_and_airmass.Hour, ...
                    p.Results.latitude, p.Results.longitude, ...
                    solar_position_and_airmass.Zone])
                solar_position_and_airmass.flag = 3;

            elseif have([solar_position_and_airmass.Month, ...
                         p.Results.latitude, p.Results.dstep])
                solar_position_and_airmass.flag = 4;

            end

            solar_position_and_airmass.zenith = p.Results.zenith;
            solar_position_and_airmass.azimuth = p.Results.azimuth;
            solar_position_and_airmass.elevation = p.Results.elevation;
            solar_position_and_airmass.amass = p.Results.amass;
            solar_position_and_airmass.latitude = p.Results.latitude;
            solar_position_and_airmass.longitude = p.Results.longitude;
            solar_position_and_airmass.dstep = p.Results.dstep;


        end

    end

end
