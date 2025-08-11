function [sky, headings] = allSkyTransmission(transmission, wavelengths, ...
        elevations, headings)
% allSkyTransmission
%
% repeat a transmission-as-function-of-elevation pair across many different
% headings to form a higher dimensional sky.
%
% Syntax:
% [sky, headings] = allSkyTransmission(transmission, wavelengths, ...
%     elevations, headings)
%
% Inputs:
% transmission - (W x E) numeric, transmission vs wavelength and elevation
% wavelengths  - (1 x W) numeric
% elevations   - (1 x E) numeric
% headings     - (1 x H) numeric, degrees (default linspace(0,360,9))
%
% Outputs:
% sky       - (W x H x E) numeric, replicated across headings
% headings  - (1 x H) numeric, returned for convenience

    arguments
        transmission (:, :) {mustBeNumeric}
        wavelengths (1, :) {mustBeNumeric}
        elevations (1, :) {mustBeNumeric}
        headings (1, :) {mustBeNumeric} = linspace(0, 360, 9)
    end

    % Validate sizes: transmission must be W x E
    assert(all(size(transmission) == [numel(wavelengths), numel(elevations)]), ...
        ['Cannot match size of ', inputname(1), ...
         ' to sizes of ', inputname(2), ' and ', inputname(3), '. ', ...
         inputname(1), ' must have size = [ ', ...
         num2str([numel(wavelengths), numel(elevations)]), ' ].']);

    % Precompute sizes
    n_headings = numel(headings);
    size_transmission = size(transmission);
    sky_size = [size_transmission(1), n_headings, size_transmission(2)];

    % Allocate output cube
    sky = zeros(sky_size);

    %% Replicate transmission across all headings
    for i = 1:n_headings
        sky(:, i, :) = transmission;
    end
end