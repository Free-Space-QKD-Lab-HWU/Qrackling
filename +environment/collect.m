function env = collect(type, data_wavelengths, data_headings, data_elevations, data, unit, options)
    arguments (Repeating)
        type {mustBeMember(type, {"transmission", "background_emission"})}
        data_wavelengths (1, :) {mustBeNumeric}
        data_headings (1, :) {mustBeNumeric}
        data_elevations (1, :) {mustBeNumeric}
        data (:, :) {mustBeNumeric}
        unit {mustBeMember(unit, {"probability", "dB", "Hz/m^2/sr", "W/m^2/sr/nm"})}
    end
    arguments
        options.Headings (1, :) ...
            {mustBeNumeric, mustBeInRange(options.Headings, 0, 360)} = linspace(0, 360, 91)
        options.Elevations (1, :) ...
            {mustBeNumeric, mustBeInRange(options.Elevations, 0, 90)} = linspace(0, 90, 46)
    end

    % first we need to determine the dimensions of our transmission and elevation
    % data. This is either set by the environment or by the repeating args.

    default_headings = options.Headings;
    default_elevations = options.Elevations;

    mapped_data = {};

    for i = 1:numel(type)
        mapped = environment.mapToEnvironment( ...
            data_headings,    data_elevations,    data, ...
            default_headings, default_elevations, ...
            Wavelength=data_wavelengths);
        mapped_data{i} = mapped;

        switch type{i}
        case "transmission"
            switch unit{i}
            case "probability"
                continue
            case "dB"
                % TODO: convert
            end
        case "background_emission"
            switch unit{i}
            case "Hz/M^2/sr" % "counts"
            case "W/m^2/sr/nm" % "power"
                continue
            end
        end
    end
end
