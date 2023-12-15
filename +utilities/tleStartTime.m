function start_time = tleStartTime(tle_set)
    % Extract the start time from a two-line element set
    %
    % EXAMPLE:
    % tle_lines = readlines("threeSatelliteConstellation.tle");
    % first_satellite_str = sprintf('%s', join(tleraw(1:3), newline));
    % startTime = utilities.tleStartTime(first_satellite_str);
    % stopTime = startTime + hours(5);
    %
    assert(ischar(tle_set), ...
           'TLE set must be a string or character vector');

    if strcmpi('.tle', tle_set(numel(tle_set)-3: end))
    end

    lines = strsplit(tle_set, '\n');
    assert(3 == numel(lines), 'TLE set malformed, must be 3 lines');
    assert(69 == numel(lines{2}), ...
        'TLE set malformed, line 1 must be 69 characters long');
    assert(69 == numel(lines{3}), ...
        'TLE set malformed, line 2 must be 69 characters long');

    year = str2num(lines{2}(19:20));
    % this is shakey but since we only get the last two digits of the
    % year from the tle set assume that if its greater than 30 (writing
    % this is 2022) that the TLE data is probably from 19XX.
    warning(['### POTENTIALLY INCORRECT YEAR ###', newline, ...
        'Only the last two digits of the year are provided in ', ...
        'the TLE format. Adjust the year as needed']);
    if 50 < year
        year = 1900 + year;
    else
        year = 2000 + year;
    end

    month_year_ratio = 365 / 12;

    days = str2num(lines{2}(21:32));

    month = floor(days / month_year_ratio);
    day = floor(days - floor(month_year_ratio * month));

    HOUR = (days - (floor(month_year_ratio * month) + day)) * 24;
    hour = floor(HOUR);

    MINUTES = (HOUR - hour) * 60;
    minutes = floor(MINUTES);

    seconds = (MINUTES - minutes) * 60;

    start_time = datetime(year, month, day, hour, minutes, seconds);
end
