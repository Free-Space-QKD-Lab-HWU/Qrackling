function [sky, headings] = allSkyTransmission(transmission, wavelengths, elevations, headings)
    arguments
        transmission (:, :) {mustBeNumeric}
        wavelengths (1, :) {mustBeNumeric}
        elevations (1, :) {mustBeNumeric}
        headings  (1, :) {mustBeNumeric} = linspace(0, 360, 9)
    end

    assert(all(size(transmission) == [numel(wavelengths), numel(elevations)]), [ ...
        'Can not match size of ', inputname(1), '(size:[', size(transmission), '])', ...
        'to sizes of ', inputname(2), '(size:[', size(wavelengths), ']) and', ...
        inputname(3), '(size:[', size(elevations), ']).', newline, inputname(1), ...
        ', must have size = [ ', num2str([numel(wavelengths), numel(elevations)]), ' ].']);

    n_headings = numel(headings);
    size_transmission = size(transmission);
    sky_size = [size_transmission(1), n_headings, size_transmission(2)];
    sky = zeros(sky_size);

    %% replicate transmission across all headings
    for i = 1:n_headings
        sky(:, i, :) = transmission;
    end
end
