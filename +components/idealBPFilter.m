function sf = idealBPFilter( ...
    centre_wavelength, spectral_width, steepness, max_wavelength, options)
% idealBPFilter
%
% Return a SpectralFilter object with ideal band-pass performance for the
% specified parameters.
%
% Syntax:
%   sf = idealBPFilter(centre_wavelength, spectral_width)
%   sf = idealBPFilter(centre_wavelength, spectral_width, steepness)
%   sf = idealBPFilter(centre_wavelength, spectral_width, ...
%                       steepness, max_wavelength, options)
%
% Inputs:
%   centre_wavelength - (1,1) double, centre wavelength (units set by options)
%   spectral_width    - (1,1) double, filter bandwidth (same units as above)
%   steepness         - (1,1) double, edge steepness (transmission/nm)
%                        Default: 1e3
%   max_wavelength    - (1,1) double, maximum wavelength supported by filter
%                        Default: 1e4 (10 um)
%   options           - struct with field:
%       Wavelength_Scale - units.Magnitude, default 'nano'
%
% Outputs:
%   sf - components.SpectralFilter object

    arguments
        centre_wavelength {mustBePositive, mustBeScalarOrEmpty}
        spectral_width    {mustBePositive, mustBeScalarOrEmpty}
        steepness         {mustBePositive, mustBeScalarOrEmpty} = 1e3
        % Steepness in transmission/nm (edge slope)
        max_wavelength    {mustBePositive, mustBeScalarOrEmpty} = 1e4
        % Maximum wavelength mapped by spectral filter
        options.Wavelength_Scale units.Magnitude = 'nano'
    end

    % Create width for the transition region
    change_width = 1 / steepness;

    % Correct case where spectral_width <= change_width
    if spectral_width <= change_width
        change_width = spectral_width / 10;
        warning(['Increased default steepness of spectral filter edges ', ...
                 'to cope with narrow filter bandwidth.'])
    end

    half_width  = spectral_width / 2;
    half_change = change_width / 2;

    wavelengths = [ ...
        0, ...
        centre_wavelength - half_width - half_change, ...
        centre_wavelength - half_width + half_change, ...
        centre_wavelength + half_width - half_change, ...
        centre_wavelength + half_width + half_change, ...
        max_wavelength ...
    ];

    % Corresponding transmission values
    transmission = [0, 0, 1, 1, 0, 0];

    % Create spectral filter object
    sf = components.SpectralFilter( ...
        'wavelengths', wavelengths, ...
        'transmission', transmission, ...
        'Wavelength_Scale', options.Wavelength_Scale);
end