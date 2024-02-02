function data = mapToEnvironment( ...
        input_headings,  input_elevations,  input_data,  ...
        output_headings, output_elevations, options)
    %% Maps data defined with input_headings and input_elevations to data with
    % output_headings and output_elevations. i.e. creates a new grid of headings
    % elevations according to the size of output_headings and output_elevations
    % and interpolates input_data accordingly
    % Expect input data to be shaped according to [input_headings, input_elevations]
    arguments
        input_headings (1, :) {mustBeNumeric}
        input_elevations (1, :) {mustBeNumeric}
        input_data (:, :, :) {mustBeNumeric}
        output_headings (1, :) {mustBeNumeric} = []
        output_elevations (1, :) {mustBeNumeric} = []
        options.Environment (1, 1) environment.Environment
        options.Wavelengths (1, :) {mustBeNumeric} = []
    end

    data_size = [numel(input_headings), numel(input_elevations)];
    if isempty(options.Wavelengths)
        msg = [ ...
        'Can not match size of ', inputname(3), '(size:[', num2str(size(input_data)), '])', ...
        'to sizes of ', inputname(1), '(size:[', num2str(size(input_headings)), ']) and ', ...
        inputname(2), '(size:[', num2str(size(input_elevations)), ']).', newline, inputname(3), ...
        ', must have size = [ ', num2str(data_size), ' ].'];
    else
        data_size = [numel(options.Wavelengths), data_size];
        disp(data_size)
        msg = [ ...
        'Can not match size of ', inputname(3), '(size:[', num2str(size(input_data)), '])', ...
        'to sizes of ', inputname(1), '(size:[', num2str(size(input_headings)), ']) and ', ...
        inputname(2), '(size:[', num2str(size(input_elevations)), ']) and', newline, ...
        'Wavelengths', '(size:[', num2str(size(options.Wavelengths)), ']) and', newline, ...
        inputname(3), ', must have size = [ ', num2str(data_size), ' ].'];
    end
    assert(all(size(input_data) == data_size), msg);

    headings = output_headings;
    elevations = output_elevations;
    %% if the user supplies an environment.Environment class then use its headings
    % elevations instead
    if contains(fieldnames(options), "Environment")
        headings = options.Environment.headings;
        elevations = options.Environment.elevations;
    end

    assert(~(isempty(headings) || isempty(elevations)), [ ...
        'Either:', newline, ...
        char(9), 'a pair of arrays for headings and elevations,', newline, ...
        char(9), 'or an environment (environment.Environment)', newline, ...
        'must be supplied']);

    %% if we got this far then everything worked!
    if ~isempty(options.Wavelengths)
        [wavelengths, headings, elevations] = meshgrid(options.Wavelengths, headings, elevations);
        p = [2, 1, 3];
        data = interpn( ...
            options.Wavelengths, input_headings, input_elevations, ...
            input_data, ...
            permute(wavelengths, p), permute(headings, p), permute(elevations, p));

        data(isnan(data)) = 0;
        return
    end

    [headings, elevations] = meshgrid(headings, elevations);
    data = interpn(input_headings, input_elevations, input_data, headings, elevations);
    data(isnan(data)) = 0;
end
