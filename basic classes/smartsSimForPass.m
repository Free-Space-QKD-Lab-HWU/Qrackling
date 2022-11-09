% TODO: add time into simulation
% Runner function meant to be used by PassSimulation, this can probably be
% moved into one of the other classes.
function [smarts_results, Wavelengths, Sky_Irradiance, Sky_Radiance, ...
          Sky_Photons, sky_photon_rate] = ...
    smartsSimForPass(SMARTS_Conf, Azimuth, Elevation, Flags)

    smarts_results = generate_smarts_data(SMARTS_Conf, Azimuth, Elevation, ...
                                          Flags);
    
    cumulative_sum = cumsum(Flags);
    idx_first_file = sum(cumulative_sum == 0) + 1;
    idx_last_file = idx_first_file + sum(Flags == 1) - 1;
    
    data = readtable(smarts_results{sum(cumsum(Flags) == 0) + 1});
    Wavelengths = data.Wvlgth;
    Sky_Irradiance = zeros(numel(Flags), numel(Wavelengths));
    Sky_Radiance = zeros(size(Sky_Irradiance));
    Sky_Photons = zeros(size(Sky_Radiance));
    
    for i = idx_first_file : idx_last_file
        if isempty(smarts_results{i})
            continue;
        end
        data = readtable(smarts_results{i});
        Sky_Irradiance(i, :) = data.Global_tilted_irradiance;
    
        Sky_Radiance(i, :) = irradiance2radiance(Sky_Irradiance(i, :), ...
                                                 Wavelengths', 1e-9);
    
        Sky_Photons(i, :) = sky_photons(Sky_Radiance(i, :), ...
                                        Ground_Station.Telescope.FOV^2, ...
                                        Ground_Station.Telescope.Diameter, ...
                                        Wavelengths', 1e-9, 1);
    end
    
    solar_scatter_wavlength_bounds = Ground_Station.Detector.Wavelength + (...
                    Ground_Station.Detector.Spectral_Filter_Width ...
                    .* ([-1, 1] ./ 2) );
    
    solar_scatter_wavlength_idx = ...
        ( Wavelengths > solar_scatter_wavlength_bounds(1) ) ...
        & ( Wavelengths < solar_scatter_wavlength_bounds(2) );
    
    sky_photon_rate = Sky_Photons(:, solar_scatter_wavlength_idx);
    Background_Count_Rates = Background_Count_Rates + sky_photon_rate;
end

