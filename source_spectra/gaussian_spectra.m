% TODO
% select between fwhm and 1/e width to set spectral width
% spectral broadening due to atmospheric dispersion
function [wavelengths, intensities] = gaussian_spectra(central_wavelength, ...
                                                       window, ...
                                                       mean_photon_number, ...
                                                       varargin)
    p = inputParser;
    addRequired(p, 'central_wavelength');
    addRequired(p, 'window');
    addRequired(p, 'mean_photon_number');
    addParameter(p, 'FWHM', nan);
    addParameter(p, 'exponential_width', nan);
    addParameter(p, 'points', 2^10); % default to 1024 points

    parse(p, central_wavelength, window, mean_photon_number, varargin{:});

    assert(0 ~= sum(isnan([p.Results.FWHM, p.Results.exponential_width])), ...
           'Must provide either a FWHM or a 1/e width');

    if ~isnan(p.Results.FWHM)
        sigma = sigmaFromFWHM(p.Results.FWHM);
    end

    if ~isnan(p.Results.exponential_width)
        sigma = sigmaFromExponentialWidth(p.Results.exponential_width);
    end

    split = @(value) value * 0.5 .* [-1, 1];
    bounds = central_wavelength + split(window);
    wavelengths = linspace(bounds(1), bounds(2), p.Results.points);
    intensities = normaliseToMeanPhotonNumber(...
                    gaussian(wavelengths, central_wavelength, sigma), ...
                    mean_photon_number);

end

function FWHM = fwhm(sigma)
    FWHM = ( 2 * sigma * sqrt(log(2)) ) / log(2);
end

function SIGMA = sigmaFromFWHM(width)
    SIGMA = width / (2 * sqrt(2 * log(2)));
end

function SIGMA = sigmaFromExponentialWidth(width)
    % FWHM = (2 * width) * sqrt(log(2)) / sqrt(2);
    % SIGMA = FWHM / (2 * sqrt(2 * log(2)));
    SIGMA = width / 2;
end

function values = gaussian(wavelengths, central_wavelength, sigma)
    values = (1 / (sigma * sqrt(2*pi))) ...
            .* exp( ( -(wavelengths - central_wavelength).^2 ) ...
                    ./ (2 * sigma^2) );
end

function normalised = normaliseToMeanPhotonNumber(values, mean_photon_number)
    normalised = values ./ sum(values) .* mean_photon_number;
end
