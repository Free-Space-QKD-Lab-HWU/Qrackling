function data = outputFromInputFile(lrt_input_file_path)
    arguments
        lrt_input_file_path {mustBeFile}
    end

    [keys, values] = libradtran.readInputFile(lrt_input_file_path);

    output_path_mask = contains(keys, 'output_file');
    assert(any(output_path_mask), ...
        "Input file doesn't specificy an output file");
    output_path = values{output_path_mask};


    outputs = values{contains(keys, 'output_user')};
    output_elems = strsplit(outputs, ' ');

    has_elevation = any(contains(keys, 'umu'));
    has_azimuth = any(contains(keys, 'phi'));
    has_uu = any(contains(output_elems, 'uu'));

    has_radiance = has_elevation && has_azimuth && has_uu;

    if has_radiance
        elevation_angles = acosd(values{contains(keys, 'umu')});
        azimuth_angles = values{contains(keys, 'phi')};
        n_angle_pairs = numel(elevation_angles) * numel(azimuth_angles);
        offsets = indexOfOutputValueInLine(output_elems, ...
            "n_radiance_angles", n_angle_pairs);
        radiance_shape = [numel(azimuth_angles), numel(elevation_angles)];
    else
        offsets = indexOfOutputValueInLine(output_elems);
    end

    data_labels = cellfun( ...
        @(elem) labelFromKey(elem), ...
        output_elems, ...
        "UniformOutput", false);

    data.labels = cell([1, numel(output_elems)]);

    for i = 1:numel(data_labels)
        pair = {output_elems{i}, data_labels{i}};
        data.labels{i} = pair;
        if contains(output_elems{i}, 'uu')
            data.(output_elems{i}) = double.empty([0, radiance_shape]);
        else
            data.(output_elems{i}) = [];
        end
    end

    if has_elevation
        data.elevation = elevation_angles;
    end

    if has_azimuth
        data.azimuth = azimuth_angles;
    end

    fd = fopen(output_path);
    line = fgetl(fd);
    i = 1;
    while ischar(line)
        if has_radiance
            tmp = extractDataFromLine( offsets, output_elems, line, ...
                "radiance_shape", radiance_shape );
        else
            tmp = extractDataFromLine(offsets, output_elems, line);
        end

        for elem = output_elems
            if ~contains(elem, 'uu')
                data.(elem{1})(i) = tmp.(elem{1});
            else
                data.(elem{1})(i, :, :) = tmp.(elem{1});
            end
        end
        i = i + 1;
        line = fgetl(fd);
    end
    fclose(fd);

end

function wvls = wavelengthsFromOuputFile(output_file_path)
    fd = fopen(output_file_path);
    wvls = {};
    line = fgetl(fd);
    i = 1;
    while ischar(line)
        elems = strsplit(line);
        wvls{i} = elems{2};
        i = i + 1;
        line = fgetl(fd);
    end
    fclose(fd);
end

function offsets = indexOfOutputValueInLine(keys, options)
    arguments
        keys
        options.n_radiance_angles
    end

    n_keys = numel(keys);
    offsets = linspace(1, n_keys, n_keys) + 1;

    if any(contains(fieldnames(options), "n_radiance_angles"))
        [~, idx_radiance] = max(contains(keys, 'uu'));
        offsets(idx_radiance:end) = ...
            offsets(idx_radiance:end) ...
            + options.n_radiance_angles ...
            - 1;
    end

    offsets = [offsets(1), offsets];
end

function data = extractDataFromLine(offsets, keys, line, options)
    arguments
        offsets {mustBeNumeric}
        keys
        line {mustBeTextScalar,mustBeNonempty}
        options.radiance_shape
    end

    elems = strsplit(line, ' ');

    numFromElem = @(ELEMS) str2num(strjoin(ELEMS));

    data.(keys{1}) = numFromElem(elems(offsets(2)));
    for i = 2:numel(keys)
        tmp = numFromElem(elems(offsets(i)+1 : offsets(i+1)));
        if strcmp(keys{i}, 'uu')
            data.(keys{i}) = reshape(tmp, options.radiance_shape);
        else
            data.(keys{i}) = tmp;
        end
    end
end

