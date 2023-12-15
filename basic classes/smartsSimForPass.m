% Run a SMARTS simulation over the entirety of a satellite pass
%
% Typical Usage:
% (taken from PassSimulation/Simulate
%
% ```
% [smarts_results, Wavelengths, Sky_Irradiance, Sky_Radiance, ...
%       Sky_Photons, sky_photon_rate] = smartsSimForPass(...
%                               PassSimulation.smarts_configuration, ...
%                               PassSimulation.Headings, ...
%                               PassSimulation.Elevations, ...
%                               PassSimulation.Satellite.Times, ...
%                               PassSimulation.Elevation_Limit_Flags, ...
%                               PassSimulation.Ground_Station);
% ```
function [smarts_results, Wavelengths, Sky_Irradiance, Sky_Radiance, ...
          Sky_Photons, sky_photon_rate] = smartsSimForPass(SMARTS_Conf, ...
                                                Azimuth, Elevation, Time, ...
                                                Flags, Ground_Station)

    smarts_results = generate_smarts_data(SMARTS_Conf, Azimuth, Elevation, ...
                                          Time, Flags);

    cumulative_sum = cumsum(Flags);
    idx_first_file = sum(cumulative_sum == 0) + 1;
    idx_last_file = idx_first_file + sum(Flags == 1) - 1;
     assert(idx_first_file<=idx_last_file,'no true flags entered. no simulation can take place');

    %prevent a warning about renaming table variables
    warning('off','MATLAB:table:ModifiedAndSavedVarnames');
    data = readtable(smarts_results{sum(cumsum(Flags) == 0) + 1});
    if ~isempty(data)
    Wavelengths = data.Wvlgth;
    else %if no simulated atmospherics, get wavelengths from config
        Wavelengths=SMARTS_Conf.iscan.wavelength_min:...
            SMARTS_Conf.iscan.step:...
            SMARTS_Conf.iscan.wavelength_max;
    end
    Sky_Irradiance = zeros(numel(Flags), numel(Wavelengths));
    Sky_Radiance = zeros(size(Sky_Irradiance));
    Sky_Photons = zeros(size(Sky_Radiance));

    for i = idx_first_file : idx_last_file
        data = readtable(smarts_results{i});
        if isempty(data)
            continue;
        end

        Sky_Irradiance(i, :) = data.Global_tilted_irradiance;

        Sky_Radiance(i, :) = irradiance2radiance(Sky_Irradiance(i, :), ...
                                                 Wavelengths', 1e-9);

        Sky_Photons(i, :) = sky_photons(Sky_Radiance(i, :), ...
                                        Ground_Station.Telescope.FOV^2, ...
                                        Ground_Station.Telescope.Diameter, ...
                                        Wavelengths', 1, 1);
    end



    %for now, without wavelength parallelisation, sum all counts inside the
    %filter bounds
    %sky photons has units of photons/nm.s
    Filter_Transmission = ComputeTransmission(Ground_Station.Detector.Spectral_Filter,Wavelengths);
    sky_photon_rate = Sky_Photons*Filter_Transmission;


    %turn back on warning about renaming table variables
    warning('on','MATLAB:table:ModifiedAndSavedVarnames');
end

