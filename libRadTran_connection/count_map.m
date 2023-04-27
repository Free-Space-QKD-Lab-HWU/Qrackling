classdef count_map
    properties
        radiance_map radiance_file;
        counts = [];
    end
    methods
        function count_map = count_map(radiance_map)
            count_map = count_map.add_radiance_map(radiance_map);
        end

        function count_map = add_radiance_map(count_map, radiance_map)
            count_map.radiance_map = radiance_map;
        end

        function count_map = nSkyPhotons(count_map, wavelength, ...
                solidAngleFOV, diameter, filter_width, count_window)

            planck = 6.626e-34;
            c = 299792458;

            %f = 8410e-3;
            %Dr = 0.7;

            % field stop diameter at the diffraction limit for a given wavelength
            % fieldStopDiameter = @(FocalLength, RxDiameter, Wavelength) ...
            %     2.44 .* FocalLength .* Wavelength ./ RxDiameter;

            %fieldStopDiameter = ...
            %    2.44 .* focal_length .* wavelength ./ diameter;

            %solidAngleFOV = @(FocalLength, FSDiameter) pi ./ 4 .* ((FSDiameter ./ FocalLength).^2);

            %solidAngleFOV = pi ./ 4 .* ((fieldStopDiameter ./ focal_length) .^ 2);

            %disp(fieldStopDiameter)
            %disp(solidAngleFOV)

            % since we have the radiance for a given wavelength already I'm not 100% sure 
            % that we need to include the wavelength in this function i.e. radiance = mW/sr/m^2
            % output settings in libRadTran config also doesn't specify per nm so I don't think
            % needed, also now not so sure about the spectral filter either....
            NSkyPhotons = @(Radiance, FOV, RxDiameter, Wavelength, Band, ExpTime) ...
                (Radiance .* FOV .* pi .* (RxDiameter.^2) .* Wavelength .* Band .* ExpTime) ...
                ./ (planck * c);

            %NSkyPhotons = @(Radiance) ...
            %    (Radiance ...
            %    .* solidAngleFOV ...
            %    .* pi ...
            %    .* (primary_optic_diameter.^2) ...
            %    .* (wavelength .* (1e-9)) ...
            %    .* filter_width ...
            %    .* count_window) ...
            %    ./ (planck * c);

            radiances = count_map.radiance_map.pickRadianceForWavelength(wavelength);
            count_map.counts = NSkyPhotons( ...
                radiances .* (1e-3) ./ (wavelength), ...
                solidAngleFOV, ...
                diameter, ...
                wavelength, ...
                filter_width, ...
                count_window);

        end

        function counts = countsForPass(count_map, ...
                simulated_elevations, simulated_azimuths, elevation_limit)

            c_mat = fliplr(count_map.counts);
            counts = zeros(size(simulated_elevations));
            for i = 1:numel(simulated_azimuths)
                az = simulated_azimuths(i);
                el = simulated_elevations(i);
                % if we are below the elevation limit then skip to next pair of
                % elevation and azimuth
                %if elevation_limit > el
                %    continue
                %end
                [val, azim_idx] = min(abs(count_map.radiance_map.azimuths - az));
                [val, elev_idx] = min(abs(rad2deg(count_map.radiance_map.elevations) - el));
                counts(i) = c_mat(azim_idx, elev_idx);
            end
        end

    end
end

