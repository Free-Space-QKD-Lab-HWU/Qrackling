classdef Atmosphere

    properties
        data;

        wavelengths;
        sky_dome;
        fields;

        Aziumth;
        Elevation;

        current_conditions;

    end

    methods

        function Atmosphere = Atmosphere(file_path)
            Atmosphere = Atmosphere.LoadAtmosphere(file_path);
        end

        function Atmosphere = LoadAtmosphere(Atmosphere, file_path)
            assert(2 == exist(file_path), 'File does not exist');

            data = load(file_path);

            fields = fieldnames(data);
            assert(convertCharsToStrings(fields{1}) == "atmosphere", ...
                   'Not an atmosphere');

            atmosphere = load(file_path).atmosphere;
            Atmosphere.data = atmosphere.values;

            Atmosphere.wavelengths = atmosphere.wavelengths;
            Atmosphere.sky_dome = atmosphere.values;

            [N_a, N_e] = size(atmosphere.values);
            Atmosphere.Aziumth = zeros(size(atmosphere.values));
            Atmosphere.Elevation = zeros(size(atmosphere.values));

            for i = 1 : N_e
                for j = 1 : N_a
                    Atmosphere.Aziumth(j, i) = atmosphere.values{j, i}.azimuth;
                    Atmosphere.Elevation(j, i) = atmosphere.values{j, i}.elevation;
                end
            end

            Atmosphere.fields = fieldnames(Atmosphere.sky_dome{1, 1}.data);

        end


        function [azimuth, elevation, store] = ...
                    extractField(Atmosphere, SatellitePass, Wavelength, Field)

            azimuth = zeros(size(Atmosphere.data));
            elevation = zeros(size(Atmosphere.data));
            store = zeros(size(Atmosphere.data));

            min_idx = find(Atmosphere.wavelengths == Wavelength);
            [nA, nE] = size(Atmosphere.data);

            for i = 1 : nE
                for j = 1 : nA
                    azimuth(j, i) = Atmosphere.data{j, i}.azimuth;
                    elevation(j, i) = Atmosphere.data{j, i}.elevation;
                    store(j, i) = Atmosphere.data{j, i}.data.(Field)(min_idx);
                end
            end

        end


        function conditions = satellitePassConditions(Atmosphere, ...
                                                      SatellitePass, ...
                                                      Wavelengths, ...
                                                      Field)

            conditions = cell(0, 0);
            nWavelengths = numel(Wavelengths);

            for i = 1 : nWavelengths
                Wavelength = Wavelengths(i);
                azimuth = SatellitePass.Headings(SatellitePass.Elevation_Limit_Flags);
                elevation = SatellitePass.Elevations(SatellitePass.Elevation_Limit_Flags);

                reorderAngles = @(angles) mod((angles - 180), 360);
                azimuth = reorderAngles(azimuth);

                [atmos_azimuth, atmos_elevation, store] = Atmosphere.extractField(...
                                    SatellitePass, Wavelength, Field);

                [X, Y] = meshgrid(unique(atmos_azimuth), unique(atmos_elevation));
                [newX, newY] = meshgrid(azimuth, elevation);
                Vq = interp2(X, Y, store', newX, newY, 'cubic', 0);

                condition.pass_elevation = elevation;
                condition.pass_azimuth = azimuth;
                condition.sky_dome_azimuth = atmos_azimuth;
                condition.sky_dome_elevation = atmos_elevation;
                condition.sky_dome = store;
                condition.interpolated_sky_dome = Vq;
                condition.interpolated_azimuth = newX;
                condition.interpolated_elevation = newY;
                condition.field = Field;
                condition.wavelength = Wavelength;
                conditions(i) = {condition};
            end

            if (1 == nWavelengths)
                conditions = conditions{1};
            end

        end

        function fig = plotSurfaceForCondition(Atmosphere, Condition)

            clean_field = replace(Condition.field, '_', ' ');
            fig_title = sprintf('%s around ground station @ %.3g', ...
                                clean_field, Condition.wavelength);

            fig = figure(name = fig_title);
            grid on
            hold on
            N = numel(Condition.pass_elevation);
            line_data = Condition.interpolated_sky_dome(eye(N) == 1);
            plot3(Condition.pass_azimuth, ...
                  Condition.pass_elevation, ...
                  line_data, LineWidth=3, Color='black')
            surf(Condition.interpolated_azimuth, ...
                 Condition.interpolated_elevation, ...
                 Condition.interpolated_sky_dome)
            colormap(summer)
            shading interp
            hold off
            xlim([min(Condition.pass_azimuth), max(Condition.pass_azimuth)])
            ylim([min(Condition.pass_elevation), max(Condition.pass_elevation)])
            zlim([min(min(Condition.interpolated_sky_dome)), ...
                  max(max(Condition.interpolated_sky_dome))])
            xlabel('Aziumth \circ');
            ylabel('Elevation \circ');
            zlabel(sprintf('%s @ %.3gnm', clean_field, Condition.wavelength));
            title(fig_title);

        end

        function fig = plotContourForField(Atmosphere, SatellitePass, Wavelength, Field)

            [atmos_azimuth, atmos_elevation, store] = Atmosphere.extractField(...
                SatellitePass, Wavelength, Field);

            clean_field = replace(Field, '_', ' ');
            fig_title = sprintf('%s around ground station @ %.3g', ...
                                clean_field, Wavelength);
            fig = figure(name = fig_title);
            contourf(atmos_azimuth, atmos_elevation, store);
            xlim([min(min(atmos_azimuth)), ...
                  max(max(atmos_azimuth))])
            ylim([min(min(atmos_elevation)), ...
                  max(max(atmos_elevation))])
            xlabel('Aziumth \circ');
            ylabel('Elevation \circ');
            title(fig_title);

        end

        function fig = plotSurfaceForField(Atmosphere, SatellitePass, Wavelength, Field)
            [atmos_azimuth, atmos_elevation, store] = Atmosphere.extractField(...
                SatellitePass, Wavelength, Field);

            clean_field = replace(Field, '_', ' ');
            fig_title = sprintf('%s around ground station @ %.3g', ...
                                clean_field, Wavelength);
            fig = figure(name = fig_title);
            grid on
            hold on
            surf(atmos_azimuth, atmos_elevation, store);
            xlim([min(min(atmos_azimuth)), ...
                  max(max(atmos_azimuth))])
            ylim([min(min(atmos_elevation)), ...
                  max(max(atmos_elevation))])
            colormap(summer)
            shading interp
            xlabel('Aziumth \circ');
            ylabel('Elevation \circ');
            zlabel(sprintf('%s @ %.3gnm', clean_field, Wavelength));
            title(fig_title);
            hold off

        end

    end

end
