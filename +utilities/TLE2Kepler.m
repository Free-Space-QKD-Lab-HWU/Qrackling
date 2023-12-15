function [name, kepler_elements] = TLE2Kepler(options)

    arguments
        options.TLE {mustBeText}
        options.Line1 {mustBeText}
        options.Line2 {mustBeText}
        options.name {mustBeText} = matlab.lang.internal.uuid()
    end

    name = options.name;
    fields = fieldnames(options);
    lines = '';
    if any(contains(fields, "TLE"))
        if any(contains(options.TLE, newline))
            lines = strsplit(options.TLE, newline);
        else
            lines = options.TLE(1:end-1);
        end
    elseif 2 == sum(contains(fields, 'Line'))
        lines = {name, options.Line1, options.Line2};
    end

    n_tle = length(lines) / 3;
    if n_tle > 1
        name = cell.empty;
    end

    tle_sets = reshape(lines, 3, n_tle);

    inc = zeros(1, n_tle);
    raan = zeros(1, n_tle);
    ecc = zeros(1, n_tle);
    aop = zeros(1, n_tle);
    sma = zeros(1, n_tle);
    ta = zeros(1, n_tle);

    n = 1;
    j = 3;
    for i = 1 : n_tle
        name{i} = tle_sets{n};
        elem2 = split(tle_sets{j});

        inc(i) = str2double(elem2{3});
        raan(i) = str2double(elem2{4});
        ecc(i) = str2double(['0.', elem2{5}]);
        aop(i) = str2double(elem2{6});
        % ma = str2double(elem2{7});
        mm = str2double(elem2{8});

        sma(i) = tle_utilities.meanmotion2semimajoraxis(mm);
        ta(i) = tle_utilities.eccentricity2trueAnomaly(ecc(i));
        n = n + 3;
        j = j + 3;
    end

    kepler_elements = [sma', ecc', inc', raan', aop', ta'];
end
