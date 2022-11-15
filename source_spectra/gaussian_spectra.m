function [wavelengths, intensities] = gaussian_spectra(central_wavelength, ...
                                                       window, ...
                                                       width, ...
                                                       mean_photon_number, ...
                                                       points)
    split = @(value) value * 0.5 .* [-1, 1];
    bounds = central_wavelength + split(window);
    wavelengths = linspace(bounds(1), bounds(2), points);
    intensities = normaliseToMeanPhotonNumber(...
                    gaussian( wavelengths, central_wavelength, fwhm(sigma(width)) / (2*sqrt(2*log(2))) ), ...
                    mean_photon_number);
    intensities = normaliseToMeanPhotonNumber(...
                    gaussian( wavelengths, central_wavelength, sigma(width) ), ...
                    mean_photon_number);

end

function FWHM = fwhm(sigma)
    FWHM = ( 2 * sigma * sqrt(log(2)) ) / log(2);
end

function SIGMA = sigma(width)
    % SIGMA = ((2 * width) * sqrt(log(2))) ...
    %         / sqrt(2) ...
    %         / ( 2 * sqrt(2 * log(2)));
    SIGMA = width / (2 * sqrt(2 * log(2)));
end

function values = gaussian(wavelengths, central_wavelength, sigma)
    values = (1 / (sigma * sqrt(2*pi))) ...
            .* exp( ( -(wavelengths - central_wavelength).^2 ) ...
                    ./ (2 * sigma^2) );
end

function normalised = normaliseToMeanPhotonNumber(values, mean_photon_number)
    %normalised = values .* (mean_photon_number / sum(values > 0));

    % normalised = values ./ min(values);
    % normalised = normalised ./ (sum(normalised) / numel(values));

    normalised = values ./ sum(values) .* mean_photon_number;

end