function label = labelFromKey(key)
    key_label_map = [ ...
        { 'lambda',     'wavelength' }, ...
        { 'wavenumber', 'wavenumber' }, ...
        { 'sza',        'solar zenith angle' }, ...
        { 'zout',       'output alititude' }, ...
        { 'edir',       'direct irradiance' }, ...
        { 'eglo',       'global irradiance' }, ...
        { 'edn',        'diffuse downward irradiance' }, ...
        { 'eup',        'diffuse upward irradiance' }, ...
        { 'enet',       'net irradiance (global - upward)' }, ...
        { 'esum',       'sum irradiance (gloabl + upward)' }, ...
        { 'uu',         'radiance' }, ...
        { 'fdir',       'direct actinic flux' }, ...
        { 'fglo',       'global actinic flux' }, ...
        { 'fdn',        'downward actinic flux' }, ...
        { 'fup',        'upward actinic flux' }, ...
        { 'f',          'total actinic flux' }, ...
        { 'uavgdir',    'direct intensity' }, ...
        { 'uavgglo',    'global intensity' }, ...
        { 'uavgdn',     'downward intensity' }, ...
        { 'uavgup',     'upward, intensity' }, ...
        { 'uavg',       'global intensity' }, ...
        { 'spher_alb',  'spherical albedo' }, ...
        { 'albedo',     'albedo' }, ...
        { 'heat',       'heating rate' }, ...
        { 'p',          'pressure' }, ...
        { 'T',          'temperature' }, ...
        { 'T_d',        'dewpoint temperature' }, ...
        { 'T_sur',      'surface temperature' }, ...
        { 'theta',      'potential temperature' }, ...
        { 'theta_e',    'equivalent potential temperature' }, ...
        { 'n_AIR',      'number density AIR' }, ...
        { 'n_O3',       'number density O3' }, ...
        { 'n_O2',       'number density O2' }, ...
        { 'n_H20',      'number density H20' }, ...
        { 'n_CO2',      'number density CO2' }, ...
        { 'n_NO2',      'number density NO2' }, ...
        { 'n_BRO',      'number density BRO' }, ...
        { 'n_OCLO',     'number density OCLO' }, ...
        { 'n_HCHO',     'number density HCHO' }, ...
        { 'n_O4',       'number density O4' }, ...
        { 'rho_AIR',    'mass density AIR' }, ...
        { 'rho_O3',     'mass density O3' }, ...
        { 'rho_O2',     'mass density O2' }, ...
        { 'rho_H20',    'mass density H20' }, ...
        { 'rho_CO2',    'mass density CO2' }, ...
        { 'rho_NO2',    'mass density NO2' }, ...
        { 'rho_BRO',    'mass density BRO' }, ...
        { 'rho_OCLO',   'mass density OCLO' }, ...
        { 'rho_HCHO',   'mass density HCHO' }, ...
        { 'rho_O4',     'mass density O4' }, ...
        { 'mmr_AIR',    'mass mixing ratio AIR' }, ...
        { 'mmr_O3',     'mass mixing ratio O3' }, ...
        { 'mmr_O2',     'mass mixing ratio O2' }, ...
        { 'mmr_H20',    'mass mixing ratio H20' }, ...
        { 'mmr_CO2',    'mass mixing ratio CO2' }, ...
        { 'mmr_NO2',    'mass mixing ratio NO2' }, ...
        { 'mmr_BRO',    'mass mixing ratio BRO' }, ...
        { 'mmr_OCLO',   'mass mixing ratio OCLO' }, ...
        { 'mmr_HCHO',   'mass mixing ratio HCHO' }, ...
        { 'mmr_O4',     'mass mixing ratio O4' }, ...
        { 'vmr_AIR',    'volume mixing ratio AIR' }, ...
        { 'vmr_O3',     'volume mixing ratio O3' }, ...
        { 'vmr_O2',     'volume mixing ratio O2' }, ...
        { 'vmr_H20',    'volume mixing ratio H20' }, ...
        { 'vmr_CO2',    'volume mixing ratio CO2' }, ...
        { 'vmr_NO2',    'volume mixing ratio NO2' }, ...
        { 'vmr_BRO',    'volume mixing ratio BRO' }, ...
        { 'vmr_OCLO',   'volume mixing ratio OCLO' }, ...
        { 'vmr_HCHO',   'volume mixing ratio HCHO' }, ...
        { 'vmr_O4',     'volume mixing ratio O4' }, ...
    ]';

    keys = key_label_map(1:2:end);
    labels = key_label_map(2:2:end);
    label = labels{contains(keys, key)};
end
